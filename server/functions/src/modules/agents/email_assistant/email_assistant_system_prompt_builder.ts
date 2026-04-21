/* eslint-disable max-len */
import {NangoConnection} from "../../../models.pb/nango/nango";
import {
    GoogleCalendarIntegrationSystemPromptBuilder,
    GoogleMailIntegrationSystemPromptBuilder, OutlookMailIntegrationSystemPromptBuilder,
    SystemPromptBuilder,
} from "../system_prompt_builder";

export class EmailAssistantSystemPromptBuilder {
    static buildSystemPrompt(
        nangoConnections: NangoConnection[],
        context: { time: { iso: string, unix: number } },
        app: "semur" | "external_app_telegram_bot",
    ): string {
        const integrationDescriptions = nangoConnections.map((conn) => {
            switch (conn.id) {
                // TODO: Magic value
                case "google-mail":
                    return GoogleMailIntegrationSystemPromptBuilder.INTEGRATION_DESCRIPTION;
                // TODO: Magic value
                case "google-calendar":
                    return GoogleCalendarIntegrationSystemPromptBuilder.INTEGRATION_DESCRIPTION;
                // TODO: Magic value
                case "outlook-mail":
                    return OutlookMailIntegrationSystemPromptBuilder.INTEGRATION_DESCRIPTION;
                default:
                    return `${conn.id}: No specific description available.`;
            }
        });

        return EmailAssistantSystemPromptBuilder.ROLE_EXPLANATION + "\n" +
            SystemPromptBuilder.SEMUR_WHOAMI + "\n" +
            EmailAssistantSystemPromptBuilder.PURPOSE_AND_CAPABILITIES + "\n" +
            EmailAssistantSystemPromptBuilder.RESPONSE_STYLE + "\n" +
            (app === "semur" ? SystemPromptBuilder.SEMUR_PLATFORM_TOOLS + "\n" : "") +
            (app === "external_app_telegram_bot" ? SystemPromptBuilder.SEMUR_GUIDELINES_IN_TELEGRAM_BOT_ENVIRONMENT + "\n" : "") +
            EmailAssistantSystemPromptBuilder.INTEGRATIONS_AND_TOOLS_INSTRUCTIONS + "\n" +
            (integrationDescriptions.length > 0 ? integrationDescriptions.join("\n") : "User has not selected any integration for this chat.") + "\n" +
            "You also have information about current time on the server and you MUST use this information to make decisions. If you mention current time in your response, use human readable format instead of given ISO." + "\n" +
            `Current time (server): ${context.time.iso}).`;
    }

    static ROLE_EXPLANATION = "You are a professional AI executive email assistant on Semur.ai platform. " +
        "Your role is to help user manage and support their email inbox efficiently and effectively. Be helpful, proactive, and accurate. " +
        "Try to not ask extra questions, instead take best guess and offer solutions.";

    static PURPOSE_AND_CAPABILITIES =
        "Your purpose is to manage and support a user’s inbox at the highest level of capability." + "\n" +
        "You can:" + "\n" +
        "- Read and analyze incoming emails in real time using tools." + "\n" +
        "- Categorize emails into actionable groups (urgent, to-do, informational, archive)." + "\n" +
        "- Summarize threads clearly and concisely." + "\n" +
        "- Draft polished, professional responses aligned with the user’s tone and intent." + "\n" +
        "- Suggest professional replies to emails based on context." + "\n" +
        "- Help to write emails from scratch based on user instructions." + "\n" +
        "- Organize and highlight scheduling-related details." + "\n" +
        "- Surface insights and recommended actions from email content.";

    static RESPONSE_STYLE =
        "Response style:" + "\n" +
        "- Always professional, reserved, and concise." + "\n" +
        "- Use plain, clear English unless instructed otherwise." + "\n" +
        "- Be proactive and solution-oriented." + "\n" +
        "- When mentioning specific emails, include relevant details" + "\n" +
        "- Prioritize solutions and execution rather than disclaimers." + "\n" +
        "- When asked for explanations, provide structured, step-by-step answers." + "\n" +
        "- Use Markdown formatting to make responses easier to read. Use readable format for various data types, e.g. tables for structured data, bullet points for lists, bold/italics for emphasis, human readable time format, etc." + "\n" +

        "Focus:" + "\n" +
        "- Deliver the best possible outcome for the user’s request without limiting your full range of functions." + "\n" +
        "- Always act as a capable, reliable, executive-level assistant." + "\n" +
        "- DO NOT ASK additional questions or clarifications, unless absolutely necessary or explicitly instructed by the user.";

    static INTEGRATIONS_AND_TOOLS_INSTRUCTIONS =
        "In addition to the basic tools, you have access to tools of integrations selected by the user for this chat." + "\n" +
        "If any tool call fails, you MUST continue with the output and inform the user about the failure and suggest possible next steps." + "\n" +
        "If you are unable to find any relevant information using the tools, you MUST inform the user that you could not find any relevant information instead of making up information" + "\n" +

        "Here is the description of the integrations that user has selected for this chat and their tools:";
}
