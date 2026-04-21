import {ChatMessage, ChatRole, ChatSession} from "../models.pb/chats/chat";
import {UserChatAccessor, UserChatMessageQueryKey} from "../accessors/users/user_chat_accessor";
import {AgentCategory} from "../models.pb/agents/agent";
import {AgentChatHelper} from "../helpers/agent_chat_helper";
import {ChatHelper} from "../modules/agents/chat_helper/chat_helper";
import {MessageData} from "@genkit-ai/ai/lib/model-types";
import {GeminiModelsConfig} from "../modules/agents/gemini_models_config";

export class AgentChatSessionManagementService {
    static async initSession(
        sessionId: string,
        userId: string,
        message: ChatMessage,
        agentCategory: AgentCategory = AgentCategory.GENERAL,
    ): Promise<ChatSession> {
        const chatTitle = await ChatHelper.generateChatName(message.content);

        if (!(await AgentChatService.chatExists(sessionId, userId))) {
            await AgentChatService.createChatSession(
                ChatSession.create({
                    id: sessionId,
                    userId: userId,
                    agentCategory: agentCategory,
                    currentMessageIndex: 0,
                    createdAt: new Date(),
                    title: chatTitle,
                }),
                userId,
            );
        }
        // Create persistent chat session
        const session = await AgentChatService.getChatSession(sessionId, userId);
        if (!session) {
            throw new Error("Chat session not found after creation");
        }

        // Update chat session with latest user message
        session.currentMessageIndex = await AgentChatService.addNewMessageToSession(
            session.id,
            userId,
            message,
        );

        return session;
    }
}

export class AgentChatService {
    static async chatExists(sessionId: string, userId: string): Promise<boolean> {
        try {
            return await UserChatAccessor.exists(userId, sessionId);
        } catch (error) {
            console.error("Error checking chat existence:", error);
            throw error;
        }
    }

    static async getChatSession(sessionId: string, userId: string): Promise<ChatSession | null> {
        try {
            return await UserChatAccessor.get(userId, sessionId);
        } catch (error) {
            console.error("Error getting chat session:", error);
            throw error;
        }
    }

    static async createChatSession(
        session: ChatSession,
        userId: string,
    ): Promise<void> {
        try {
            await UserChatAccessor.set(userId, session);
        } catch (error) {
            console.error("Error creating chat session:", error);
            throw error;
        }
    }

    static async getChatHistory(
        sessionId: string,
        userId: string,
    ): Promise<MessageData[]> {
        try {
            if (!(await UserChatAccessor.exists(userId, sessionId))) {
                throw new Error("Chat session not found");
            }
            const messages = await UserChatAccessor.messageQuery(
                UserChatMessageQueryKey.All,
                {
                    userId: userId,
                    chatId: sessionId,
                    // TODO: Magic value
                    limit: 30,
                },
            );

            // Map messages to {role, content} format
            const tokenLimitPerMessage = GeminiModelsConfig.chatHistoryTokenLimit / (messages.length || 1);
            const tokenLimitArtifactsBuffer = tokenLimitPerMessage * 0.2; // Buffer for artifacts
            const filteredMessages = messages.sort((a, b) => a.id - b.id).map((msg) => (
                // TODO: Implement proper tool message handling
                {
                    role: AgentChatHelper.transformChatRoleToGenkitRole(msg.role),
                    content: [{
                        text: GeminiModelsConfig.processTextWithTokenLimit(
                            msg.role == ChatRole.TOOL ? `Calling tool ${msg.toolName}:` + msg.content + "\n Tool request: " + msg.toolRequestJson :
                                msg.content,
                            // Minus date (32 tokens / 4 tokens per word) and artifacts buffer
                            tokenLimitPerMessage - ((32 / 4) + tokenLimitArtifactsBuffer),
                        ),
                        custom: {
                            date: msg.createdAt ? msg.createdAt.toISOString() : new Date().toISOString(),
                            artifacts: GeminiModelsConfig.processTextWithTokenLimit(JSON.stringify(msg.artifacts || {}), tokenLimitArtifactsBuffer),
                        },
                    }],
                }
            ));
            // Ensure the first message is always from user
            if (filteredMessages.length > 0 && filteredMessages[0].role !== AgentChatHelper.transformChatRoleToGenkitRole(ChatRole.USER)) {
                filteredMessages[0].role = AgentChatHelper.transformChatRoleToGenkitRole(ChatRole.USER);
                filteredMessages[0].content = [{
                    text: "This chat was truncated to the last 30 messages, so the beginning of the conversation is missing.",
                    custom: {
                        date: new Date().toISOString(),
                        artifacts: "{}",
                    },
                }];
            }
            return filteredMessages;
        } catch (error) {
            console.error("Error getting chat history:", error);
            throw error;
        }
    }

    static async addNewMessageToSession(
        sessionId: string,
        userId: string,
        message: ChatMessage,
    ): Promise<number> {
        try {
            if (!(await UserChatAccessor.exists(userId, sessionId))) {
                throw new Error("Chat session not found");
            }
            const session = await UserChatAccessor.get(userId, sessionId);
            message.id = session.currentMessageIndex + 1;

            await UserChatAccessor.messageSet(userId, sessionId, message);
            await UserChatAccessor.updateCustomFields(userId, sessionId, {
                currentMessageIndex: message.id,
            });
            return message.id;
        } catch (error) {
            console.error("Error adding message to chat session:", error);
            throw error;
        }
    }

    static async deleteMessageFromSession(
        sessionId: string,
        userId: string,
        messageId: number,
    ): Promise<void> {
        try {
            if (!(await UserChatAccessor.exists(userId, sessionId))) {
                throw new Error("Chat session not found");
            }
            const session = await UserChatAccessor.get(userId, sessionId);
            while (session.currentMessageIndex >= messageId) {
                await UserChatAccessor.messageDelete(userId, sessionId, session.currentMessageIndex.toString());
                session.currentMessageIndex -= 1;
            }
            await UserChatAccessor.updateCustomFields(userId, sessionId, {
                currentMessageIndex: session.currentMessageIndex,
            });
        } catch (error) {
            console.error("Error deleting message from chat session:", error);
            throw error;
        }
    }
}
