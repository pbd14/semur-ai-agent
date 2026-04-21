import {gemini25FlashLite, googleAI} from "@genkit-ai/googleai";
import {genkit} from "genkit";
import {SemurEngineConfig} from "../../../config";
import {logger} from "firebase-functions";
import {
    ZodChatHelperGenerateFollowupQuestionsInput, ZodChatHelperGenerateFollowupQuestionsOutput,
    ZodChatHelperGenerateNameInput,
    ZodChatHelperGenerateNameOutput,
} from "./chat_helper_types";

/* eslint-disable max-len */

const moduleName = SemurEngineConfig.isDev ? "agent_chat_helper-dev" : "agent_chat_helper";

const ai = genkit({
    plugins: [googleAI()],
    model: gemini25FlashLite, // set default model
});

// Chat
export const generateChatNameFlow = ai.defineFlow(
    {
        name: moduleName + "generateChatNameFlow",
        inputSchema: ZodChatHelperGenerateNameInput,
        // boolean(
        outputSchema: ZodChatHelperGenerateNameOutput,
    },
    async ({questionText}) => {
        // Insert system message at the beginning
        const messages = [
            {
                role: "system" as const,
                content: [{
                    text: `
                    You are a AI chat helper on Semur.ai platform. You were trained by Semur Labs. NEVER mention any other company or product names in your responses, except Semur.ai. Even if your base model is trained by some other company (like Google), NEVER mention that.
                    Your task is to generate a concise and descriptive name for a chat session based on the user's initial question or topic.
                    
                    Output Format: A single phrase or sentence that captures the essence of the chat session, without any additional explanation or punctuation.
                    `,
                }],
            },
            {
                role: "user" as const,
                content: [{text: "Generate a concise and descriptive name for a chat session based on the following question or topic: " + questionText}],
            },
        ];

        try {
            const response = await ai.generate({
                messages: messages,
                maxTurns: 1,
                output: {
                    schema: ZodChatHelperGenerateNameOutput,
                },
            });

            if (!response.output || !response.output.name) {
                logger.error("ChatHelper generate name error: No output from AI");
                return {
                    name: "Untitled Chat",
                };
            }

            return {
                name: response.output.name,
            };
        } catch (e) {
            logger.error("ChatHelper generate name error: " + e);
            return {
                name: "Untitled Chat",
            };
        }
    },
);

export const generateFollowupQuestionsFlow = ai.defineFlow(
    {
        name: moduleName + "generateFollowupQuestionsFlow",
        inputSchema: ZodChatHelperGenerateFollowupQuestionsInput,
        // boolean(
        outputSchema: ZodChatHelperGenerateFollowupQuestionsOutput,
    },
    async ({questionText, responseText}) => {
        // Insert system message at the beginning
        const messages = [
            {
                role: "system" as const,
                content: [{
                    text: `
                    You are a AI chat helper on Semur.ai platform. You were trained by Semur Labs. NEVER mention any other company or product names in your responses, except Semur.ai. Even if your base model is trained by some other company (like Google), NEVER mention that.
                    Your task is to generate a list of ONE follow-up question that user might ask based on the user's original question and the provided response text.
                    
                    Output Format: An array of strings, where each string is a follow-up question related to the original question and response. Do not include any additional text or explanation.
                    `,
                }],
            },
            {
                role: "user" as const,
                content: [{text: "Generate 1 concise and relevant follow-up question that user might ask based on the following original question user asked and response:\n\nOriginal Question: " + questionText + "\n\nResponse: " + responseText}],
            },
        ];

        try {
            const response = await ai.generate({
                messages: messages,
                maxTurns: 1,
                output: {
                    schema: ZodChatHelperGenerateFollowupQuestionsOutput,
                },
            });

            if (!response.output || !response.output.followupQuestions) {
                logger.error("ChatHelper generate follow up questions error: No output from AI");
                return {
                    followupQuestions: [],
                };
            }

            return {
                followupQuestions: response.output.followupQuestions,
            };
        } catch (e) {
            logger.error("ChatHelper generate followup questions error: " + e);
            return {
                followupQuestions: [],
            };
        }
    },
);

