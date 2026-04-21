import {z} from "genkit";

export const ZodMentionedEmail = z.object({
    id: z.string().describe("A unique identifier for the mentioned email."), // UUID v4
    provider: z.enum(["gmail", "outlook", "custom"]).describe("The email service provider."),
    subject: z.string().default("").describe("The subject of the email."),
    senderName: z.string().default("").describe("The name of the email sender."),
    senderEmail: z.string().default("").describe("The email address of the sender."),
    snippet: z.string().optional().describe("A brief snippet or preview of the email content."),
    date: z.string().optional(), // ISO string
    // eslint-disable-next-line max-len
    importanceScore: z.number().min(0).max(1).default(0.5).describe("A score between 0 and 1 indicating the importance of the email. Any emails that are urgent, require action, about meetings/calls, or are from important contacts should have a score closer to 1."), // 0 to 1
}).describe("The MentionedEmail schema representing an email mentioned in the chat context.");

export const ZodEmailAssistantChatOutput = z.object({
    replyText: z.string(),
    artifacts: z.object({
        mentionedEmails: z.array(ZodMentionedEmail).default([]),
    }).optional(),
    metadata: z.object({
        totalEmailsAnalyzed: z.number().optional(),
        timeRange: z.string().optional(),
    }).optional(),
});

// Relate to EmailAssistantGenerateResponseEmailInput proto
export const ZodEmailAssistantGenerateResponseEmailInput = z.object({
    from: z.string().describe("The email address of the sender of the original email."),
    to: z.string().describe("The email address of the recipient of the original email."),
    date: z.string().describe("The date when the original email was sent."),
    subject: z.string().describe("The subject of the original email."),
    body: z.string().describe("The body content of the original email."),
});

// Related to EmailAssistantGenerateResponseEmailOutput
export const ZodEmailAssistantGenerateResponseEmailOutput = z.object({
    responseEmailSubject: z.string().describe("The subject line for the response email."),
    responseEmailBody: z.string().describe("The body content for the response email."),
});
