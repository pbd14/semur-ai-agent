import {SemurEngineConfig} from "../../config";
import {SemurUser} from "../../models.pb/user/user";
import {SemurEngineErrorBuilder} from "../../semur_engine/semur_engine";
import {NangoConnection, NangoConnectionStatus} from "../../models.pb/nango/nango";

export enum UserQueryKey {
    All = "all",
}

export enum UserNangoConnectionQueryKey {
    All = "all",
    Active = "active",
}

// User query arguments from query key
export interface UserQueryArgs {
    [UserQueryKey.All]: Record<string, never>;
}

export interface UserNangoConnectionQueryArgs {
    [UserNangoConnectionQueryKey.All]: {
        userId: string;
    };
    [UserNangoConnectionQueryKey.Active]: {
        userId: string;
    };
}

export class UserAccessor {
    static firestoreCollectionName = "users";
    static firestoreCollection = SemurEngineConfig.db.collection(this.firestoreCollectionName);
    static firestoreNangoConnectionIdToUserIdMappingCollectionName = "nango_connection_id_to_user_id_mapping";
    static firestoreNangoConnectionIdToUserIdMappingCollection =
        SemurEngineConfig.db.collection(this.firestoreNangoConnectionIdToUserIdMappingCollectionName);
    static firestoreNangoConnectionsSubcollectionName = "nango_connections";

    static async exists(userId: string): Promise<boolean> {
        const snapshot = await this.firestoreCollection.doc(userId).get();
        return snapshot.exists;
    }

    static async get(userId: string): Promise<SemurUser> {
        const snapshot = await this.firestoreCollection.doc(userId).get();
        if (!snapshot.exists) {
            throw SemurEngineErrorBuilder.notFound("User not found");
        }
        return SemurUser.fromJSON(snapshot.data() as Record<string, unknown>);
    }

    static async set(user: SemurUser): Promise<void> {
        await this.firestoreCollection.doc(user.id).set({...user});
    }

    static async delete(userId: string): Promise<void> {
        await this.firestoreCollection.doc(userId).delete();
    }

    static async update(user: SemurUser): Promise<void> {
        await this.firestoreCollection.doc(user.id).update({...user});
    }

    static async updateCustomFields(userId: string, data: { [key: string]: unknown }): Promise<void> {
        await this.firestoreCollection.doc(userId).update(data);
    }

    static async query(queryKey: UserQueryKey, args: UserQueryArgs[UserQueryKey] = {}): Promise<SemurUser[]> {
        const query = await this.buildQuery(queryKey, args);
        const querySnapshot = await query.get();
        return querySnapshot.docs.map((doc) => SemurUser.fromJSON(doc.data() as Record<string, unknown>));
    }

    // Build query given query key and arguments
    static async buildQuery(queryKey: UserQueryKey, args: UserQueryArgs[UserQueryKey] = {}): Promise<FirebaseFirestore.Query> {
        if (!this.firestoreCollection) {
            throw SemurEngineErrorBuilder.internalError("Firebase collection is not defined");
        }
        switch (queryKey) {
            case UserQueryKey.All:
                return this.firestoreCollection;
            default:
                throw SemurEngineErrorBuilder.internalError(`Unknown query key: ${queryKey}`);
        }
    }


    // Nango
    static async nangoConnectionExists(userId: string, connectionId: string): Promise<boolean> {
        const snapshot = await this.firestoreCollection.doc(userId)
            .collection(this.firestoreNangoConnectionsSubcollectionName).doc(connectionId).get();
        return snapshot.exists;
    }

    static async nangoConnectionGet(userId: string, integrationId: string): Promise<NangoConnection> {
        const snapshot = await this.firestoreCollection.doc(userId)
            .collection(this.firestoreNangoConnectionsSubcollectionName).doc(integrationId).get();
        if (!snapshot.exists) {
            throw SemurEngineErrorBuilder.notFound("Nango connection not found");
        }
        return NangoConnection.fromJSON(snapshot.data() as Record<string, unknown>);
    }

    static async nangoConnectionSet(userId: string, connection: NangoConnection): Promise<void> {
        await this.firestoreNangoConnectionIdToUserIdMappingCollection.doc(connection.connectionId).set({
            connectionId: connection.connectionId,
            integrationId: connection.id,
            userId: userId,
        });
        await this.firestoreCollection.doc(userId)
            .collection(this.firestoreNangoConnectionsSubcollectionName).doc(connection.id).set({...connection});
    }

    static async nangoConnectionUpdate(userId: string, connection: NangoConnection): Promise<void> {
        await this.firestoreCollection.doc(userId)
            .collection(this.firestoreNangoConnectionsSubcollectionName).doc(connection.id).update({...connection});
    }

    static async nangoConnectionDelete(userId: string, connectionId: string): Promise<void> {
        await this.firestoreCollection.doc(userId)
            .collection(this.firestoreNangoConnectionsSubcollectionName).doc(connectionId).delete();
    }

    static async nangoConnectionQuery(
        queryKey: UserNangoConnectionQueryKey,
        args: UserNangoConnectionQueryArgs[UserNangoConnectionQueryKey],
    ): Promise<NangoConnection[]> {
        const query = await this.buildNangoConnectionQuery(queryKey, args);
        const querySnapshot = await query.get();
        return querySnapshot.docs.map((doc) => NangoConnection.fromJSON(doc.data() as Record<string, unknown>));
    }

    private static async buildNangoConnectionQuery(
        queryKey: UserNangoConnectionQueryKey,
        args: UserNangoConnectionQueryArgs[UserNangoConnectionQueryKey]): Promise<FirebaseFirestore.Query<FirebaseFirestore.DocumentData>> {
        switch (queryKey) {
            case UserNangoConnectionQueryKey.All:
                return this.firestoreCollection
                    .doc(args.userId) // Placeholder, adjust as needed
                    .collection(this.firestoreNangoConnectionsSubcollectionName);
            case UserNangoConnectionQueryKey.Active:
                return this.firestoreCollection
                    .doc(args.userId) // Placeholder, adjust as needed
                    .collection(this.firestoreNangoConnectionsSubcollectionName)
                    .where("status", "==", NangoConnectionStatus.NANGO_CONNECTION_ACTIVE.valueOf());
            default:
                throw SemurEngineErrorBuilder.internalError("Invalid Nango connection query key for users");
        }
    }

    // Nango Connection ID to User ID mapping
    static async nangoConnectionIdToUserIdMappingGet(connectionId: string): Promise<string> {
        const snapshot = await this.firestoreNangoConnectionIdToUserIdMappingCollection.doc(connectionId).get();
        if (!snapshot.exists) {
            throw SemurEngineErrorBuilder.notFound("Nango connection ID to User ID mapping not found");
        }
        const data = snapshot.data() as { connectionId: string; userId: string };
        return data.userId;
    }
}
