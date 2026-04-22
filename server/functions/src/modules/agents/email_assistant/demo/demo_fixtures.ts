import {AgentCategory} from "../../../../models.pb/agents/agent";
import {
    NangoConnectionStatus,
    NangoIntegrationStatus,
} from "../../../../models.pb/nango/nango";
import {SyncStatus} from "../../../../models.pb/syncs/sync";
import {IntegrationIds} from "../../../../runtime/integration_ids";

export const DEMO_USER_ID = "semur-demo-user";
export const DEMO_SESSION_ID = "semur-demo-session";
export const DEMO_SAMPLE_PROMPT = "Review my inbox and calendar for tomorrow. Identify urgent emails, find scheduling conflicts, " +
    "and draft responses for anything that needs action before noon.";

export type DemoEmail = {
    id: string;
    sender: string;
    senderEmail: string;
    recipients: string;
    date: string;
    subject: string;
    body: string;
    threadId: string;
    importanceScore: number;
    actionRequiredBeforeNoon: boolean;
};

export type DemoCalendarEvent = {
    id: string;
    summary: string;
    description: string;
    start: string;
    end: string;
    attendees: string[];
};

export const demoEmails: DemoEmail[] = [
    {
        id: "demo-email-board-review",
        sender: "Maya Chen",
        senderEmail: "maya.chen@northstar.example",
        recipients: "alex@semur.example",
        date: "2026-04-22T21:15:00.000Z",
        subject: "Board packet needs your decision before 10 AM",
        body: "Alex, legal added a late risk note to the board packet. Please confirm whether we hold the launch budget slide " +
            "or approve it as-is before the 10 AM prep call.",
        threadId: "demo-thread-board-review",
        importanceScore: 0.98,
        actionRequiredBeforeNoon: true,
    },
    {
        id: "demo-email-vendor-contract",
        sender: "Priya Raman",
        senderEmail: "priya@atlas-vendors.example",
        recipients: "alex@semur.example",
        date: "2026-04-22T20:40:00.000Z",
        subject: "Contract signature window closes tomorrow",
        body: "We can hold the preferred implementation slot until noon tomorrow. If procurement needs more time, send a short " +
            "confirmation and I will extend it by one business day.",
        threadId: "demo-thread-vendor-contract",
        importanceScore: 0.91,
        actionRequiredBeforeNoon: true,
    },
    {
        id: "demo-email-product-update",
        sender: "Noah Patel",
        senderEmail: "noah@semur.example",
        recipients: "alex@semur.example",
        date: "2026-04-22T18:05:00.000Z",
        subject: "Product review agenda for tomorrow",
        body: "The team moved the product review to 10 AM. We need your view on whether to cut the analytics demo or extend " +
            "the meeting by 30 minutes.",
        threadId: "demo-thread-product-review",
        importanceScore: 0.82,
        actionRequiredBeforeNoon: false,
    },
];

export const demoCalendarEvents: DemoCalendarEvent[] = [
    {
        id: "demo-calendar-board-prep",
        summary: "Board prep call",
        description: "Review board packet and launch budget risk note.",
        start: "2026-04-23T13:30:00.000Z",
        end: "2026-04-23T14:30:00.000Z",
        attendees: ["maya.chen@northstar.example", "alex@semur.example"],
    },
    {
        id: "demo-calendar-product-review",
        summary: "Product review",
        description: "Review product agenda and decide whether analytics demo stays in scope.",
        start: "2026-04-23T14:00:00.000Z",
        end: "2026-04-23T15:00:00.000Z",
        attendees: ["noah@semur.example", "alex@semur.example"],
    },
    {
        id: "demo-calendar-focus-window",
        summary: "Executive focus window",
        description: "Protected time for decisions and follow-up drafts.",
        start: "2026-04-23T15:30:00.000Z",
        end: "2026-04-23T16:30:00.000Z",
        attendees: ["alex@semur.example"],
    },
];

export const demoSeedData = {
    user: {
        id: DEMO_USER_ID,
        email: "demo@semur.example",
        firstName: "Demo",
        lastName: "Executive",
        birthDate: null,
        status: 2,
        fcmAndroidTokens: [],
        fcmIosTokens: [],
        vapidWebTokens: [],
        language: "en",
        organizationId: "demo-org",
    },
    appData: {
        isWebActive: true,
        emailVerificationRequired: false,
        privacyPolicyLink: "https://example.com/privacy",
        privacyPolicyVersion: 1,
    },
    integrations: [
        {
            id: IntegrationIds.googleMail,
            name: "Gmail Demo",
            status: NangoIntegrationStatus.ACTIVE,
            categories: [AgentCategory.EMAIL],
        },
        {
            id: IntegrationIds.googleCalendar,
            name: "Google Calendar Demo",
            status: NangoIntegrationStatus.ACTIVE,
            categories: [AgentCategory.CALENDAR],
        },
    ],
    connections: [
        {
            id: IntegrationIds.googleMail,
            userId: DEMO_USER_ID,
            connectionId: "demo-google-mail-connection",
            organizationId: "demo-org",
            status: NangoConnectionStatus.NANGO_CONNECTION_ACTIVE,
            provider: IntegrationIds.googleMail,
            authMode: "demo",
            updatedAt: new Date("2026-04-22T12:00:00.000Z"),
        },
        {
            id: IntegrationIds.googleCalendar,
            userId: DEMO_USER_ID,
            connectionId: "demo-google-calendar-connection",
            organizationId: "demo-org",
            status: NangoConnectionStatus.NANGO_CONNECTION_ACTIVE,
            provider: IntegrationIds.googleCalendar,
            authMode: "demo",
            updatedAt: new Date("2026-04-22T12:00:00.000Z"),
        },
    ],
    syncInfo: {
        id: "sync",
        updatedAt: new Date("2026-04-22T12:00:00.000Z"),
        status: SyncStatus.COMPLETED,
    },
};
