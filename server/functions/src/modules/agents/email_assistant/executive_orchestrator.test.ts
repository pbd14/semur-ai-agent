import test, {mock} from "node:test";
import assert from "node:assert/strict";
import {Genkit, ToolAction} from "genkit";
import {logger} from "firebase-functions";
import {AgentMood} from "../../../models.pb/agents/agent";
import {
    AgentTraceStatus,
    createFailedAgentTraceStep,
    createSkippedAgentTraceStep,
    ExecutiveOrchestrator,
    filterReadOnlyEmailTools,
    serializeAgentTrace,
    shouldRunDraftingAgent,
} from "./executive_orchestrator";

type GenerateOptions = {
    messages: {
        role: string;
        content: { text?: string }[];
    }[];
    tools?: ToolAction[];
    maxTurns?: number;
    config?: Record<string, unknown>;
};

type GenerateResponse = {
    output?: unknown;
    text?: string;
};

type ToolWithRegistry = ToolAction & {
    __action?: {
        name?: string;
        metadata?: {
            dynamic?: boolean;
            type?: string;
        };
    };
    __registry?: unknown;
};

function tool(name: string): ToolAction {
    return {name} as unknown as ToolAction;
}

function dynamicTool(name: string): ToolAction {
    return {
        __action: {
            name,
            metadata: {
                dynamic: true,
                type: "tool",
            },
        },
    } as unknown as ToolAction;
}

function createMockAi(responses: (GenerateResponse | Error)[]) {
    const calls: GenerateOptions[] = [];
    return {
        ai: {
            generate: async (options: GenerateOptions): Promise<GenerateResponse> => {
                calls.push(options);
                const response = responses.shift();
                if (response instanceof Error) {
                    throw response;
                }
                assert(response, "mock generate response was not configured");
                return response;
            },
        } as unknown as Genkit,
        calls,
    };
}

function specialistOutput(summary: string, evidenceIds: string[] = []): GenerateResponse {
    return {
        output: {
            summary,
            keyFindings: [summary],
            recommendedActions: [`Act on ${summary}`],
            evidenceIds,
            suggestedDrafts: [],
        },
    };
}

function baseRunInput(ai: Genkit, overrides: Partial<Parameters<typeof ExecutiveOrchestrator.run>[0]> = {}) {
    return {
        ai,
        userMessage: "Review my inbox and calendar before noon and draft follow-up suggestions.",
        chatHistory: [],
        emailTools: [
            tool("google_mail_search_common_filters"),
            tool("google_mail_send_email"),
        ],
        calendarTools: [tool("google_calendar_search_events")],
        finalTools: [tool("email_assistant_mention_email")],
        hasCalendarConnection: true,
        fastMode: false,
        proMode: false,
        agentMood: AgentMood.NORMAL,
        context: {
            time: {
                iso: "2026-04-22T12:00:00.000Z",
                unix: 1776859200,
            },
        },
        ...overrides,
    };
}

test("serializeAgentTrace stores valid collaboration trace JSON", () => {
    const serialized = serializeAgentTrace({
        agentTrace: [
            {
                agentId: "email_triage_agent",
                displayName: "Email Triage Agent",
                reason: "Identify urgent inbox actions.",
                status: AgentTraceStatus.Completed,
                inputSummary: "Review tomorrow's inbox pressure.",
                outputSummary: "Found two urgent replies.",
                evidenceIds: ["email-1", "email-2"],
            },
        ],
    });

    assert.deepEqual(JSON.parse(serialized), {
        agentTrace: [
            {
                agentId: "email_triage_agent",
                displayName: "Email Triage Agent",
                reason: "Identify urgent inbox actions.",
                status: "completed",
                inputSummary: "Review tomorrow's inbox pressure.",
                outputSummary: "Found two urgent replies.",
                evidenceIds: ["email-1", "email-2"],
            },
        ],
    });
});

test("createSkippedAgentTraceStep records skipped calendar specialist", () => {
    const step = createSkippedAgentTraceStep(
        "calendar_planning_agent",
        "Calendar Planning Agent",
        "No active calendar connection was selected.",
        "Review tomorrow for conflicts.",
    );

    assert.equal(step.agentId, "calendar_planning_agent");
    assert.equal(step.status, AgentTraceStatus.Skipped);
    assert.equal(step.outputSummary, "No active calendar connection was selected.");
    assert.deepEqual(step.evidenceIds, []);
});

test("createFailedAgentTraceStep records failed specialist without exposing stack traces", () => {
    const step = createFailedAgentTraceStep(
        "drafting_agent",
        "Drafting Agent",
        "Draft safe replies.",
        "Use the specialist reports.",
        new Error("model timed out\n    at secret/path.ts:10:2"),
    );

    assert.equal(step.status, AgentTraceStatus.Failed);
    assert.equal(step.outputSummary, "Drafting Agent could not complete: model timed out");
    assert(!step.outputSummary.includes("secret/path"));
});

