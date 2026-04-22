import {SemurEngineErrorCode} from "../../../../models.pb/semur-engine/semur_engine";
import {
    AgentTraceStatus,
    AgentTraceStep,
    serializeAgentTrace,
} from "../executive_orchestrator";
import {
    DemoCalendarEvent,
    DEMO_SAMPLE_PROMPT,
    demoCalendarEvents,
    demoEmails,
} from "./demo_fixtures";

export {DEMO_SAMPLE_PROMPT} from "./demo_fixtures";

type DemoChatInput = {
    userMessage?: string;
    sessionId?: string;
};

export type DemoChatOutput = {
    error: SemurEngineErrorCode;
    message: string;
    chatOutput: string;
    agentTraceOutput: string;
};

type DemoSpecialistReport = {
    summary: string;
    keyFindings: string[];
    recommendedActions: string[];
    evidenceIds: string[];
    suggestedDrafts: {
        recipient: string;
        subject: string;
        body: string;
        reason: string;
    }[];
};

export function runDemoEmailAssistant(input: DemoChatInput = {}): DemoChatOutput {
    const userMessage = normalizeUserMessage(input.userMessage);
    const emailReport = runDemoEmailTriageAgent();
    const calendarReport = runDemoCalendarPlanningAgent();
    const draftingReport = runDemoDraftingAgent(emailReport, calendarReport);
    const trace = [
        createCompletedTraceStep(
            "email_triage_agent",
            "Email Triage Agent",
            "Search demo inbox context, rank urgent messages, and extract actions.",
            `Review fixture inbox for: ${userMessage}`,
            emailReport,
        ),
        createCompletedTraceStep(
            "calendar_planning_agent",
            "Calendar Planning Agent",
            "Inspect demo calendar context, conflicts, and available windows.",
            "Review tomorrow's fixture calendar for conflicts before noon.",
            calendarReport,
        ),
        createCompletedTraceStep(
            "drafting_agent",
            "Drafting Agent",
            "Draft safe replies and follow-up recommendations from specialist reports.",
            "Use demo email and calendar reports to prepare review-only drafts.",
            draftingReport,
        ),
    ];

    return {
        error: SemurEngineErrorCode.NO_ERROR,
        message: "Success",
        chatOutput: buildFinalDemoResponse(userMessage, emailReport, calendarReport, draftingReport),
        agentTraceOutput: serializeAgentTrace({agentTrace: trace}),
    };
}

function normalizeUserMessage(userMessage?: string): string {
    const trimmed = userMessage?.trim();
    return trimmed && trimmed.length > 0 ? trimmed : DEMO_SAMPLE_PROMPT;
}

function runDemoEmailTriageAgent(): DemoSpecialistReport {
    const rankedEmails = [...demoEmails].sort((a, b) => b.importanceScore - a.importanceScore);
    const urgentEmails = rankedEmails.filter((email) => email.actionRequiredBeforeNoon);
    return {
        summary: `Found ${urgentEmails.length} inbox items that need action before noon, led by the board packet decision.`,
        keyFindings: urgentEmails.map((email) => `${email.subject} from ${email.sender}`),
        recommendedActions: [
            "Decide whether the board packet launch budget slide should be held or approved before the 10 AM prep call.",
            "Send procurement status to Atlas Vendors before noon so the preferred implementation slot is preserved.",
        ],
        evidenceIds: urgentEmails.map((email) => email.id),
        suggestedDrafts: [],
    };
}

function runDemoCalendarPlanningAgent(): DemoSpecialistReport {
    const conflicts = findConflicts(demoCalendarEvents);
    return {
        summary: "Tomorrow has a conflict between board prep and product review from 10:00-10:30 AM Eastern.",
        keyFindings: [
            "Board prep overlaps product review by 30 minutes.",
            "The 11:30 AM focus window is the safest slot for follow-up decisions and draft review.",
        ],
        recommendedActions: [
            "Ask the product team to shift the analytics decision until after board prep or delegate the first 30 minutes.",
            "Use the focus window to review the two reply drafts before noon.",
        ],
        evidenceIds: conflicts.flatMap((conflict) => [conflict.first.id, conflict.second.id]),
        suggestedDrafts: [],
    };
}

