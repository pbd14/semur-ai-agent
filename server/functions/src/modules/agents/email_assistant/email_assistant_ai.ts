import {genkit} from "genkit";
import {SemurEngineConfig} from "../../../config";
import {UserAccessor} from "../../../accessors/users/user_accessor";
import {NangoConnection, NangoConnectionStatus} from "../../../models.pb/nango/nango";
import {AgentChatService, AgentChatSessionManagementService} from "../../../services/agent_chat_service";
import {ChatArtifacts, ChatMessage, ChatMetadata, ChatRole} from "../../../models.pb/chats/chat";
import {AgentCategory, AgentChatOutput} from "../../../models.pb/agents/agent";
import {logger} from "firebase-functions";
import {GoogleMailTools} from "../../tools/google-mail/google-mail_tools";
import {
    EmailAssistantChatArtifacts,
    EmailAssistantChatMetadata,
    EmailAssistantMentionedEmail,
} from "../../../models.pb/agents/email_assistant";
import {ZodAgentChatInput, ZodAgentChatOutput} from "../../../semur_engine/semur_engine_types";
import {SemurEngineErrorCode} from "../../../models.pb/semur-engine/semur_engine";
import {EmailAssistantChatArtifactsManager} from "./email_assistant_ai_chat_artifacts_manager";
import {ChatHelper} from "../chat_helper/chat_helper";
// import openAI from "@genkit-ai/compat-oai/openai";
import {googleAI} from "@genkit-ai/googleai";
import {NangoConnectionsHelper} from "../../../helpers/nango/nango_connections_helper";
import {EmailAssistantSystemPromptBuilder} from "./email_assistant_system_prompt_builder";
import {SystemPromptBuilder} from "../system_prompt_builder";
import {
    ZodEmailAssistantGenerateResponseEmailInput,
    ZodEmailAssistantGenerateResponseEmailOutput,
} from "./email_assistant_types";
import {GeminiModelsConfig, GeminiModelsMoods} from "../gemini_models_config";
import {GoogleCalendarTools} from "../../tools/google-calendar/google-calendar_tools";
import {AgentChatHelper} from "../../../helpers/agent_chat_helper";
import {OutlookMailTools} from "../../tools/outlook-mail/outlook-mail_tools";
import {getNangoSecret} from "../../../runtime/runtime_config";
import {IntegrationIds} from "../../../runtime/integration_ids";
import {ExecutiveOrchestrator} from "./executive_orchestrator";

const moduleName = SemurEngineConfig.isDev ? "agent_email_assistant-dev" : "agent_email_assistant";


// const ai = genkit({
//     plugins: [openAI()],
//     model: openAI.model("gpt-5-nano"),
// });

const ai = genkit({
    plugins: [googleAI()],
});