test("filterReadOnlyEmailTools excludes email sending tools for specialists", () => {
    const tools = [
        {name: "google_mail_search_common_filters"},
        {name: "google_mail_send_email"},
        {__action: {name: "outlook_mail_vector_search"}},
        {__action: {name: "outlook_mail_send_email"}},
    ];

    const filtered = filterReadOnlyEmailTools(tools);

    assert.deepEqual(filtered, [
        {name: "google_mail_search_common_filters"},
        {__action: {name: "outlook_mail_vector_search"}},
    ]);
});

test("shouldRunDraftingAgent only routes requests that need draft text", () => {
    assert.equal(shouldRunDraftingAgent("Just summarize my emails."), false);
    assert.equal(shouldRunDraftingAgent("Review my inbox and write reply drafts for urgent messages."), true);
    assert.equal(shouldRunDraftingAgent("Help me respond to Maya about the contract."), true);
    assert.equal(shouldRunDraftingAgent("Which emails need follow up today?"), false);
});

test("ExecutiveOrchestrator.run routes specialists and aggregates the final response", async () => {
    const {ai, calls} = createMockAi([
        specialistOutput("Email triage found two urgent items.", ["email-1"]),
        specialistOutput("Calendar planning found one conflict.", ["event-1"]),
        specialistOutput("Drafting prepared two review-only drafts.", ["email-1", "event-1"]),
        {text: "Final executive recommendation."},
    ]);

    const output = await ExecutiveOrchestrator.run(baseRunInput(ai));

    assert.equal(output.replyText, "Final executive recommendation.");
    assert.equal(calls.length, 4);
    assert.deepEqual(calls[0].tools?.map((candidate) => (candidate as { name?: string }).name), [
        "google_mail_search_common_filters",
    ]);
    assert.deepEqual(calls[1].tools?.map((candidate) => (candidate as { name?: string }).name), [
        "google_calendar_search_events",
    ]);
    assert.deepEqual(calls[2].tools, []);
    assert.deepEqual(calls[3].tools?.map((candidate) => (candidate as { name?: string }).name), [
        "email_assistant_mention_email",
    ]);
    assert.deepEqual(output.trace.agentTrace.map((step) => step.agentId), [
        "email_triage_agent",
        "calendar_planning_agent",
        "drafting_agent",
    ]);
    assert.deepEqual(output.trace.agentTrace.map((step) => step.status), [
        AgentTraceStatus.Completed,
        AgentTraceStatus.Completed,
        AgentTraceStatus.Completed,
    ]);
    assert(JSON.parse(output.traceOutput).agentTrace[0].evidenceIds.includes("email-1"));

    const finalPrompt = calls[3].messages.at(-1)?.content[0].text || "";
    assert.match(finalPrompt, /Email triage found two urgent items/);
    assert.match(finalPrompt, /Calendar planning found one conflict/);
    assert.match(finalPrompt, /Drafting prepared two review-only drafts/);
    assert.match(finalPrompt, /Collaboration trace/);

    assert.equal(calls[0].config?.maxOutputTokens, 1400);
    assert.equal(calls[2].config?.maxOutputTokens, 900);
    assert.equal(calls[3].config?.maxOutputTokens, 1800);
});

test("ExecutiveOrchestrator.run skips drafting specialist for summary-only requests", async () => {
    const {ai, calls} = createMockAi([
        specialistOutput("Email triage summarized recent messages.", ["email-1"]),
        {text: "Inbox summary only."},
    ]);

    const output = await ExecutiveOrchestrator.run(baseRunInput(ai, {
        userMessage: "Just summarize my emails.",
        calendarTools: [],
        finalTools: [],
        hasCalendarConnection: false,
    }));

    assert.equal(output.replyText, "Inbox summary only.");
    assert.equal(calls.length, 2);
    assert.deepEqual(output.trace.agentTrace.map((step) => step.agentId), [
        "email_triage_agent",
        "calendar_planning_agent",
        "drafting_agent",
    ]);
    assert.deepEqual(output.trace.agentTrace.map((step) => step.status), [
        AgentTraceStatus.Completed,
        AgentTraceStatus.Skipped,
        AgentTraceStatus.Skipped,
    ]);
    assert.equal(output.trace.agentTrace[2].outputSummary, "The request did not ask for reply drafts or follow-up message text.");
});

