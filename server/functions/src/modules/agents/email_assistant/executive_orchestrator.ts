import {Genkit, ToolAction, z} from "genkit";
import {MessageData} from "@genkit-ai/ai/lib/model-types";
import {logger} from "firebase-functions";
import {AgentMood} from "../../../models.pb/agents/agent";
import {GeminiModelsConfig, GeminiModelsMoods} from "../gemini_models_config";

export enum AgentTraceStatus {
    Completed = "completed",
    Skipped = "skipped",
    Failed = "failed",
}

const ZodAgentId = z.enum([
    "email_triage_agent",
    "calendar_planning_agent",
    "drafting_agent",
]);

export const ZodAgentTraceStep = z.object({
    agentId: ZodAgentId,
    displayName: z.string().min(1),
    reason: z.string().min(1),
    status: z.nativeEnum(AgentTraceStatus),
    inputSummary: z.string().min(1),
    outputSummary: z.string().min(1),
    evidenceIds: z.array(z.string()).default([]),
});

export const ZodAgentCollaborationTrace = z.object({
    agentTrace: z.array(ZodAgentTraceStep),
});

const ZodSpecialistReport = z.object({
    summary: z.string().default(""),
    keyFindings: z.array(z.string()).default([]),
    recommendedActions: z.array(z.string()).default([]),
    evidenceIds: z.array(z.string()).default([]),
    suggestedDrafts: z.array(z.object({
        recipient: z.string().default(""),
        subject: z.string().default(""),
        body: z.string().default(""),
        reason: z.string().default(""),
    })).default([]),
});

export type AgentId = z.infer<typeof ZodAgentId>;
export type AgentTraceStep = z.infer<typeof ZodAgentTraceStep>;
export type AgentCollaborationTrace = z.infer<typeof ZodAgentCollaborationTrace>;
export type SpecialistReport = z.infer<typeof ZodSpecialistReport>;

type SpecialistConfig = {
    agentId: AgentId;
    displayName: string;
    reason: string;
    systemPrompt: string;
    inputSummary: string;
    tools: ToolAction[];
    priorReports?: Record<string, SpecialistReport | null>;
};

type ExecutiveOrchestratorInput = {
    ai: Genkit;
    userMessage: string;
    chatHistory: MessageData[];
    emailTools: ToolAction[];
    calendarTools: ToolAction[];
    finalTools: ToolAction[];
    hasCalendarConnection: boolean;
    fastMode?: boolean;
    proMode?: boolean;
    agentMood: AgentMood;
    context: {
        time: {
            iso: string;
            unix: number;
        };
    };
};

type ExecutiveOrchestratorOutput = {
    replyText: string;
    trace: AgentCollaborationTrace;
    traceOutput: string;
};

export function serializeAgentTrace(trace: AgentCollaborationTrace): string {
    return JSON.stringify(ZodAgentCollaborationTrace.parse(trace));
}

export function createSkippedAgentTraceStep(
    agentId: AgentId,
    displayName: string,
    reason: string,
    inputSummary: string,
): AgentTraceStep {
    return ZodAgentTraceStep.parse({
        agentId,
        displayName,
        reason,
        status: AgentTraceStatus.Skipped,
        inputSummary,
        outputSummary: reason,
        evidenceIds: [],
    });
}

export function createFailedAgentTraceStep(
    agentId: AgentId,
    displayName: string,
    reason: string,
    inputSummary: string,
    error: unknown,
): AgentTraceStep {
    return ZodAgentTraceStep.parse({
        agentId,
        displayName,
        reason,
        status: AgentTraceStatus.Failed,
        inputSummary,
        outputSummary: `${displayName} could not complete: ${sanitizeErrorMessage(error)}`,
        evidenceIds: [],
    });
}

export function filterReadOnlyEmailTools<T>(tools: T[]): T[] {
    return tools.filter((tool) => !isEmailSendToolName(getToolName(tool)));
}

function isEmailSendToolName(toolName: string): boolean {
    return toolName === "google_mail_send_email" || toolName === "outlook_mail_send_email";
}

function getToolName(tool: unknown): string {
    const candidate = tool as {
        name?: unknown;
        __action?: { name?: unknown };
        action?: { name?: unknown };
        config?: { name?: unknown };
        __config?: { name?: unknown };
    };
    const possibleNames = [
        candidate.name,
        candidate.__action?.name,
        candidate.action?.name,
        candidate.config?.name,
        candidate.__config?.name,
    ];
    const name = possibleNames.find((value) => typeof value === "string");
    return typeof name === "string" ? name : "";
}

