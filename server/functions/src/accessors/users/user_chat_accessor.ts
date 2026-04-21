import {SemurEngineConfig} from "../../config";
import {SemurEngineErrorBuilder} from "../../semur_engine/semur_engine";
import {ChatMessage, ChatSession} from "../../models.pb/chats/chat";
import {UserAccessor} from "./user_accessor";

export enum UserChatQueryKey {
    All = "all",
}

export enum UserChatMessageQueryKey {
    All = "all",
}

// User query arguments from query key
export interface UserChatQueryArgs {
    [UserChatQueryKey.All]: Record<string, never>;
}

export interface UserChatMessageQueryArgs {
    [UserChatMessageQueryKey.All]: {
        userId: string;
        chatId: string;
        limit?: number;
    };
}

export class UserChatAccessor {
    static firestoreCollectionName = "chats";
    static firestoreUsersCollection = SemurEngineConfig.db.collection(UserAccessor.firestoreCollectionName);
    static firestoreMessagesSubcollectionName = "messages";

    static async exists(userId: string, chatId: string): Promise<boolean> {
        const snapshot =
            await this.firestoreUsersCollection
                .doc(userId).collection(this.firestoreCollectionName)
                .doc(chatId).get();
        return snapshot.exists;
    }

    static async get(userId: string, chatId: string): Promise<ChatSession> {
        const snapshot = await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreCollectionName)
            .doc(chatId).get();
        if (!snapshot.exists) {
            throw SemurEngineErrorBuilder.notFound("Chat session not found");
        }
        return ChatSession.fromJSON(snapshot.data() as Record<string, unknown>);
    }

    static async set(userId: string, chat: ChatSession): Promise<void> {
        await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreCollectionName)
            .doc(chat.id).set({...chat});
    }

    static async delete(userId: string, chatId: string): Promise<void> {
        await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreCollectionName)
            .doc(chatId).delete();
    }

    static async update(userId: string, chat: ChatSession): Promise<void> {
        await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreCollectionName)
            .doc(chat.id).update({...chat});
    }

    static async updateCustomFields(userId: string, chatId: string, data: { [key: string]: unknown }): Promise<void> {
        await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreCollectionName)
            .doc(chatId).update(data);
    }

    static async query(queryKey: UserChatQueryKey, args: UserChatQueryArgs[UserChatQueryKey] = {}): Promise<ChatSession[]> {
        const query = await this.buildQuery(queryKey, args);
        const querySnapshot = await query.get();
        return querySnapshot.docs.map((doc) => ChatSession.fromJSON(doc.data() as Record<string, unknown>));
    }

    // Build query given query key and arguments
    static async buildQuery(queryKey: UserChatQueryKey, args: UserChatQueryArgs[UserChatQueryKey] = {}): Promise<FirebaseFirestore.Query> {
        if (!this.firestoreUsersCollection) {
            throw SemurEngineErrorBuilder.internalError("Firebase users collection is not defined");
        }
        switch (queryKey) {
            case UserChatQueryKey.All:
                return this.firestoreUsersCollection
                    .doc(args.userId).collection(this.firestoreCollectionName);
            default:
                throw SemurEngineErrorBuilder.internalError(`Unknown query key: ${queryKey}`);
        }
    }

    // Messages
    static async messageExists(userId: string, chatId: string, messageId: string): Promise<boolean> {
        const snapshot = await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreCollectionName)
            .doc(chatId).collection(this.firestoreMessagesSubcollectionName)
            .doc(messageId).get();
        return snapshot.exists;
    }

    static async messageGet(userId: string, chatId: string, messageId: string): Promise<ChatSession> {
        const snapshot = await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreCollectionName)
            .doc(chatId).collection(this.firestoreMessagesSubcollectionName)
            .doc(messageId).get();
        if (!snapshot.exists) {
            throw SemurEngineErrorBuilder.notFound("Chat message not found");
        }
        return ChatSession.fromJSON(snapshot.data() as Record<string, unknown>);
    }

    static async messageSet(userId: string, chatId: string, message: ChatMessage): Promise<void> {
        await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreCollectionName)
            .doc(chatId).collection(this.firestoreMessagesSubcollectionName)
            .doc(message.id.toString()).set({...message});
    }

    static async messageUpdate(userId: string, chatId: string, message: ChatMessage): Promise<void> {
        await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreCollectionName)
            .doc(chatId).collection(this.firestoreMessagesSubcollectionName)
            .doc(message.id.toString()).update({...message});
    }

    static async messageDelete(userId: string, chatId: string, messageId: string): Promise<void> {
        await this.firestoreUsersCollection
            .doc(userId).collection(this.firestoreCollectionName)
            .doc(chatId).collection(this.firestoreMessagesSubcollectionName)
            .doc(messageId).delete();
    }

    static async messageQuery(
        queryKey: UserChatMessageQueryKey,
        args: UserChatMessageQueryArgs[UserChatMessageQueryKey],
    ): Promise<ChatMessage[]> {
        const query = await this.buildMessageQuery(queryKey, args);
        const querySnapshot = await query.get();
        return querySnapshot.docs.map((doc) => ChatMessage.fromJSON(doc.data() as Record<string, unknown>));
    }

    private static async buildMessageQuery(
        queryKey: UserChatMessageQueryKey,
        args: UserChatMessageQueryArgs[UserChatMessageQueryKey]): Promise<FirebaseFirestore.Query<FirebaseFirestore.DocumentData>> {
        switch (queryKey) {
            case UserChatMessageQueryKey.All: {
                const baseQuery = this.firestoreUsersCollection
                    .doc(args.userId)
                    .collection(this.firestoreCollectionName)
                    .doc(args.chatId)
                    .collection(this.firestoreMessagesSubcollectionName)
                    .orderBy("createdAt", "desc");
                if (args.limit) {
                    return baseQuery.limit(args.limit);
                }
                return baseQuery.orderBy("id", "asc");
            }
            default:
                throw SemurEngineErrorBuilder.internalError("Invalid chat message query key for users");
        }
    }
}
