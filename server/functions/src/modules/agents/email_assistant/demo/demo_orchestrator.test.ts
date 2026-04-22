import test from "node:test";
import assert from "node:assert/strict";
import {SemurEngineErrorCode} from "../../../../models.pb/semur-engine/semur_engine";
import {
    DEMO_SAMPLE_PROMPT,
    runDemoEmailAssistant,
} from "./demo_orchestrator";

test("runDemoEmailAssistant returns a deterministic successful demo response without secrets", () => {
    const originalNangoSecret = process.env.NANGO_SECRET_KEY_DEV;
    const originalGoogleSecret = process.env.GOOGLE_GENAI_API_KEY;
    delete process.env.NANGO_SECRET_KEY_DEV;
    delete process.env.GOOGLE_GENAI_API_KEY;

    try {
        const output = runDemoEmailAssistant({
            userMessage: DEMO_SAMPLE_PROMPT,
            sessionId: "demo-test-session",
        });

        assert.equal(output.error, SemurEngineErrorCode.NO_ERROR);
        assert.equal(output.message, "Success");
        assert.match(output.chatOutput, /Email Triage Agent/i);
        assert.match(output.chatOutput, /Calendar Planning Agent/i);
        assert.match(output.chatOutput, /Drafting Agent/i);
        assert.match(output.chatOutput, /draft/i);
    } finally {
        if (originalNangoSecret === undefined) {
            delete process.env.NANGO_SECRET_KEY_DEV;
        } else {
            process.env.NANGO_SECRET_KEY_DEV = originalNangoSecret;
        }
        if (originalGoogleSecret === undefined) {
            delete process.env.GOOGLE_GENAI_API_KEY;
        } else {
            process.env.GOOGLE_GENAI_API_KEY = originalGoogleSecret;
        }
    }
});

test("runDemoEmailAssistant includes three completed specialist trace steps with evidence", () => {
    const output = runDemoEmailAssistant({
        userMessage: DEMO_SAMPLE_PROMPT,
        sessionId: "demo-test-session",
    });
    const trace = JSON.parse(output.agentTraceOutput);

    assert.deepEqual(
        trace.agentTrace.map((step: {agentId: string}) => step.agentId),
        [
            "email_triage_agent",
            "calendar_planning_agent",
            "drafting_agent",
        ],
    );
    assert.deepEqual(
        trace.agentTrace.map((step: {status: string}) => step.status),
        ["completed", "completed", "completed"],
    );
    assert(trace.agentTrace[0].evidenceIds.includes("demo-email-board-review"));
    assert(trace.agentTrace[1].evidenceIds.includes("demo-calendar-product-review"));
    assert(trace.agentTrace[2].evidenceIds.includes("demo-email-board-review"));
});

test("runDemoEmailAssistant never claims that email was sent", () => {
    const output = runDemoEmailAssistant({
        userMessage: DEMO_SAMPLE_PROMPT,
        sessionId: "demo-test-session",
    });

    assert.doesNotMatch(output.chatOutput, /\b(i|we|semur)\s+(sent|emailed|delivered)\b/i);
    assert.doesNotMatch(output.chatOutput, /\bhas been sent\b/i);
    assert.match(output.chatOutput, /review/i);
});
