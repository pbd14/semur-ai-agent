import {defineSecret} from "firebase-functions/params";

type DefinedSecret = ReturnType<typeof defineSecret>;

export type RuntimeSecretBinding = string | DefinedSecret;

export const RuntimeSecrets = {
    // Retained for compatibility with the current Semur Firebase environment.
    nango: defineSecret("NANGO_SECRET_KEY_DEV"),
    googleAI: defineSecret("GOOGLE_GENAI_API_KEY"),
    telegramBot: defineSecret("TELEGRAM_BOT_TOKEN"),
} as const;

function readSecret(secret: DefinedSecret): string {
    const value = secret.value();
    if (!value) {
        throw new Error(`Required secret ${secret.name} is not configured.`);
    }
    return value;
}

export function getNangoSecret(): string {
    return readSecret(RuntimeSecrets.nango);
}

export function getTelegramBotToken(): string {
    return readSecret(RuntimeSecrets.telegramBot);
}