function runDemoDraftingAgent(
    emailReport: DemoSpecialistReport,
    calendarReport: DemoSpecialistReport,
): DemoSpecialistReport {
    return {
        summary: "Prepared two review-only reply drafts tied to the urgent inbox actions and calendar conflict.",
        keyFindings: [
            "The board packet reply should acknowledge the risk note and ask for the launch budget slide to be held.",
            "The vendor reply should preserve the implementation slot while procurement finishes review.",
        ],
        recommendedActions: [
            "Review the board packet draft first because it affects the 10 AM prep call.",
            "Review the vendor draft before the 11:30 AM focus window ends.",
        ],
        evidenceIds: unique([
            ...emailReport.evidenceIds,
            ...calendarReport.evidenceIds,
        ]),
        suggestedDrafts: [
            {
                recipient: "maya.chen@northstar.example",
                subject: "Re: Board packet needs your decision before 10 AM",
                body: "Maya, thanks for flagging the late risk note. Please hold the launch budget slide for the prep call " +
                    "so we can review the legal update before approving the final packet.",
                reason: "Keeps the board packet decision aligned with the calendar conflict and risk review.",
            },
            {
                recipient: "priya@atlas-vendors.example",
                subject: "Re: Contract signature window closes tomorrow",
                body: "Priya, please hold the preferred implementation slot through tomorrow afternoon while procurement " +
                    "finishes review. I will confirm the signature timing after our morning decision window.",
                reason: "Preserves the vendor slot without overcommitting before procurement review completes.",
            },
        ],
    };
}

function findConflicts(events: DemoCalendarEvent[]): { first: DemoCalendarEvent; second: DemoCalendarEvent }[] {
    const sortedEvents = [...events].sort((a, b) => Date.parse(a.start) - Date.parse(b.start));
    const conflicts = [];
    for (let i = 0; i < sortedEvents.length - 1; i++) {
        const current = sortedEvents[i];
        const next = sortedEvents[i + 1];
        if (Date.parse(current.end) > Date.parse(next.start)) {
            conflicts.push({first: current, second: next});
        }
    }
    return conflicts;
}

function createCompletedTraceStep(
    agentId: AgentTraceStep["agentId"],
    displayName: string,
    reason: string,
    inputSummary: string,
    report: DemoSpecialistReport,
): AgentTraceStep {
    return {
        agentId,
        displayName,
        reason,
        status: AgentTraceStatus.Completed,
        inputSummary,
        outputSummary: report.summary,
        evidenceIds: report.evidenceIds,
    };
}

function buildFinalDemoResponse(
    userMessage: string,
    emailReport: DemoSpecialistReport,
    calendarReport: DemoSpecialistReport,
    draftingReport: DemoSpecialistReport,
): string {
    const drafts = draftingReport.suggestedDrafts.map((draft) => [
        `**To:** ${draft.recipient}`,
        `**Subject:** ${draft.subject}`,
        draft.body,
        `Reason: ${draft.reason}`,
    ].join("\n")).join("\n\n");

    return [
        "## Executive Demo Result",
        `Prompt: ${userMessage}`,
        `**Email Triage Agent:** ${emailReport.summary}`,
        `**Calendar Planning Agent:** ${calendarReport.summary}`,
        `**Drafting Agent:** ${draftingReport.summary}`,
        "### Recommended Order",
        ...emailReport.recommendedActions.map((action, index) => `${index + 1}. ${action}`),
        ...calendarReport.recommendedActions.map((action, index) => `${index + 3}. ${action}`),
        "### Drafts For Review",
        drafts,
        "Drafts are suggestions for user review only.",
    ].join("\n\n");
}

function unique(values: string[]): string[] {
    return [...new Set(values)];
}
