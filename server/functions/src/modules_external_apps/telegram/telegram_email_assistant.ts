import {Telegraf, session} from "telegraf";
import {SemurEngineEndpoint, SemurEngineRequestParams} from "../../semur_engine/semur_engine";
import {SemurEngineEndpointsSecrets} from "../../semur_engine/semur_engine_types";
import {SemurEngineConfig} from "../../config";
import {
    TelegramBotIntegrationStatus,
} from "../../models.pb/external_apps/telegram_bot_integration";
import {
    BotContext,
    checkSelectedConnections,
    checkSemurConnection,
    deleteIntegrationFromDb, generateNewChatId,
    getIntegrationFromDb, getNangoConnectionName, getUserIntegrations, handleAIQuestion,
    SessionData, showIntegrationSelection,
} from "./telegram_email_assistant_types";

const moduleName = SemurEngineConfig.isDev ? "external_app_telegram-dev" : "external_app_telegram";

// Initialize the Telegram bot
const telegramBot = new Telegraf<BotContext>(process.env.TELEGRAM_BOT_TOKEN ?? "");

// Use session middleware to persist context
telegramBot.use(session({
    defaultSession: (): SessionData => ({
        integration: undefined,
        chatId: undefined,
    }),
}));

// Command: /start
telegramBot.start((ctx) => {
    ctx.reply(
        "🤖 Welcome to Semur AI Assistant!\n\n" +
        "I'm here to help you with your AI-powered tasks. To get started, please connect your account using /connect.\n\n" +
        "Use /help to see all available commands.",
    );
});

// Command: /help
telegramBot.help((ctx) => {
    const helpText = `
🤖 *Semur AI Assistant Commands*

/start - Welcome message and introduction
/connect - Connect your Semur account
/status - Check your connection status
/integrations - Select and manage your integrations
/logout - Disconnect your account
/newchat - Start a new conversation
/help - Show this help message

💬 *Chat with AI*
Simply type any message to ask questions or get assistance from the AI agent.

🔗 *Getting Started*
1. Use /connect to link your Semur account
2. Select integrations when prompted or use /integrations
3. Once connected and integrations selected, start chatting with the AI!
  `;

    ctx.reply(helpText, {parse_mode: "Markdown"});
});

// Command: /connect
telegramBot.command("connect", async (ctx) => {
    const chatId = ctx.chat.id.toString();

    // Update chatId in session
    ctx.session.chatId = chatId;

    // Check if user is already connected
    if (ctx.session.integration && ctx.session.integration.integrationStatus === TelegramBotIntegrationStatus.TELEGRAM_BOT_ACTIVE) {
        ctx.reply(
            "✅ Your account is already connected to Semur AI!\n\n" +
            "💡 Use /connections to select your integrations and start chatting.",
        );
        return;
    }

    // Check database for existing integration
    const existingIntegration = await getIntegrationFromDb(chatId);
    if (existingIntegration && existingIntegration.integrationStatus === TelegramBotIntegrationStatus.TELEGRAM_BOT_ACTIVE) {
        ctx.session.integration = existingIntegration;
        ctx.session.chatId = chatId;
        ctx.reply(
            "✅ Your account is already connected to Semur AI!\n\n" +
            "💡 Use /connections to select your integrations and start chatting.",
        );
        return;
    }

    // Generate connection link
    // eslint-disable-next-line max-len
    const connectionLink = `https://semur-ai.web.app/external/telegram/connect?&chatId=${chatId}&username=${ctx.from?.username || ""}&userFirstName=${ctx.from?.first_name || ""}&userLastName=${ctx.from?.last_name || ""}`;

    ctx.reply(
        "🔗 *Connect Your Semur Account*\n\n" +
        "Click the link below to connect your Telegram account with Semur AI:\n\n" +
        `[Connect to Semur AI](${connectionLink})\n\n` +
        "⚡ This link will expire in 10 minutes for security.",
        {
            parse_mode: "Markdown",
            reply_markup: {
                inline_keyboard: [[
                    {text: "🔗 Connect Account", url: connectionLink},
                ]],
            },
        },
    );
});

// Command: /status
telegramBot.command("status", async (ctx) => {
    const chatId = ctx.chat.id.toString();

    // Update chatId in session
    ctx.session.chatId = chatId;

    // Check session first
    if (ctx.session.integration && ctx.session.integration.integrationStatus === TelegramBotIntegrationStatus.TELEGRAM_BOT_ACTIVE) {
        const integration = ctx.session.integration;
        ctx.reply(
            "✅ *Connection Status: Connected*\n\n" +
            `👤 Name: ${integration.userFirstName} ${integration.userLastName}\n` +
            `📧 Username: @${integration.username}\n` +
            `🆔 Integration ID: ${integration.id}\n` +
            `📅 Connected: ${integration.createdAt?.toLocaleDateString()}`,
            {parse_mode: "Markdown"},
        );
        return;
    }

    // Check database if not in session
    const integration = await getIntegrationFromDb(chatId);
    if (integration && integration.integrationStatus === TelegramBotIntegrationStatus.TELEGRAM_BOT_ACTIVE) {
        ctx.session.integration = integration;
        ctx.session.chatId = chatId;
        ctx.reply(
            "✅ *Connection Status: Connected*\n\n" +
            `👤 Name: ${integration.userFirstName} ${integration.userLastName}\n` +
            `📧 Username: @${integration.username}\n` +
            `🆔 Integration ID: ${integration.id}\n` +
            `📅 Connected: ${integration.createdAt?.toLocaleDateString()}`,
            {parse_mode: "Markdown"},
        );
    } else {
        ctx.reply(
            "❌ *Connection Status: Not Connected*\n\n" +
            "Use /connect to link your Semur account with Telegram.",
            {parse_mode: "Markdown"},
        );
    }
});

