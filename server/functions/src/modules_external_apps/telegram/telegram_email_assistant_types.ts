// Session interface to store user context
import {
    TelegramBotIntegration,
    TelegramBotIntegrationStatus,
} from "../../models.pb/external_apps/telegram_bot_integration";
import {Context} from "telegraf";
import {logger} from "firebase-functions";
import {ExternalAppTelegramBotAccessor} from "../../accessors/external_apps/external_app_telegram_bot_accessor";
import {AgentChatInput, AgentMood} from "../../models.pb/agents/agent";
import {chatFlow} from "../../modules/agents/email_assistant/email_assistant_ai";
import {GeminiModelsMoods} from "../../modules/agents/gemini_models_config";
import {NangoConnection, NangoConnectionPublic} from "../../models.pb/nango/nango";
import {UserAccessor, UserNangoConnectionQueryKey} from "../../accessors/users/user_accessor";

// Types
export interface SessionData {
    integration?: TelegramBotIntegration;
    chatId?: string;
    aiChatId?: string;
    aiChatConnections?: NangoConnectionPublic[];
}

// Extend Telegraf context with session
export interface BotContext extends Context {
    session: SessionData;
}

// Functions
// Helper function to get integration from database
export async function getIntegrationFromDb(chatId: string): Promise<TelegramBotIntegration | null> {
    logger.debug("getIntegrationFromDb(chatId) - ", chatId);
    const integration = await ExternalAppTelegramBotAccessor.get(chatId).catch(
        (error) => {
            logger.debug("No integration found in db for chatId:", chatId, "Error:", error);
            return null;
        });
    logger.debug("Fetched integration from db:", integration);
    return integration;
}

// Helper function to delete integration from database
export async function deleteIntegrationFromDb(chatId: string): Promise<void> {
    await ExternalAppTelegramBotAccessor.delete(chatId);
}

// Helper function to check if user is connected to Semur
export async function checkSemurConnection(ctx: BotContext): Promise<boolean> {
    if (!ctx.chat) return false;

    const chatId = ctx.chat.id.toString();

    // First check session
    if (ctx.session.integration && ctx.session.integration.integrationStatus === TelegramBotIntegrationStatus.TELEGRAM_BOT_ACTIVE) {
        // Update chatId in session if not set
        if (!ctx.session.chatId) {
            ctx.session.chatId = chatId;
        }
        return true;
    }

    // Check database if not in session
    const integration = await getIntegrationFromDb(chatId);
    if (integration && integration.integrationStatus === TelegramBotIntegrationStatus.TELEGRAM_BOT_ACTIVE) {
        // Update session with integration data
        ctx.session.integration = integration;
        ctx.session.chatId = chatId;

        // Initialize empty connections array if not set (user needs to select manually)
        if (!ctx.session.aiChatConnections) {
            ctx.session.aiChatConnections = [];
        }

        return true;
    }

    return false;
}

// Helper function to handle AI questions
export async function handleAIQuestion(question: string, userId: string, chatId: string, connectionIds: string[]): Promise<string> {
    // TODO: Implement AI agent call
    // You can load chat history using the chatId parameter
    console.log(`Processing AI question: ${question} for chatId: ${chatId}`);

    const agentChatInput = AgentChatInput.create({
        userId: userId,
        sessionId: chatId,
        connectionIds: connectionIds,
        userMessage: question,
        fastMode: false,
        proMode: false,
        agentMood: AgentMood.NORMAL,
    });

    const chatOutput = await chatFlow({
        userId: agentChatInput.userId,
        sessionId: agentChatInput.sessionId,
        connectionIds: agentChatInput.connectionIds,
        userMessage: agentChatInput.userMessage,
        fastMode: agentChatInput.fastMode,
        proMode: agentChatInput.proMode,
        agentMood: GeminiModelsMoods.convertMoodToString(agentChatInput.agentMood),
        app: "external_app_telegram_bot",
    });
    return chatOutput.chatOutput || "Sorry, AI could not generate a response. Please try again.";
}

