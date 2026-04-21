import {z} from "genkit";

// Related to SyncGoogleMailEmail proto
export const ZodGoogleMailEmail = z.object({
    id: z.string().describe("The unique identifier of the email."),
    sender: z.string().describe("The email address of the sender."),
    recipients: z.string().describe("The email addresses of the recipients, separated by commas."),
    date: z.string().describe("The date and time when the email was sent, in ISO 8601 format."),
    subject: z.string().describe("The subject of the email."),
    body: z.string().describe("The body content of the email."),
    attachments: z.array(z.object({
        filename: z.string().describe("The name of the attachment file."),
        mimeType: z.string().describe("The MIME type of the attachment."),
        size: z.number().describe("The size of the attachment in bytes."),
        attachmentId: z.string().describe("The unique identifier of the attachment."),
    })),
    threadId: z.string().describe("The identifier of the email thread to which this email belongs."),
}).describe("Schema representing a Google Mail email.");

export const ZodGoogleMailEmailsSearchSchema = z.object({
    id: z.string().optional().describe("Email ID to match exactly. If this is provided, other filters are ignored"),
    dateFrom: z.string().optional().describe("Start date in ISO format (e.g., \"2025-09-15T05:41:14.000Z\")"),
    dateTo: z.string().optional().describe("End date in ISO format (e.g., \"2025-09-15T05:41:14.000Z\")"),
    threadId: z.string().optional().describe("Thread ID to match exactly"),
    limit: z.number().max(50).optional().default(50).describe("Maximum number of results to return (default: 50, max: 50)"),
}).describe("Schema for searching Google Mail emails. All fields are optional.");


export const ZodGoogleMailVectorSearchSchema = z.object({
    query: z.string().describe("Natural-language or keyword query. Use for fuzzy matches on sender, subject, and cleaned body."),
    limit: z.number().int().optional().default(50).describe("Maximum number of emails to return (default: 50)"),
});

// Send email
// {
//     "from": "<string>",
//     "to": "<string>",
//     "headers": { [key: string]: string },
//     "subject": "<string>",
//     "body": "<string>"
// }

export const ZodGoogleMailSendEmailSchema = z.object({
    to: z.string().describe("The email address of the recipient."),
    headers: z.record(z.string()).optional().describe("Optional email headers as key-value pairs."),
    subject: z.string().describe("The subject of the email."),
    body: z.string().describe("The body content of the email."),
});
