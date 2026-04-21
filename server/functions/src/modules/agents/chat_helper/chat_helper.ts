import {generateChatNameFlow, generateFollowupQuestionsFlow} from "./chat_helper_ai";

export class ChatHelper {
    static async generateChatName(questionText: string): Promise<string> {
        // Placeholder implementation
        if (!questionText || questionText.trim() === "") {
            return "Untitled Chat";
        }
        const chatHelperGenerateNameOutput = await generateChatNameFlow({questionText});
        return chatHelperGenerateNameOutput.name;
    }

    static async generateFollowupQuestions(questionText: string, responseText: string): Promise<string[]> {
        // Placeholder implementation
        if (!questionText || questionText.trim() === "" || !responseText || responseText.trim() === "") {
            return [];
        }
        const chatHelperGenerateFollowupQuestionsOutput = await generateFollowupQuestionsFlow({
            questionText,
            responseText,
        });
        return chatHelperGenerateFollowupQuestionsOutput.followupQuestions;
    }
}
