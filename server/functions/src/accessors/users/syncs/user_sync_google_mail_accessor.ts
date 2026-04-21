import {SemurEngineConfig} from "../../../config";
import {SemurEngineErrorBuilder} from "../../../semur_engine/semur_engine";
import {UserAccessor} from "../user_accessor";
import {SyncInformation} from "../../../models.pb/syncs/sync";
import {SyncGoogleMailEmail} from "../../../models.pb/syncs/sync_google-mail";
import {firestore} from "firebase-admin";
import Timestamp = firestore.Timestamp;

export enum UserSyncGoogleMailQueryKey {
    All = "all",
    CommonFilters = "commonFilters",
}

export interface UserSyncGoogleMailQueryArgs {
    [UserSyncGoogleMailQueryKey.All]: {
        userId: string;
        nangoIntegrationId: string;
        limit?: number;
    };
    [UserSyncGoogleMailQueryKey.CommonFilters]: {
        userId: string;
        nangoIntegrationId: string;
        from?: Timestamp;
        to?: Timestamp;
        threadId?: boolean;
        limit?: number;
    };
}

export class UserSyncGoogleMailAccessor {
    static firestoreCollectionName = "syncs";
    static firestoreSyncDocumentId = "sync";
    static firestoreUsersCollection = SemurEngineConfig.db.collection(UserAccessor.firestoreCollectionName);
    static firestoreNangoConnectionsSubcollectionName = "nango_connections";

    static async exists(userId: string, nangoIntegrationId: string, syncDocumentId: string): Promise<boolean> {
        const snapshot =
            await this.firestoreUsersCollection
                .doc(userId).collection(this.firestoreNangoConnectionsSubcollectionName)
                .doc(nangoIntegrationId).collection(this.firestoreCollectionName)
                .doc(syncDocumentId).get();
        return snapshot.exists;
    }

