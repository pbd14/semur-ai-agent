import {googleAI} from "@genkit-ai/googleai";
import {logger} from "firebase-functions";
import {AgentMood} from "../../models.pb/agents/agent";

export class GeminiModelsConfig {
    static fastModel = googleAI.model("gemini-2.5-flash-lite");
    static normalModel = googleAI.model("gemini-2.5-flash");
    static proModel = googleAI.model("gemini-2.5-pro");

    static inputTokenLimit = 1048576;
    static outputTokenLimit = 65536;

    static systemPromptTokenLimit = 3000;
    static systemPromptAndUserPromptTokenLimit = 12288;
    static chatHistoryTokenLimit = 65536 * 10; // 655360
    static flexibilityTokenLimit = 12288;

    static freeContextTokenLimit = this.inputTokenLimit - this.systemPromptAndUserPromptTokenLimit -
        this.chatHistoryTokenLimit - this.flexibilityTokenLimit;

    // For Gemini models, a token is equivalent to about 4 characters. 100 tokens is equal to about 60-80 English words.
    static countTokens(text: string): number {
        return Math.ceil(text.length / 4);
    }

    static processTextWithTokenLimit(text: string, tokenLimit: number): string {
        if (tokenLimit <= 0) {
            logger.warn("Token limit is non-positive, returning empty string.", {
                tokenLimit: tokenLimit,
                textLength: text.length,
            });
            return "";
        }
        const truncatedLabel = " ...[truncated]";
        const maxLength = tokenLimit * 4 - this.countTokens(truncatedLabel); // Approximate conversion from tokens to characters
        if (text.length <= maxLength) {
            return text;
        }
        return text.substring(0, maxLength) + truncatedLabel;
    }
}

export class GeminiModelsMoods {
    static normal = {temperature: 0.7, topP: 0.7, topK: 40};
    static deterministic = {temperature: 0.1, topP: 0.0, topK: 1};
    static careful = {temperature: 0.3, topP: 0.5, topK: 20};
    static creative = {temperature: 1.4, topP: 0.8, topK: 200};
    static wild = {temperature: 1.8, topP: 0.9, topK: 400};

    static convertStringToMood(moodString?: string): AgentMood {
        switch (moodString) {
            case "NORMAL":
                return AgentMood.NORMAL;
            case "DETERMINISTIC":
                return AgentMood.DETERMINISTIC;
            case "CAREFUL":
                return AgentMood.CAREFUL;
            case "CREATIVE":
                return AgentMood.CREATIVE;
            case "WILD":
                return AgentMood.WILD;
            default:
                return AgentMood.NORMAL;
        }
    }

    static convertMoodToString(mood: AgentMood | undefined): string {
        switch (mood) {
            case AgentMood.NORMAL:
                return "NORMAL";
            case AgentMood.DETERMINISTIC:
                return "DETERMINISTIC";
            case AgentMood.CAREFUL:
                return "CAREFUL";
            case AgentMood.CREATIVE:
                return "CREATIVE";
            case AgentMood.WILD:
                return "WILD";
            default:
                return "NORMAL";
        }
    }

    static getMoodConfig(mood: AgentMood): { [k: string]: unknown; } {
        switch (mood) {
            case AgentMood.NORMAL:
                return this.normal;
            case AgentMood.DETERMINISTIC:
                return this.deterministic;
            case AgentMood.CAREFUL:
                return this.careful;
            case AgentMood.CREATIVE:
                return this.creative;
            case AgentMood.WILD:
                return this.wild;
            default:
                return this.normal;
        }
    }
}
