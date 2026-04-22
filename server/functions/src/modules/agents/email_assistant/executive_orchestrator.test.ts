import test from "node:test";
import assert from "node:assert/strict";
import {
    AgentTraceStatus,
    createFailedAgentTraceStep,
    createSkippedAgentTraceStep,
    filterReadOnlyEmailTools,
    serializeAgentTrace,
} from "./executive_orchestrator";

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