    static async get(userId: string, nangoIntegrationId: string, syncDocumentId: string): Promise<SyncGoogleMailEmail> {
        const snapshot = await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreNangoConnectionsSubcollectionName)
            .doc(nangoIntegrationId).collection(this.firestoreCollectionName)
            .doc(syncDocumentId).get();
        if (!snapshot.exists) {
            throw SemurEngineErrorBuilder.notFound("Sync information not found");
        }
        return SyncGoogleMailEmail.fromJSON(snapshot.data() as Record<string, unknown>);
    }

    static async set(userId: string, nangoIntegrationId: string, syncDocument: SyncGoogleMailEmail): Promise<void> {
        await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreNangoConnectionsSubcollectionName)
            .doc(nangoIntegrationId).collection(this.firestoreCollectionName)
            .doc(syncDocument.id).set({...syncDocument});
    }

    static async delete(userId: string, nangoIntegrationId: string, syncDocumentId: string): Promise<void> {
        await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreNangoConnectionsSubcollectionName)
            .doc(nangoIntegrationId).collection(this.firestoreCollectionName)
            .doc(syncDocumentId).delete();
    }

    static async update(userId: string, nangoIntegrationId: string, syncDocument: SyncGoogleMailEmail): Promise<void> {
        await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreNangoConnectionsSubcollectionName)
            .doc(nangoIntegrationId).collection(this.firestoreCollectionName)
            .doc(syncDocument.id).update({...syncDocument});
    }

    static async updateCustomFields(userId: string, nangoIntegrationId: string, syncDocumentId: string, data: {
        [key: string]: unknown
    }): Promise<void> {
        await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreNangoConnectionsSubcollectionName)
            .doc(nangoIntegrationId).collection(this.firestoreCollectionName)
            .doc(syncDocumentId).update(data);
    }

    static async query(
        queryKey: UserSyncGoogleMailQueryKey,
        args: UserSyncGoogleMailQueryArgs[UserSyncGoogleMailQueryKey],
    ): Promise<SyncGoogleMailEmail[]> {
        const query = await this.buildQuery(queryKey, args);
        const querySnapshot = await query.get();
        return querySnapshot.docs.map((doc) => SyncGoogleMailEmail.fromJSON(doc.data() as Record<string, unknown>));
    }

    // Build query given query key and arguments
    static async buildQuery(
        queryKey: UserSyncGoogleMailQueryKey,
        args: UserSyncGoogleMailQueryArgs[UserSyncGoogleMailQueryKey],
    ): Promise<FirebaseFirestore.Query> {
        if (!this.firestoreUsersCollection) {
            throw SemurEngineErrorBuilder.internalError("Firebase users collection is not defined");
        }
        switch (queryKey) {
            case UserSyncGoogleMailQueryKey.All: {
                const baseQuery = this.firestoreUsersCollection
                    .doc(args.userId).collection(this.firestoreNangoConnectionsSubcollectionName)
                    .doc(args.nangoIntegrationId).collection(this.firestoreCollectionName)
                    // Exclude the sync document itself
                    .where("id", "!=", this.firestoreSyncDocumentId);
                if (args.limit) {
                    return baseQuery.limit(args.limit);
                }
                return baseQuery;
            }
            case UserSyncGoogleMailQueryKey.CommonFilters: {
                const commonArgs = args as UserSyncGoogleMailQueryArgs[UserSyncGoogleMailQueryKey.CommonFilters];
                let baseQuery = this.firestoreUsersCollection
                    .doc(commonArgs.userId).collection(this.firestoreNangoConnectionsSubcollectionName)
                    .doc(commonArgs.nangoIntegrationId).collection(this.firestoreCollectionName)
                    // Exclude the sync document itself
                    .where("id", "!=", this.firestoreSyncDocumentId);
                if (commonArgs.from) {
                    baseQuery = baseQuery.where("date", ">=", commonArgs.from);
                }
                if (commonArgs.to) {
                    baseQuery = baseQuery.where("date", "<=", commonArgs.to);
                }
                if (commonArgs.threadId) {
                    baseQuery = baseQuery.where("threadId", "==", commonArgs.threadId);
                }
                baseQuery = baseQuery.orderBy("date", "desc");
                if (commonArgs.limit) {
                    return baseQuery.limit(commonArgs.limit);
                }
                return baseQuery;
            }
            default:
                throw SemurEngineErrorBuilder.internalError(`Unknown query key: ${queryKey}`);
        }
    }

    // Sync information
    static async existsSyncInfo(userId: string, nangoIntegrationId: string): Promise<boolean> {
        const snapshot =
            await this.firestoreUsersCollection
                .doc(userId).collection(this.firestoreNangoConnectionsSubcollectionName)
                .doc(nangoIntegrationId).collection(this.firestoreCollectionName)
                .doc(this.firestoreSyncDocumentId).get();
        return snapshot.exists;
    }

    static async getSyncInfo(userId: string, nangoIntegrationId: string): Promise<SyncInformation> {
        const snapshot = await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreNangoConnectionsSubcollectionName)
            .doc(nangoIntegrationId).collection(this.firestoreCollectionName)
            .doc(this.firestoreSyncDocumentId).get();
        if (!snapshot.exists) {
            throw SemurEngineErrorBuilder.notFound("Sync information not found");
        }
        return SyncInformation.fromJSON(snapshot.data() as Record<string, unknown>);
    }

    static async setSyncInfo(userId: string, nangoIntegrationId: string, sync: SyncInformation): Promise<void> {
        await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreNangoConnectionsSubcollectionName)
            .doc(nangoIntegrationId).collection(this.firestoreCollectionName)
            .doc(this.firestoreSyncDocumentId).set({...sync});
    }

    static async deleteSyncInfo(userId: string, nangoIntegrationId: string): Promise<void> {
        await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreNangoConnectionsSubcollectionName)
            .doc(nangoIntegrationId).collection(this.firestoreCollectionName)
            .doc(this.firestoreSyncDocumentId).delete();
    }

    static async updateSyncInfo(userId: string, nangoIntegrationId: string, sync: SyncInformation): Promise<void> {
        await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreNangoConnectionsSubcollectionName)
            .doc(nangoIntegrationId).collection(this.firestoreCollectionName)
            .doc(this.firestoreSyncDocumentId).update({...sync});
    }

    static async updateCustomFieldsSyncInfo(userId: string, nangoConnectionId: string, data: {
        [key: string]: unknown
    }): Promise<void> {
        await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreNangoConnectionsSubcollectionName)
            .doc(nangoConnectionId).collection(this.firestoreCollectionName)
            .doc(this.firestoreSyncDocumentId).update(data);
    }
}
