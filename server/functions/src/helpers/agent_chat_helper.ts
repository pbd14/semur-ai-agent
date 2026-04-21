import {ChatArtifacts, ChatRole} from "../models.pb/chats/chat";
import {AgentMood, AgentTool} from "../models.pb/agents/agent";
import {logger} from "firebase-functions";
import {GenerateResponse} from "@genkit-ai/ai";
import {GeminiModelsConfig} from "../modules/agents/gemini_models_config";
import {Genkit, ToolAction} from "genkit";

export class AgentChatHelper {
    static transformChatRoleToGenkitRole(role: ChatRole): "system" | "user" | "model" | "tool" {
        switch (role) {
            case ChatRole.USER:
                return "user";
            case ChatRole.MODEL:
                return "model";
            case ChatRole.SYSTEM:
                return "system";
            case ChatRole.TOOL:
                // TODO: Warning: using model role for tool, as there are some problem when getting chat history with tool role
                return "model";
            default:
                return "user";
        }
    }

    static nameFromAgentTool(tool: AgentTool) {
        switch (tool) {
            case AgentTool.SEMUR_CHAT_MENTION_EMAIL:
                return "Mention Email";
            // GOOGLE MAIL
            case AgentTool.GOOGLE_MAIL_GET_EMAILS:
                return "Get Emails from Google Mail";
            case AgentTool.GOOGLE_MAIL_GET_EMAIL_BY_ID:
                return "Get Email by ID from Google Mail";
            case AgentTool.GOOGLE_MAIL_SEARCH_COMMON_FILTERS:
                return "Search Emails with Common Filters in Google Mail";
            case AgentTool.GOOGLE_MAIL_VECTOR_SEARCH:
                return "Search Emails in Google Mail using Vector Search";
            case AgentTool.GOOGLE_MAIL_GET_SYNC_INFORMATION:
                return "Get Google Mail Sync Information";
            case AgentTool.GOOGLE_MAIL_SYNC:
                return "Sync Google Mail Emails";
            case AgentTool.GOOGLE_MAIL_SEND_EMAIL:
                return "Send Email via Google Mail";

            // GOOGLE CALENDAR
            case AgentTool.GOOGLE_CALENDAR_GET_EVENTS:
                return "Get Events from Google Calendar";
            case AgentTool.GOOGLE_CALENDAR_SEARCH_COMMON_FILTERS:
                return "Search Events with Common Filters in Google Calendar";
            case AgentTool.GOOGLE_CALENDAR_VECTOR_SEARCH:
                return "Search Events in Google Calendar using Vector Search";
            case AgentTool.GOOGLE_CALENDAR_GET_SYNC_INFORMATION:
                return "Get Google Calendar Sync Information";
            case AgentTool.GOOGLE_CALENDAR_SYNC:
                return "Sync Google Calendar Events";
            case AgentTool.UNRECOGNIZED:
                return "Unknown Tool";

            // OUTLOOK MAIL
            // GOOGLE MAIL
            case AgentTool.OUTLOOK_MAIL_GET_EMAILS:
                return "Get Emails from Outlook Mail";
            case AgentTool.OUTLOOK_MAIL_GET_EMAIL_BY_ID:
                return "Get Email by ID from Outlook Mail";
            case AgentTool.OUTLOOK_MAIL_SEARCH_COMMON_FILTERS:
                return "Search Emails with Common Filters in Outlook Mail";
            case AgentTool.OUTLOOK_MAIL_VECTOR_SEARCH:
                return "Search Emails in Outlook Mail using Vector Search";
            case AgentTool.OUTLOOK_MAIL_GET_SYNC_INFORMATION:
                return "Get Outlook Mail Sync Information";
            case AgentTool.OUTLOOK_MAIL_SYNC:
                return "Sync Outlook Mail Emails";
            case AgentTool.OUTLOOK_MAIL_SEND_EMAIL:
                return "Send Email via Outlook Mail";
        }
    }