// Command: /integrations
telegramBot.command("integrations", async (ctx) => {
    // Check if user is connected to Semur first
    const isConnected = await checkSemurConnection(ctx);

    if (!isConnected) {
        ctx.reply(
            "🔒 *Please connect your account first*\n\n" +
            "Use /connect to link your Semur account before managing integrations.",
            {parse_mode: "Markdown"},
        );
        return;
    }

    try {
        // Get available connections
        const availableConnections = await getUserIntegrations(ctx.session.integration!);

        if (availableConnections.length === 0) {
            ctx.reply(
                "❌ *No integrations found*\n\n" +
                "You need to connect at least one service (Gmail, Outlook, etc.) to use the AI assistant.\n\n" +
                "Please visit the Semur AI web app to add integrations first.",
                {parse_mode: "Markdown"},
            );
            return;
        }

        // Show integration selection interface
        await showIntegrationSelection(ctx, availableConnections);
    } catch (error) {
        console.error("Error fetching connections:", error);
        ctx.reply("❌ Error fetching your integrations. Please try again.");
    }
});

// Command: /selectall - Select all available connections
telegramBot.command("selectall", async (ctx) => {
    const isConnected = await checkSemurConnection(ctx);

    if (!isConnected) {
        ctx.reply(
            "🔒 *Please connect your account first*\n\n" +
            "Use /connect to link your Semur account.",
            {parse_mode: "Markdown"},
        );
        return;
    }

    try {
        const availableConnections = await getUserIntegrations(ctx.session.integration!);

        if (availableConnections.length === 0) {
            ctx.reply("❌ No integrations available to select.");
            return;
        }

        ctx.session.aiChatConnections = availableConnections;

        const connectionsList = availableConnections
            .map((conn) => `✅ ${getNangoConnectionName(conn)}`)
            .join("\n");

        ctx.reply(
            "✅ *All integrations selected*\n\n" +
            `Selected integrations:\n${connectionsList}\n\n` +
            "🎉 You can now chat with the AI assistant!",
            {parse_mode: "Markdown"},
        );
    } catch (error) {
        console.error("Error selecting connections:", error);
        ctx.reply("❌ Error selecting integrations. Please try again.");
    }
});

// Command: /clearintegrations - Clear all selected connections
telegramBot.command("clearintegrations", (ctx) => {
    ctx.session.aiChatConnections = [];
    ctx.reply(
        "🗑️ *All connections cleared*\n\n" +
        "Use /connections to select integrations again.",
        {parse_mode: "Markdown"},
    );
});

// Command: /logout
telegramBot.command("logout", async (ctx) => {
    const chatId = ctx.chat.id.toString();

    if (!ctx.session.integration) {
        ctx.reply("❌ You are not currently connected to any account.");
        return;
    }

    // Delete from database
    await deleteIntegrationFromDb(chatId);

    // Clear session
    ctx.session.integration = undefined;
    ctx.session.chatId = undefined;
    ctx.session.aiChatId = undefined;
    ctx.session.aiChatConnections = [];

    ctx.reply(
        "✅ *Successfully logged out*\n\n" +
        "Your account has been disconnected from Semur AI.\n\n" +
        "Use /connect to reconnect anytime.",
        {parse_mode: "Markdown"},
    );
});

// Command: /newchat
telegramBot.command("newchat", async (ctx) => {
    // Update chatId in session context
    if (ctx.chat) {
        ctx.session.aiChatId = generateNewChatId();
    }

    // Check if user is connected to Semur
    const isConnected = await checkSemurConnection(ctx);

    if (!isConnected) {
        ctx.reply(
            "🔒 *Please connect your account first*\n\n" +
            "Use /connect to link your Semur account before starting a new chat.",
            {parse_mode: "Markdown"},
        );
        return;
    }

    // Check if user has selected connections
    const hasConnections = await checkSelectedConnections(ctx);

    if (!hasConnections) {
        return; // checkSelectedConnections already sent appropriate message
    }

    // Note: Chat history is managed externally using chat ID
    // You can implement chat history clearing logic here using ctx.session.chatId
    ctx.reply(
        "🆕 *New conversation started*\n\n" +
        "How can I help you today?",
        {parse_mode: "Markdown"},
    );
});