// Helper function to get users available connection IDs
export async function getUserIntegrations(integration: TelegramBotIntegration): Promise<NangoConnectionPublic[]> {
    const connections = await UserAccessor.nangoConnectionQuery(UserNangoConnectionQueryKey.All, {
        userId: integration.userId,
    });

    // Convert connections to NangoConnectionPublic
    return connections.map((connection: NangoConnection) => NangoConnectionPublic.create({
        id: connection.id,
        userId: connection.userId,
        organizationId: connection.organizationId,
        status: connection.status,
        provider: connection.provider,
        // TODO: There is some problem with receiving this value in Client. For now, leave it not used
        // updatedAt: connection.updatedAt,
    }));
}

// Helper function to check if user has selected connections
export async function checkSelectedConnections(ctx: BotContext): Promise<boolean> {
    // Check if user has any selected connections
    if (!ctx.session.aiChatConnections || ctx.session.aiChatConnections.length === 0) {
        // Check if user has available connections
        if (ctx.session.integration) {
            const availableConnections = await getUserIntegrations(ctx.session.integration);

            if (availableConnections.length === 0) {
                ctx.reply(
                    "❌ *No integrations found*\n\n" +
                    "You need to connect at least one service (Gmail, Outlook, etc.) to use the AI assistant.\n\n" +
                    "Please visit the Semur AI web app to add integrations first.",
                    {parse_mode: "Markdown"},
                );
                return false;
            }

            // Automatically show integration selection
            await showIntegrationSelection(ctx, availableConnections);
            return false;
        }
        return false;
    }

    return true;
}

// Helper function to show integration selection with inline buttons
export async function showIntegrationSelection(ctx: BotContext, availableConnections: NangoConnectionPublic[]): Promise<void> {
    const currentSelections = ctx.session.aiChatConnections || [];

    // Create inline keyboard with integration options
    const keyboard = availableConnections.map((conn, index) => {
        const isSelected = currentSelections.some((selected) => selected.id === conn.id);
        const emoji = isSelected ? "✅" : "⭕";
        return [{
            text: `${emoji} ${getNangoConnectionName(conn)}`,
            callback_data: `toggle_${conn.id}`,
        }];
    });

    // Add action buttons
    keyboard.push([
        {text: "✅ Select All", callback_data: "select_all"},
        {text: "�️ Clear All", callback_data: "clear_all"},
    ]);

    keyboard.push([
        {text: "✨ Done", callback_data: "done_selecting"},
    ]);

    const currentList = currentSelections.length > 0 ?
        currentSelections.map((conn) => `✅ ${conn.provider}`).join("\n") :
        "None selected";

    const messageText = "🔗 *Select Your Integrations*\n\n" +
        `Currently selected:\n${currentList}\n\n` +
        "Tap on integrations to toggle selection:";

    const replyMarkup = {
        parse_mode: "Markdown" as const,
        reply_markup: {
            inline_keyboard: keyboard,
        },
    };

    // Try to edit existing message, fallback to new message
    try {
        if (ctx.callbackQuery && ctx.callbackQuery.message) {
            await ctx.editMessageText(messageText, replyMarkup);
        } else {
            await ctx.reply(messageText, replyMarkup);
        }
    } catch (error) {
        // If edit fails, send new message
        await ctx.reply(messageText, replyMarkup);
    }
}

export function generateNewChatId(): string {
    const randomUUID = crypto.randomUUID();
    return ("external-telegram_bot_" + randomUUID);
}

export function getNangoConnectionName(connection: NangoConnectionPublic): string | undefined {
    switch (connection.provider) {
        // TODO: Magic values
        case "google-mail":
            return "Gmail";
        case "google-calendar":
            return "Google Calendar";
        case "outlook-mail":
            return "Outlook Email";
        case "outlook-calendar":
            return "Outlook Calendar";
        default:
            return connection.provider;
    }
}