    static descriptionFromAgentTool(tool: AgentTool) {
        switch (tool) {
            case AgentTool.SEMUR_CHAT_MENTION_EMAIL:
                return "Mentioning an email";
            // GOOGLE MAIL
            case AgentTool.GOOGLE_MAIL_GET_EMAILS:
                return "Fetch relevant emails from Google Mail";
            case AgentTool.GOOGLE_MAIL_GET_EMAIL_BY_ID:
                return "Fetch email details from Google Mail by email ID";
            case AgentTool.GOOGLE_MAIL_SEARCH_COMMON_FILTERS:
                return "Search emails in Google Mail using common filters";
            case AgentTool.GOOGLE_MAIL_VECTOR_SEARCH:
                return "Search emails in Google Mail using vector search";
            case AgentTool.GOOGLE_MAIL_GET_SYNC_INFORMATION:
                return "Get information about the Google Mail sync status";
            case AgentTool.GOOGLE_MAIL_SYNC:
                return "Sync emails from Google Mail";
            case AgentTool.GOOGLE_MAIL_SEND_EMAIL:
                return "Send an email using Google Mail";

            // GOOGLE CALENDAR
            case AgentTool.GOOGLE_CALENDAR_GET_EVENTS:
                return "Fetch relevant events from Google Calendar";
            case AgentTool.GOOGLE_CALENDAR_SEARCH_COMMON_FILTERS:
                return "Search events in Google Calendar using common filters";
            case AgentTool.GOOGLE_CALENDAR_VECTOR_SEARCH:
                return "Search events in Google Calendar using vector search";
            case AgentTool.GOOGLE_CALENDAR_GET_SYNC_INFORMATION:
                return "Get information about the Google Calendar sync status";
            case AgentTool.GOOGLE_CALENDAR_SYNC:
                return "Sync events from Google Calendar";
            case AgentTool.UNRECOGNIZED:
                return "Using unknown tool";

            // OUTLOOK MAIL
            case AgentTool.OUTLOOK_MAIL_GET_EMAILS:
                return "Fetch relevant emails from Outlook Mail";
            case AgentTool.OUTLOOK_MAIL_GET_EMAIL_BY_ID:
                return "Fetch email details from Outlook Mail by email ID";
            case AgentTool.OUTLOOK_MAIL_SEARCH_COMMON_FILTERS:
                return "Search emails in Outlook Mail using common filters";
            case AgentTool.OUTLOOK_MAIL_VECTOR_SEARCH:
                return "Search emails in Outlook Mail using vector search";
            case AgentTool.OUTLOOK_MAIL_GET_SYNC_INFORMATION:
                return "Get information about the Outlook Mail sync status";
            case AgentTool.OUTLOOK_MAIL_SYNC:
                return "Sync emails from Outlook Mail";
            case AgentTool.OUTLOOK_MAIL_SEND_EMAIL:
                return "Send an email using Outlook Mail";
        }
    }

    static getArtifactsMessage(artifacts: ChatArtifacts | undefined) {
        if (!artifacts || Object.keys(artifacts).length === 0) {
            return "";
        }
        return `\n\nArtifacts of this message:\n${JSON.stringify(artifacts, null, 2)}`;
    }

    static getMessageDate(date: Date | undefined): string {
        if (!date) {
            return "";
        }
        return "\n\nDate of this message: " + date.toISOString();
    }

    static async callAiGenerateWithRetry(
        ai: Genkit,
        fastMode = false,
        proMode = false,
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        messages: any,
        tools: ToolAction[],
        agentMood: AgentMood,
        maxTurns = 20,
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        context?: any,
        retries = 2,
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
    ): Promise<GenerateResponse<any>> {
        try {
            logger.info("AI Generate call", {
                model: fastMode ? GeminiModelsConfig.fastModel : (proMode ? GeminiModelsConfig.proModel : GeminiModelsConfig.normalModel),
                messages: messages,
                tools: tools.map((t) => t),
                maxTurns: maxTurns,
                context: context,
            });
            logger.info("Tools available", tools.map((t) => t));

            const response = await ai.generate({
                model: fastMode ? GeminiModelsConfig.fastModel : (proMode ? GeminiModelsConfig.proModel : GeminiModelsConfig.normalModel),
                messages: messages,
                tools: tools,
                maxTurns: maxTurns,
                context: context,
                // TODO: Enable later
                // config: GeminiModelsMoods.getMoodConfig(agentMood),
            });

            if (!response.text || response.text.trim() === "") {
                throw new Error("Empty response text");
            }
            return response;
        } catch (e) {
            logger.warn("Retrying AI generate due to error", {error: e});
            if (retries > 0) {
                return this.callAiGenerateWithRetry(
                    ai,
                    fastMode,
                    proMode,
                    messages,
                    tools,
                    agentMood,
                    maxTurns,
                    context,
                    retries - 1,
                );
            } else {
                throw e;
            }
        }
    }
}