test("ExecutiveOrchestrator.run can reuse a dynamic mention tool across generate phases", async () => {
    const mentionTool = dynamicTool("semur_chat_mention_email");
    const registryStateAtMentionCalls: unknown[] = [];
    const responses = [
        specialistOutput("Email triage found one urgent item.", ["email-1"]),
        specialistOutput("Drafting prepared one review-only draft.", ["email-1"]),
        {text: "Final response with mentioned email."},
    ];
    const ai = {
        generate: async (options: GenerateOptions): Promise<GenerateResponse> => {
            for (const candidate of options.tools || []) {
                const toolCandidate = candidate as ToolWithRegistry;
                const registryCarrier = candidate as unknown as { __registry?: unknown };
                if (toolCandidate.__action?.name === "semur_chat_mention_email") {
                    registryStateAtMentionCalls.push(registryCarrier.__registry);
                }
                if (toolCandidate.__action?.metadata?.dynamic === true) {
                    registryCarrier.__registry = {stale: true};
                }
            }
            const response = responses.shift();
            assert(response, "mock generate response was not configured");
            return response;
        },
    } as unknown as Genkit;

    const output = await ExecutiveOrchestrator.run(baseRunInput(ai, {
        emailTools: [
            mentionTool,
            tool("google_mail_search_common_filters"),
        ],
        calendarTools: [],
        finalTools: [mentionTool],
        hasCalendarConnection: false,
    }));

    assert.equal(output.replyText, "Final response with mentioned email.");
    assert.deepEqual(registryStateAtMentionCalls, [undefined, undefined]);
});

test("ExecutiveOrchestrator.run skips calendar specialist when no calendar connection is selected", async () => {
    const {ai, calls} = createMockAi([
        specialistOutput("Email-only request reviewed.", ["email-1"]),
        specialistOutput("Drafting prepared email-only draft.", ["email-1"]),
        {text: "Final email-only recommendation."},
    ]);

    const output = await ExecutiveOrchestrator.run(baseRunInput(ai, {
        calendarTools: [],
        hasCalendarConnection: false,
    }));

    assert.equal(calls.length, 3);
    assert.deepEqual(output.trace.agentTrace.map((step) => step.agentId), [
        "email_triage_agent",
        "calendar_planning_agent",
        "drafting_agent",
    ]);
    assert.equal(output.trace.agentTrace[1].status, AgentTraceStatus.Skipped);
    assert.equal(output.trace.agentTrace[1].outputSummary, "No active calendar connection was selected.");

    const draftingPrompt = calls[1].messages.at(-1)?.content[0].text || "";
    assert.match(draftingPrompt, /"calendarReport":null/);
});

test("ExecutiveOrchestrator.run records specialist failures and still produces a final response", async () => {
    const loggerError = mock.method(logger, "error", () => undefined);
    const {ai, calls} = createMockAi([
        new Error("email model timed out\n    at private/path.ts:5:1"),
        specialistOutput("Calendar planning found open time.", ["event-1"]),
        specialistOutput("Drafting used available calendar context.", ["event-1"]),
        {text: "Final response using partial context."},
    ]);

    try {
        const output = await ExecutiveOrchestrator.run(baseRunInput(ai));

        assert.equal(output.replyText, "Final response using partial context.");
        assert.equal(calls.length, 4);
        assert.equal(output.trace.agentTrace[0].agentId, "email_triage_agent");
        assert.equal(output.trace.agentTrace[0].status, AgentTraceStatus.Failed);
        assert.equal(
            output.trace.agentTrace[0].outputSummary,
            "Email Triage Agent could not complete: email model timed out",
        );
        assert(!output.trace.agentTrace[0].outputSummary.includes("private/path"));
    } finally {
        loggerError.mock.restore();
    }
});

test("ExecutiveOrchestrator.run keeps drafting review-only and keeps send tools away from Semur specialists", async () => {
    const {ai, calls} = createMockAi([
        specialistOutput("Email triage reviewed messages.", ["email-1"]),
        specialistOutput("Calendar planning reviewed schedule.", ["event-1"]),
        specialistOutput("Drafting prepared suggestions only.", ["email-1"]),
        {text: "Review these drafts before sending anything."},
    ]);

    await ExecutiveOrchestrator.run(baseRunInput(ai, {
        emailTools: [
            tool("google_mail_send_email"),
            tool("outlook_mail_send_email"),
            tool("outlook_mail_vector_search"),
        ],
    }));

    assert.deepEqual(calls[0].tools?.map((candidate) => (candidate as { name?: string }).name), [
        "outlook_mail_vector_search",
    ]);
    assert.deepEqual(calls[2].tools, []);

    const draftingSystemPrompt = calls[2].messages[0].content[0].text || "";
    const finalSystemPrompt = calls[3].messages[0].content[0].text || "";
    assert.match(draftingSystemPrompt, /must not send email/i);
    assert.match(draftingSystemPrompt, /safe for the user to review/i);
    assert.match(finalSystemPrompt, /Do not claim that any email was sent/i);
    assert.match(finalSystemPrompt, /Drafts are suggestions for user review only/i);
});
