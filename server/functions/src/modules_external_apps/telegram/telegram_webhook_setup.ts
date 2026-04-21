import axios from "axios";
import {SemurEngineConfig} from "../../config";

/**
 * Helper functions to set up and manage Telegram webhook
 */

export interface WebhookSetupConfig {
    botToken: string;
    webhookUrl: string;
    allowedUpdates?: string[];
}

/**
 * Set up the Telegram webhook
 */
export async function setupTelegramWebhook(config: WebhookSetupConfig): Promise<boolean> {
    try {
        const response = await axios.post(
            `https://api.telegram.org/bot${config.botToken}/setWebhook`,
            {
                url: config.webhookUrl,
                allowed_updates: config.allowedUpdates || [
                    "message",
                    "inline_query",
                    "callback_query",
                    "channel_post",
                    "edited_message",
                ],
            },
        );

        if (response.data.ok) {
            console.log("✅ Telegram webhook set up successfully");
            console.log(`📡 Webhook URL: ${config.webhookUrl}`);
            return true;
        } else {
            console.error("❌ Failed to set up webhook:", response.data.description);
            return false;
        }
    } catch (error) {
        console.error("❌ Error setting up webhook:", error);
        return false;
    }
}

/**
 * Get current webhook info
 */
// WARN: Should define a proper type for the return value
// eslint-disable-next-line @typescript-eslint/no-explicit-any
export async function getWebhookInfo(botToken: string): Promise<any> {
    try {
        const response = await axios.get(
            `https://api.telegram.org/bot${botToken}/getWebhookInfo`,
        );

        if (response.data.ok) {
            console.log("📋 Current webhook info:", response.data.result);
            return response.data.result;
        } else {
            console.error("❌ Failed to get webhook info:", response.data.description);
            return null;
        }
    } catch (error) {
        console.error("❌ Error getting webhook info:", error);
        return null;
    }
}

/**
 * Delete the current webhook
 */
export async function deleteWebhook(botToken: string): Promise<boolean> {
    try {
        const response = await axios.post(
            `https://api.telegram.org/bot${botToken}/deleteWebhook`,
        );

        if (response.data.ok) {
            console.log("✅ Webhook deleted successfully");
            return true;
        } else {
            console.error("❌ Failed to delete webhook:", response.data.description);
            return false;
        }
    } catch (error) {
        console.error("❌ Error deleting webhook:", error);
        return false;
    }
}

/**
 * Get bot information
 */
// WARN: Should define a proper type for the return value
// eslint-disable-next-line @typescript-eslint/no-explicit-any
export async function getBotInfo(botToken: string): Promise<any> {
    try {
        const response = await axios.get(
            `https://api.telegram.org/bot${botToken}/getMe`,
        );

        if (response.data.ok) {
            console.log("🤖 Bot info:", response.data.result);
            return response.data.result;
        } else {
            console.error("❌ Failed to get bot info:", response.data.description);
            return null;
        }
    } catch (error) {
        console.error("❌ Error getting bot info:", error);
        return null;
    }
}

/**
 * Example usage script - you can call this from your deployment script
 */
export async function initializeTelegramBot() {
    const botToken = process.env.TELEGRAM_BOT_TOKEN;

    if (!botToken) {
        console.error("❌ TELEGRAM_BOT_TOKEN environment variable is not set");
        return false;
    }

    // Get bot info first
    const botInfo = await getBotInfo(botToken);
    if (!botInfo) {
        return false;
    }

    console.log(`🤖 Setting up webhook for bot: @${botInfo.username}`);

    // Determine the webhook URL based on your environment
    const baseUrl = "https://us-central1-semur-ai.cloudfunctions.net";

    const webhookUrl = `${baseUrl}/external_app_telegram${SemurEngineConfig.isDev ? "-dev" : ""}-bot`;

    // Set up the webhook
    const success = await setupTelegramWebhook({
        botToken,
        webhookUrl,
    });

    if (success) {
        console.log("✅ Telegram bot initialization completed");
        console.log(`📱 Bot username: @${botInfo.username}`);
        console.log(`🔗 Webhook URL: ${webhookUrl}`);
    }

    return success;
}