function sanitizeErrorMessage(error: unknown): string {
    const message = error instanceof Error ? error.message : String(error);
    const firstLine = message.split(/\r?\n/)[0]?.trim();
    if (!firstLine) {
        return "unknown error";
    }
    return firstLine.length > 180 ? firstLine.substring(0, 177) + "..." : firstLine;
}

function createCompletedTraceStep(config: SpecialistConfig, report: SpecialistReport): AgentTraceStep {
    return ZodAgentTraceStep.parse({
        agentId: config.agentId,
        displayName: config.displayName,
        reason: config.reason,
        status: AgentTraceStatus.Completed,
        inputSummary: config.inputSummary,
        outputSummary: report.summary || summarizeReport(report),
        evidenceIds: report.evidenceIds,
    });
}

function summarizeReport(report: SpecialistReport): string {
    const findings = report.keyFindings.slice(0, 3).join("; ");
    const actions = report.recommendedActions.slice(0, 3).join("; ");
    return findings || actions || "Specialist completed with no notable findings.";
}

function formatReportForPrompt(label: string, report: SpecialistReport | null): string {
    if (!report) {
        return `${label}: unavailable`;
    }
    return `${label}: ${JSON.stringify(report)}`;
}

function formatPriorReportsForPrompt(priorReports?: Record<string, SpecialistReport | null>): string {
    if (!priorReports) {
        return "";
    }
    return `Prior specialist reports: ${JSON.stringify(priorReports)}`;
}

function modelForMode(fastMode?: boolean, proMode?: boolean) {
    if (fastMode) {
        return GeminiModelsConfig.fastModel;
    }
    if (proMode) {
        return GeminiModelsConfig.proModel;
    }
    return GeminiModelsConfig.normalModel;
}

export class ExecutiveOrchestrator {
    static async run(input: ExecutiveOrchestratorInput): Promise<ExecutiveOrchestratorOutput> {
        const trace: AgentTraceStep[] = [];
        const emailReport = await ExecutiveOrchestrator.runSpecialist(input, {
            agentId: "email_triage_agent",
            displayName: "Email Triage Agent",
            reason: "Search inbox context, rank urgent messages, and extract actions.",
            inputSummary: "Review the selected email integrations for the user's executive request.",
            tools: filterReadOnlyEmailTools(input.emailTools),
            systemPrompt: EMAIL_TRIAGE_SYSTEM_PROMPT,
        }, trace);

        let calendarReport: SpecialistReport | null = null;
        if (input.hasCalendarConnection && input.calendarTools.length > 0) {
            calendarReport = await ExecutiveOrchestrator.runSpecialist(input, {
                agentId: "calendar_planning_agent",
                displayName: "Calendar Planning Agent",
                reason: "Review calendar context, conflicts, and scheduling windows.",
                inputSummary: "Inspect the selected calendar integrations for conflicts and available time.",
                tools: input.calendarTools,
                systemPrompt: CALENDAR_PLANNING_SYSTEM_PROMPT,
            }, trace);
        } else {
            trace.push(createSkippedAgentTraceStep(
                "calendar_planning_agent",
                "Calendar Planning Agent",
                "No active calendar connection was selected.",
                "Inspect calendar context for conflicts and availability.",
            ));
        }

        const draftingReport = await ExecutiveOrchestrator.runSpecialist(input, {
            agentId: "drafting_agent",
            displayName: "Drafting Agent",
            reason: "Draft safe reply and follow-up recommendations from specialist reports.",
            inputSummary: "Use email and calendar reports to prepare response drafts without sending anything.",
            tools: [],
            priorReports: {
                emailReport,
                calendarReport,
            },
            systemPrompt: DRAFTING_SYSTEM_PROMPT,
        }, trace);

        const replyText = await ExecutiveOrchestrator.generateFinalResponse(input, {
            emailReport,
            calendarReport,
            draftingReport,
            trace,
        });
        const collaborationTrace = ZodAgentCollaborationTrace.parse({agentTrace: trace});
        return {
            replyText,
            trace: collaborationTrace,
            traceOutput: serializeAgentTrace(collaborationTrace),
        };
    }