// Chat
export const chatFlow = ai.defineFlow(
    {
        name: moduleName + "chatFlow",
        inputSchema: ZodAgentChatInput,
        outputSchema: ZodAgentChatOutput,
    },
    async ({userId, sessionId, connectionIds, userMessage, fastMode, proMode, agentMood, app = "semur"}) => {
        console.log("Email Assistant Chat called with:", {
            userId,
            sessionId,
            connectionIds,
            userMessage,
            fastMode,
            proMode,
            agentMood,
        });
        // Manage chat session in Firestore
        const session = await AgentChatSessionManagementService.initSession(
            sessionId,
            userId,
            ChatMessage.create({
                id: -1,
                role: ChatRole.USER,
                author: "User",
                content: userMessage,
                createdAt: new Date(),
            }),
            AgentCategory.EMAIL,
        );

        // Get Nango connections
        const emailConnections: NangoConnection[] = [];
        for (const connectionId of connectionIds || []) {
            const conn = await UserAccessor.nangoConnectionGet(userId, connectionId);
            if (conn && conn.status === NangoConnectionStatus.NANGO_CONNECTION_ACTIVE) {
                const agentCategories = NangoConnectionsHelper.agentCategoriesFromNangoIntegrationId(conn.id);
                if (agentCategories.includes(AgentCategory.EMAIL)) {
                    emailConnections.push(conn);
                }
            }
        }
        const calendarConnections: NangoConnection[] = [];
        for (const connectionId of connectionIds || []) {
            const conn = await UserAccessor.nangoConnectionGet(userId, connectionId);
            if (conn && conn.status === NangoConnectionStatus.NANGO_CONNECTION_ACTIVE) {
                const agentCategories = NangoConnectionsHelper.agentCategoriesFromNangoIntegrationId(conn.id);
                if (agentCategories.includes(AgentCategory.CALENDAR)) {
                    calendarConnections.push(conn);
                }
            }
        }

        if (!emailConnections.length) {
            const output = createChatOutput(
                "I’m not connected to any email providers yet. You can connect your email in Integrations",
                [],
                {},
            );
            // Update chat session with assistant message
            session.currentMessageIndex = await AgentChatService.addNewMessageToSession(
                session.id,
                userId,
                ChatMessage.create({
                    id: session.currentMessageIndex + 1,
                    role: ChatRole.MODEL,
                    // TODO: Magic value
                    author: "Email Assistant",
                    content: output.replyText,
                    metadata: ChatMetadata.create({
                        emailAssistant: output.metadata,
                    }),
                    artifacts: ChatArtifacts.create({
                        emailAssistant: output.artifacts,
                    }),
                    createdAt: new Date(),
                }),
            );
            return AgentChatOutput.create({
                error: SemurEngineErrorCode.AGENT_NO_INTEGRATION,
                message: "No active email connections found. Please connect an email provider.",
            });
        }
        // Initialize email tools
        const emailTools = [];
        const nangoSecret = getNangoSecret();
        for (const emailConnection of emailConnections) {
            switch (emailConnection.id) {
                case IntegrationIds.googleMail:
                    emailTools.push(...GoogleMailTools.initializeAllTools(
                        ai,
                        nangoSecret,
                        emailConnection.id,
                        emailConnection.connectionId,
                        session,
                        {includeSend: app !== "semur"},
                    ));
                    break;
                case IntegrationIds.outlookMail:
                    emailTools.push(...OutlookMailTools.initializeAllTools(
                        ai,
                        nangoSecret,
                        emailConnection.id,
                        emailConnection.connectionId,
                        session,
                    ));
                    break;
            }
        }

        // If calendar connection exists, add calendar tools as well
        const calendarTools = [];
        for (const calendarConnection of calendarConnections) {
            switch (calendarConnection.id) {
                case IntegrationIds.googleCalendar:
                    calendarTools.push(...GoogleCalendarTools.initializeAllTools(
                        ai,
                        nangoSecret,
                        calendarConnection.id,
                        calendarConnection.connectionId,
                        session,
                    ));
                    break;
            }
        }

        // Initialize artifacts manager
        const artifactsManager = new EmailAssistantChatArtifactsManager();
        const mentionEmailTool = app === "semur" ?
            artifactsManager.mentionEmailTool(ai, session, emailConnections[0].id) :
            undefined;
        const tools = [
            ...(mentionEmailTool ? [mentionEmailTool] : []),
            ...emailTools,
            ...calendarTools,
        ];

        // Load chat history
        const chatHistory = await AgentChatService.getChatHistory(session.id, userId);

        // Insert system message at the beginning
        const now = new Date();
        const context = {
            time: {
                iso: now.toISOString(),
                unix: Math.floor(now.getTime() / 1000),
            },
        };
        const messages = [
            {
                role: "system" as const,
                content: [{
                    text: EmailAssistantSystemPromptBuilder.buildSystemPrompt(
                        [
                            ...emailConnections,
                            ...calendarConnections,
                        ],
                        context,
                        app,
                    ),
                }],
            },
            ...chatHistory,
        ];

        try {
            if (app === "semur") {
                const orchestratorOutput = await ExecutiveOrchestrator.run({
                    ai,
                    userMessage,
                    chatHistory,
                    emailTools: [
                        ...(mentionEmailTool ? [mentionEmailTool] : []),
                        ...emailTools,
                    ],
                    calendarTools,
                    finalTools: mentionEmailTool ? [mentionEmailTool] : [],
                    hasCalendarConnection: calendarConnections.length > 0,
                    fastMode,
                    proMode,
                    agentMood: GeminiModelsMoods.convertStringToMood(agentMood),
                    context,
                });

                session.currentMessageIndex = await AgentChatService.addNewMessageToSession(
                    session.id,
                    userId,
                    ChatMessage.create({
                        id: session.currentMessageIndex + 1,
                        role: ChatRole.MODEL,
                        author: "Executive Orchestrator",
                        content: orchestratorOutput.replyText,
                        metadata: ChatMetadata.create({
                            emailAssistant: EmailAssistantChatMetadata.create({
                                totalEmailsAnalyzed: artifactsManager.totalEmailsAnalyzed,
                                timeRange: artifactsManager.timeRange,
                            }),
                        }),
                        artifacts: ChatArtifacts.create({
                            emailAssistant: EmailAssistantChatArtifacts.create({
                                mentionedEmails: artifactsManager.mentionedEmails,
                            }),
                        }),
                        output: orchestratorOutput.traceOutput,
                        followUpQuestions: await ChatHelper.generateFollowupQuestions(userMessage, orchestratorOutput.replyText),
                        createdAt: new Date(),
                    }),
                );
                return AgentChatOutput.create({
                    error: SemurEngineErrorCode.NO_ERROR,
                    message: "Success",
                    chatOutput: orchestratorOutput.replyText,
                });
            }

            const response = await AgentChatHelper.callAiGenerateWithRetry(
                ai,
                fastMode,
                proMode,
                messages,
                tools,
                GeminiModelsMoods.convertStringToMood(agentMood),
                20,
                context,
                1,
            );

            // Save response message
            session.currentMessageIndex = await AgentChatService.addNewMessageToSession(
                session.id,
                userId,
                ChatMessage.create({
                    id: session.currentMessageIndex + 1,
                    role: ChatRole.MODEL,
                    // TODO: Magic value
                    author: "Email Assistant",
                    content: response.text,
                    metadata: ChatMetadata.create({
                        emailAssistant: EmailAssistantChatMetadata.create({
                            totalEmailsAnalyzed: artifactsManager.totalEmailsAnalyzed,
                            timeRange: artifactsManager.timeRange,
                        }),
                    }),
                    artifacts: ChatArtifacts.create({
                        emailAssistant: EmailAssistantChatArtifacts.create({
                            mentionedEmails: artifactsManager.mentionedEmails,
                        }),
                    }),
                    followUpQuestions: await ChatHelper.generateFollowupQuestions(userMessage, response.text),
                    createdAt: new Date(),
                }),
            );
            return AgentChatOutput.create({
                error: SemurEngineErrorCode.NO_ERROR,
                message: "Success",
                chatOutput: response.text,
            });
        } catch (e) {
            logger.error(e);
            const output = createChatOutput(
                "Sorry, I couldn't process your request at the moment. Please try again later.",
                [],
                {},
            );
            // Update chat session with assistant message
            session.currentMessageIndex = await AgentChatService.addNewMessageToSession(
                session.id,
                userId,
                ChatMessage.create({
                    id: session.currentMessageIndex + 1,
                    role: ChatRole.MODEL,
                    // TODO: Magic value
                    author: "Email Assistant",
                    content: output.replyText,
                    metadata: ChatMetadata.create({
                        emailAssistant: output.metadata,
                    }),
                    artifacts: ChatArtifacts.create({
                        emailAssistant: output.artifacts,
                    }),
                    followUpQuestions: await ChatHelper.generateFollowupQuestions(userMessage, output.replyText),
                    createdAt: new Date(),
                }),
            );
            return AgentChatOutput.create({
                error: SemurEngineErrorCode.INTERNAL_ERROR,
                message: "An unknown error occurred while processing the AI response. Please try again.",
            });
        }
    },
);

