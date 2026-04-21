import {z} from "genkit";
import {RuntimeSecretBinding, RuntimeSecrets} from "../runtime/runtime_config";

/**
 * Enum for SemurEngine event types used in logging
 */
export enum SemurEngineEventType {
    INFO = "info",
    ERROR = "error",
    WARNING = "warning",
    DEBUG = "debug"
}

/**
 * Interface for log data parameters
 */
export interface LogData {
    [key: string]: unknown;
}

/**
 * Interface for error JSON representation
 */
export interface ErrorJson {
    error: number;
    message: string;
    name: string;
}

export const SemurEngineEndpointsSecrets: { [key: string]: RuntimeSecretBinding[] } = {
    // Nango
    "nango-sessionToken": [RuntimeSecrets.nango],
    "nango-dev-sessionToken": [RuntimeSecrets.nango],
    "nango-webhook": [RuntimeSecrets.nango],
    "nango-dev-webhook": [RuntimeSecrets.nango],

    // Nango Google mail
    "nango-google-mail-sendEmail": [RuntimeSecrets.nango],
    "nango-google-mail-dev-sendEmail": [RuntimeSecrets.nango],

    // Email Assistant
    "agent_email_assistant-chat": [
        RuntimeSecrets.googleAI,
        RuntimeSecrets.nango,
    ],
    "agent_email_assistant-dev-chat": [
        RuntimeSecrets.googleAI,
        RuntimeSecrets.nango,
    ],
    "agent_email_assistant-generateEmailResponse": [
        RuntimeSecrets.googleAI,
        RuntimeSecrets.nango,
    ],
    "agent_email_assistant-dev-generateEmailResponse": [
        RuntimeSecrets.googleAI,
        RuntimeSecrets.nango,
    ],

    // Syncs
    // Google Mail
    "sync_google_mail-emails": [RuntimeSecrets.nango],
    "sync_google_mail-dev-emails": [RuntimeSecrets.nango],
    "sync_google_mail-emailsFromNangoToFirestore": [RuntimeSecrets.nango],
    "sync_google_mail-dev-emailsFromNangoToFirestore": [RuntimeSecrets.nango],
    // Google Calendar
    "sync_google_calendar-events": [RuntimeSecrets.nango],
    "sync_google_calendar-dev-events": [RuntimeSecrets.nango],
    "sync_google_calendar-eventsFromNangoToFirestore": [RuntimeSecrets.nango],
    "sync_google_calendar-dev-eventsFromNangoToFirestore": [RuntimeSecrets.nango],
    // Outlook Mail
    "sync_outlook_mail-emails": [RuntimeSecrets.nango],
    "sync_outlook_mail-dev-emails": [RuntimeSecrets.nango],
    "sync_outlook_mail-emailsFromNangoToFirestore": [RuntimeSecrets.nango],
    "sync_outlook_mail-dev-emailsFromNangoToFirestore": [RuntimeSecrets.nango],

    // External Apps
    // Telegram
    "external_app_telegram-bot": [
        RuntimeSecrets.telegramBot,
        RuntimeSecrets.googleAI,
        RuntimeSecrets.nango,
    ],
    "external_app_telegram-dev-bot": [
        RuntimeSecrets.telegramBot,
        RuntimeSecrets.googleAI,
        RuntimeSecrets.nango,
    ],
};

// In accordance to AgentChatInput
export const ZodAgentChatInput = z.object({
    userId: z.string().min(1),
    sessionId: z.string().min(1),
    connectionIds: z.array(z.string()).default([]).optional(),
    userMessage: z.string().min(1),
    fastMode: z.boolean().default(false).optional(),
    proMode: z.boolean().default(false).optional(),
    agentMood: z.string().optional().default("NORMAL"),
    app: z.enum(["semur", "external_app_telegram_bot"]).default("semur").optional(),
});

export const ZodAgentChatOutput = z.object({
    error: z.number().describe("Error code, 0 if no error"),
    message: z.string().describe("Response message"),
    chatOutput: z.string().optional(),
});