    private static async runSpecialist(
        input: ExecutiveOrchestratorInput,
        config: SpecialistConfig,
        trace: AgentTraceStep[],
    ): Promise<SpecialistReport | null> {
        try {
            const response = await input.ai.generate({
                model: modelForMode(input.fastMode, input.proMode),
                messages: ExecutiveOrchestrator.buildSpecialistMessages(input, config),
                tools: config.tools,
                maxTurns: config.tools.length > 0 ? 8 : 1,
                context: input.context,
                config: GeminiModelsMoods.getMoodConfig(input.agentMood),
                output: {
                    schema: ZodSpecialistReport,
                },
            });

            const report = ZodSpecialistReport.parse(response.output || {
                summary: response.text || `${config.displayName} completed.`,
                keyFindings: response.text ? [response.text] : [],
                recommendedActions: [],
                evidenceIds: [],
                suggestedDrafts: [],
            });
            trace.push(createCompletedTraceStep(config, report));
            return report;
        } catch (e) {
            logger.error(`${config.agentId} failed`, e);
            trace.push(createFailedAgentTraceStep(
                config.agentId,
                config.displayName,
                config.reason,
                config.inputSummary,
                e,
            ));
            return null;
        }
    }

    private static buildSpecialistMessages(input: ExecutiveOrchestratorInput, config: SpecialistConfig): MessageData[] {
        return [
            {
                role: "system",
                content: [{text: config.systemPrompt}],
            },
            ...input.chatHistory,
            {
                role: "user",
                content: [{
                    text: [
                        `Executive request: ${input.userMessage}`,
                        `Current server time: ${input.context.time.iso}`,
                        formatPriorReportsForPrompt(config.priorReports),
                        "Return concise structured output only.",
                    ].filter(Boolean).join("\n\n"),
                }],
            },
        ];
    }

    private static async generateFinalResponse(
        input: ExecutiveOrchestratorInput,
        reports: {
            emailReport: SpecialistReport | null;
            calendarReport: SpecialistReport | null;
            draftingReport: SpecialistReport | null;
            trace: AgentTraceStep[];
        },
    ): Promise<string> {
        const response = await input.ai.generate({
            model: modelForMode(input.fastMode, input.proMode),
            messages: [
                {
                    role: "system",
                    content: [{text: FINAL_ORCHESTRATOR_SYSTEM_PROMPT}],
                },
                ...input.chatHistory,
                {
                    role: "user",
                    content: [{
                        text: [
                            `Executive request: ${input.userMessage}`,
                            `Current server time: ${input.context.time.iso}`,
                            formatReportForPrompt("Email triage report", reports.emailReport),
                            formatReportForPrompt("Calendar planning report", reports.calendarReport),
                            formatReportForPrompt("Drafting report", reports.draftingReport),
                            `Collaboration trace: ${serializeAgentTrace({agentTrace: reports.trace})}`,
                        ].join("\n\n"),
                    }],
                },
            ],
            tools: input.finalTools,
            maxTurns: input.finalTools.length > 0 ? 4 : 1,
            context: input.context,
            config: GeminiModelsMoods.getMoodConfig(input.agentMood),
        });

        if (!response.text || response.text.trim() === "") {
            throw new Error("Executive Orchestrator returned an empty response");
        }
        return response.text;
    }
}

const EMAIL_TRIAGE_SYSTEM_PROMPT = [
    "You are email_triage_agent, a specialist inside Semur's executive assistant workflow.",
    "Use only the provided read-only email tools. Never send email.",
    "Search for messages relevant to the executive request, rank urgent or action-required items, and identify evidence email IDs.",
    "Keep the report factual. If tools fail or return no results, say so in the structured output.",
].join("\n");

const CALENDAR_PLANNING_SYSTEM_PROMPT = [
    "You are calendar_planning_agent, a specialist inside Semur's executive assistant workflow.",
    "Use the provided calendar tools to inspect relevant schedule context, conflicts, and practical availability windows.",
    "Keep the report factual and include calendar event IDs as evidence when available.",
].join("\n");

const DRAFTING_SYSTEM_PROMPT = [
    "You are drafting_agent, a specialist inside Semur's executive assistant workflow.",
    "You do not have tools and must not send email.",
    "Use the prior specialist reports to draft concise reply or follow-up recommendations that are safe for the user to review.",
].join("\n");

const FINAL_ORCHESTRATOR_SYSTEM_PROMPT = [
    "You are Executive Orchestrator for Semur's executive email and calendar assistant.",
    "Combine specialist reports into one concise, professional answer for the user.",
    "If a specialist was skipped or failed, mention the limitation briefly and continue with the available context.",
    "Do not claim that any email was sent. Drafts are suggestions for user review only.",
    "Use Markdown for clear sections when helpful.",
].join("\n");
