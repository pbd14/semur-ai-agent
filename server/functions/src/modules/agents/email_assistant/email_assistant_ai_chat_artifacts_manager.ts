import {EmailAssistantMentionedEmail} from "../../../models.pb/agents/email_assistant";
import {Genkit, z} from "genkit";
import {logger} from "firebase-functions";
import {ZodMentionedEmail} from "./email_assistant_types";
import {SemurEngineAiToolSDK} from "../../../semur_engine/semur_engine_ai";
import {ChatSession} from "../../../models.pb/chats/chat";
import {AgentTool} from "../../../models.pb/agents/agent";


export class EmailAssistantChatArtifactsManager {
    public mentionedEmails: EmailAssistantMentionedEmail[];
    public totalEmailsAnalyzed: number;
    public timeRange: string;

    constructor() {
        this.mentionedEmails = [];
        this.totalEmailsAnalyzed = 0;
        this.timeRange = "";
    }

    addMentionedEmail(email: EmailAssistantMentionedEmail) {
        this.mentionedEmails.push(email);
    }

    setMetadata(metadata: { totalEmailsAnalyzed?: number; timeRange?: string; }) {
        if (metadata.totalEmailsAnalyzed !== undefined) {
            this.totalEmailsAnalyzed = metadata.totalEmailsAnalyzed;
        }
        if (metadata.timeRange) {
            this.timeRange = metadata.timeRange;
        }
    }

    getContext() {
        return {
            artifacts: {
                mentionedEmails: this.mentionedEmails,
            },
            metadata: {
                totalEmailsAnalyzed: this.totalEmailsAnalyzed,
                timeRange: this.timeRange,
            },
        };
    }

    mentionEmailTool(
        ai: Genkit,
        session: ChatSession,
        nangoIntegrationId: string,
    ) {
        return (new SemurEngineAiToolSDK(
            ai,
            {
                name: "semur_chat_mention_email",
                description: "Mention email in the chat context for reference in responses",
                inputSchema: ZodMentionedEmail,
                outputSchema: z.object({
                    success: z.boolean().describe("Indicates whether the mention of emails was successful."),
                }),
            },
            async (input) => {
                this.addMentionedEmail(EmailAssistantMentionedEmail.create({
                    id: input.id,
                    nangoIntegrationId: nangoIntegrationId,
                    provider: input.provider,
                    subject: input.subject,
                    senderName: input.senderName || "Unknown",
                    senderEmail: input.senderEmail || "Unknown",
                    snippet: input.snippet || "Unknown",
                    date: input.date,
                    importanceScore: input.importanceScore,
                }));
                return {success: true};
            },
            session,
            AgentTool.SEMUR_CHAT_MENTION_EMAIL,
            () => {
                return {success: false};
            },
            false,
        )).getTool();
    }

    updateChatMetadataTool(
        ai: Genkit,
    ) {
        return ai.dynamicTool(
            {
                name: "semur_chat_update_metadata",
                description: "Updates the chat context with metadata about the email analysis.",
                inputSchema: z.object({
                    totalEmailsAnalyzed: z.number().optional().describe("The total number of emails analyzed."),
                    timeRange: z.string().optional().describe("The time range of the emails analyzed."),
                }),
                outputSchema: z.object({
                    success: z.boolean().describe("Indicates whether the metadata update was successful."),
                }),
            },
            async (input) => {
                try {
                    this.setMetadata({
                        totalEmailsAnalyzed: input.totalEmailsAnalyzed,
                        timeRange: input.timeRange,
                    });
                    return {success: true};
                } catch (e) {
                    logger.error(e);
                    return {success: false};
                }
            },
        );
    }
}
