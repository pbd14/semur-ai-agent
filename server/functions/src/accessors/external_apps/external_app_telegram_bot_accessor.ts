import {SemurEngineConfig} from "../../config";
import {SemurEngineErrorBuilder} from "../../semur_engine/semur_engine";
import {TelegramBotIntegration} from "../../models.pb/external_apps/telegram_bot_integration";

export enum ExternalAppTelegramBotQueryKey {
    All = "all",
}


// User query arguments from query key
export interface ExternalAppTelegramBotQueryArgs {
    [ExternalAppTelegramBotQueryKey.All]: Record<string, never>;
}

export class ExternalAppTelegramBotAccessor {
    static firestoreCollectionName = "external_app_telegram_bot";
    static firestoreCollection = SemurEngineConfig.db.collection(this.firestoreCollectionName);

    static async exists(userId: string): Promise<boolean> {
        const snapshot = await this.firestoreCollection.doc(userId).get();
        return snapshot.exists;
    }

    static async get(integrationId: string): Promise<TelegramBotIntegration> {
        const snapshot = await this.firestoreCollection.doc(integrationId).get();
        if (!snapshot.exists) {
            throw SemurEngineErrorBuilder.notFound("integration not found");
        }
        return TelegramBotIntegration.fromJSON(snapshot.data() as Record<string, unknown>);
    }

    static async set(integration: TelegramBotIntegration): Promise<void> {
        await this.firestoreCollection.doc(integration.id).set({...integration});
    }

    static async delete(integrationId: string): Promise<void> {
        await this.firestoreCollection.doc(integrationId).delete();
    }

    static async update(integration: TelegramBotIntegration): Promise<void> {
        await this.firestoreCollection.doc(integration.id).update({...integration});
    }

    static async updateCustomFields(userId: string, data: { [key: string]: unknown }): Promise<void> {
        await this.firestoreCollection.doc(userId).update(data);
    }

    static async query(
        queryKey: ExternalAppTelegramBotQueryKey,
        args: ExternalAppTelegramBotQueryArgs[ExternalAppTelegramBotQueryKey] = {},
    ): Promise<TelegramBotIntegration[]> {
        const query = await this.buildQuery(queryKey, args);
        const querySnapshot = await query.get();
        return querySnapshot.docs.map((doc) => TelegramBotIntegration.fromJSON(doc.data() as Record<string, unknown>));
    }

    // Build query given query key and arguments
    static async buildQuery(
        queryKey: ExternalAppTelegramBotQueryKey,
        args: ExternalAppTelegramBotQueryArgs[ExternalAppTelegramBotQueryKey] = {},
    ): Promise<FirebaseFirestore.Query> {
        if (!this.firestoreCollection) {
            throw SemurEngineErrorBuilder.internalError("Firebase collection is not defined");
        }
        switch (queryKey) {
            case ExternalAppTelegramBotQueryKey.All:
                return this.firestoreCollection;
            default:
                throw SemurEngineErrorBuilder.internalError(`Unknown query key: ${queryKey}`);
        }
    }
}