// Helper function to create a valid ChatOutput response
function createChatOutput(
    replyText: string, mentionedEmails: EmailAssistantMentionedEmail[],
    metadata: { totalEmailsAnalyzed?: number; timeRange?: string; } = {},
) {
    return {
        replyText,
        artifacts: {
            mentionedEmails: mentionedEmails,
        },
        metadata: {
            totalEmailsAnalyzed: metadata.totalEmailsAnalyzed || 0,
            timeRange: metadata.timeRange || "",
        },
    };
}

export const generateEmailResponseFlow = ai.defineFlow(
    {
        name: moduleName + "generateEmailResponseFlow",
        inputSchema: ZodEmailAssistantGenerateResponseEmailInput,
        // boolean(
        outputSchema: ZodEmailAssistantGenerateResponseEmailOutput,
    },
    async ({from, to, date, subject, body}) => {
        // Insert system message at the beginning
        const messages = [
            {
                role: "system" as const,
                content: [{
                    text: SystemPromptBuilder.SEMUR_WHOAMI + "\n" +
                        "You are a AI chat helper on Semur.ai platform. " +
                        "Your task is to help users generate professional email responses based on the original email content and context. " +
                        "You will be provided with the original email details including sender, recipient, date, subject, and body. " +
                        "Your response should include a subject line and body content for the reply email. " +
                        "The response should be professional, concise, and relevant to the original email. " +
                        "Use proper email etiquette and formatting. " +
                        "For email body use proper formatting, like new line sign, lists and appropriate format (not just one line of text)" +
                        "If the original email is unclear or lacks context, make reasonable assumptions to generate an appropriate response. " +
                        "Do not include any disclaimers or apologies for being an AI model. ",
                }],
            },
            {
                role: "user" as const,
                content: [{
                    text: "Generate a professional email response based on the following details: " + "\n" +
                        `From: ${from}\nTo: ${to}\nDate: ${date}\nSubject: ${subject}\nBody: ${body}`,
                }],
            },
        ];

        try {
            const response = await ai.generate({
                model: GeminiModelsConfig.normalModel,
                messages: messages,
                maxTurns: 1,
                output: {
                    schema: ZodEmailAssistantGenerateResponseEmailOutput,
                },
            });

            if (!response.output || !response.output.responseEmailBody) {
                logger.error("Email assistant generate email response error: No output from AI");
                return {
                    responseEmailSubject: "",
                    responseEmailBody: "",
                };
            }

            return {
                responseEmailSubject: response.output.responseEmailSubject || "",
                responseEmailBody: response.output.responseEmailBody,
            };
        } catch (e) {
            logger.error("Email assistant generate email response error: " + e);
            return {
                responseEmailSubject: "",
                responseEmailBody: "",
            };
        }
    },
);