// Handle regular text messages (AI questions)
telegramBot.on("text", async (ctx) => {
    const message = ctx.message.text;

    // Skip if it's a command
    if (message.startsWith("/")) {
        return;
    }

    // Check if user is connected to Semur using enhanced connection check
    const isConnected = await checkSemurConnection(ctx);

    if (!isConnected) {
        ctx.reply(
            "🔒 *Please connect your account first*\n\n" +
            "Use /connect to link your Semur account before chatting with the AI.",
            {parse_mode: "Markdown"},
        );
        return;
    }

    // Check if user has selected connections
    const hasConnections = await checkSelectedConnections(ctx);

    if (!hasConnections) {
        return; // checkSelectedConnections already sent appropriate message
    }

    try {
        // Show typing indicator
        ctx.reply("⏳ Let me think...");
        ctx.sendChatAction("typing");

        // Use the chatId from session (set by checkSemurConnection)
        if (!ctx.session.aiChatId) {
            ctx.session.aiChatId = generateNewChatId();
        }
        const aiChatId = ctx.session.aiChatId || generateNewChatId();

        // Get connection IDs
        const connectionIds = ctx.session.aiChatConnections?.map((conn) => conn.id) ?? [];

        // Get AI response (chat history will be loaded externally using chatId)
        const aiResponse = await handleAIQuestion(
            message,
            ctx.session.integration!.userId,
            aiChatId,
            connectionIds,
        );

        // Send response
        ctx.reply(aiResponse);
    } catch (error) {
        console.error("Error processing AI question:", error);
        ctx.reply("❌ Sorry, I encountered an error while processing your request. Please try again.");
    }
});

// Handle inline button callbacks for integration selection
telegramBot.on("callback_query", async (ctx) => {
    if (!ctx.callbackQuery || !("data" in ctx.callbackQuery)) {
        await ctx.answerCbQuery("Invalid selection");
        return;
    }

    const data = ctx.callbackQuery.data;

    if (!data) {
        await ctx.answerCbQuery("Invalid selection");
        return;
    }

    // Check if user is connected
    const isConnected = await checkSemurConnection(ctx);
    if (!isConnected) {
        await ctx.answerCbQuery("Please connect your account first");
        return;
    }

    try {
        const availableConnections = await getUserIntegrations(ctx.session.integration!);
        let currentSelections = ctx.session.aiChatConnections || [];

        if (data.startsWith("toggle_")) {
            // Toggle specific integration
            const connectionId = data.replace("toggle_", "");
            const connection = availableConnections.find((conn) => conn.id === connectionId);

            if (connection) {
                const isSelected = currentSelections.some((selected) => selected.id === connectionId);

                if (isSelected) {
                    // Remove from selection
                    currentSelections = currentSelections.filter((selected) => selected.id !== connectionId);
                } else {
                    // Add to selection
                    currentSelections.push(connection);
                }

                ctx.session.aiChatConnections = currentSelections;
            }
        } else if (data === "select_all") {
            // Select all integrations
            ctx.session.aiChatConnections = [...availableConnections];
            currentSelections = availableConnections;
        } else if (data === "clear_all") {
            // Clear all selections
            ctx.session.aiChatConnections = [];
            currentSelections = [];
        } else if (data === "done_selecting") {
            // Finish selection
            if (currentSelections.length === 0) {
                await ctx.answerCbQuery("Please select at least one integration");
                return;
            }

            const selectedList = currentSelections
                .map((conn) => `✅ ${getNangoConnectionName(conn)}`)
                .join("\n");

            await ctx.editMessageText(
                "✅ *Integration selection completed*\n\n" +
                `Selected integrations:\n${selectedList}\n\n` +
                "🎉 You can now chat with the AI assistant!",
                {parse_mode: "Markdown"},
            );

            await ctx.answerCbQuery("Selection saved!");
            return;
        }

        // Update the message with new selections
        await showIntegrationSelection(ctx, availableConnections);
        await ctx.answerCbQuery();
    } catch (error) {
        console.error("Error handling callback query:", error);
        await ctx.answerCbQuery("Error updating selection");
    }
});

// Error handling
telegramBot.catch((err, ctx) => {
    console.error("Telegram bot error:", err);
    ctx.reply("❌ An unexpected error occurred. Please try again.");
});

export const bot = new SemurEngineEndpoint(`${moduleName}-bot`).onRequest(
    // {cors: [/gosemur\.com$/], region: "europe-north1"},
    {
        cors: true,
        secrets: SemurEngineEndpointsSecrets[`${moduleName}-bot`],
    },
    async (request, responder, endpoint) => {
        try {
            // Handle incoming webhook updates from Telegram
            if (request.method === "POST" && request.body) {
                await telegramBot.handleUpdate(request.body);
                responder.success({message: "Webhook processed successfully"});
            } else {
                responder.success({message: "Telegram bot is running"});
            }
        } catch (error) {
            console.error("Error handling Telegram webhook:", error);
            responder.internalError("Failed to process webhook");
        }
    },
    new SemurEngineRequestParams(
        ["POST", "GET"],
        false,
        true,
        false,
    ),
);
