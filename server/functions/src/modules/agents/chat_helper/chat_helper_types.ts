import {z} from "genkit";

export const ZodChatHelperGenerateNameInput = z.object({
    questionText: z.string().describe("The question or topic for which a concise chat name is to be generated."),
});

export const ZodChatHelperGenerateNameOutput = z.object({
    name: z.string().describe("The generated concise chat name."),
});

export const ZodChatHelperGenerateFollowupQuestionsInput = z.object({
    questionText: z.string().describe("The question or topic for which a response be generated."),
    responseText: z.string().describe("The response text based on which follow-up questions are to be generated."),
});

export const ZodChatHelperGenerateFollowupQuestionsOutput = z.object({
    followupQuestions: z.array(z.string()).describe("A list of follow-up questions related to the original question and response."),
});
