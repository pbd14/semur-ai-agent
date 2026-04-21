import {Genkit, z} from "genkit";
import {getNangoClient, triggerNangoSync} from "../../../modules_integrations/nango/nango";
import {SemurEngineAiToolSDK} from "../../../semur_engine/semur_engine_ai";
import {ChatSession} from "../../../models.pb/chats/chat";
import {AgentTool} from "../../../models.pb/agents/agent";
import {
    ZodGoogleMailEmail,
    ZodGoogleMailEmailsSearchSchema,
    ZodGoogleMailSendEmailSchema,
    ZodGoogleMailVectorSearchSchema,
} from "./google-mail_tools_types";
import {
    UserSyncGoogleMailAccessor,
    UserSyncGoogleMailQueryKey,
} from "../../../accessors/users/syncs/user_sync_google_mail_accessor";
import {firestore} from "firebase-admin";
import {defineFirestoreRetriever} from "@genkit-ai/firebase";
import {SemurEngineConfig} from "../../../config";
import {googleAI} from "@genkit-ai/googleai";
import {ZodSyncInformation} from "../../../modules_integrations/syncs/sync_types";
import {SyncHelper} from "../../../helpers/syncs/sync_helper";
import {
    SyncGoogleMailEmailsFromNangoToFirestoreRequest,
} from "../../../models.pb/semur-engine/syncs-engine/sync_engine_google-mail";
import {privateSyncGoogleMailEmailsFromNangoToFirestore} from "../../../modules_integrations/syncs/google-mail_sync";
import {SemurEngineEndpoint, SemurEngineErrorBuilder} from "../../../semur_engine/semur_engine";
import {NangoTriggerSyncRequest} from "../../../models.pb/semur-engine/nango-engine/nango_engine";
import {SyncMode} from "../../../models.pb/syncs/sync";
import Timestamp = firestore.Timestamp;
import {GeminiModelsConfig} from "../../agents/gemini_models_config";
import {logger} from "firebase-functions";
import {SyncFilter} from "../../../models.pb/semur-engine/syncs-engine/sync_engine";

export class GoogleMailTools {
    static initializeAllTools(
        ai: Genkit,
        nangoSecret: string,
        nangoIntegrationId: string,
        connectionId: string,
        session: ChatSession,
    ) {
        return [
            // WARN: For unknown reasons, this method is causing issues with the agent's ability to call tools.
            // GoogleMailTools.googleMailSearchEmailById(
            //     ai,
            //     nangoSecret,
            //     nangoIntegrationId,
            //     connectionId,
            //     session,
            // ).getTool(),
            GoogleMailTools.googleMailSearchCommonFilters(
                ai,
                nangoSecret,
                nangoIntegrationId,
                connectionId,
                session,
            ).getTool(),
            GoogleMailTools.googleMailVectorSearch(
                ai,
                nangoSecret,
                nangoIntegrationId,
                connectionId,
                session,
            ).getTool(),
            GoogleMailTools.googleMailGetSyncInformation(
                ai,
                nangoSecret,
                nangoIntegrationId,
                connectionId,
                session,
            ).getTool(),
            GoogleMailTools.googleMailSync(
                ai,
                nangoSecret,
                nangoIntegrationId,
                connectionId,
                session,
            ).getTool(),
            GoogleMailTools.googleMailSendEmail(
                ai,
                nangoSecret,
                connectionId,
                session,
            ).getTool(),
        ];
    }

    // WARN: For unknown reasons, this method is causing issues with the agent's ability to call tools.
    // TODO: Deprecate in favor of googleMailSearchCommonFilters with id filter
    static googleMailSearchEmailById(
        ai: Genkit,
        nangoSecret: string,
        nangoIntegrationId: string,
        connectionId: string,
        session: ChatSession,
    ) {
        return new SemurEngineAiToolSDK(
            ai,
            {
                name: "google_mail_search_email_by_id",
                description: "Retrieve a specific email by its unique ID.",
                inputSchema: z.string().describe("The unique identifier of the email to retrieve."),
                outputSchema: ZodGoogleMailEmail,
            },
            async (input) => {
                try {
                    const email = await UserSyncGoogleMailAccessor.get(
                        session.userId,
                        nangoIntegrationId,
                        input,
                    );
                    return {
                        id: email.id,
                        sender: email.sender,
                        recipients: email.recipients,
                        date: email.date?.toISOString() || (new Date()).toISOString(),
                        subject: email.subject,
                        body: email.body,
                        attachments: email.attachments,
                        threadId: email.threadId,
                    };
                } catch (error) {
                    logger.error("Error in googleMailGetEmailById tool:", error);
                    throw SemurEngineErrorBuilder.internalError("Failed to retrieve email by ID");
                }
            },
            session,
            AgentTool.GOOGLE_MAIL_GET_EMAIL_BY_ID,
            () => {
                return {
                    id: "",
                    sender: "",
                    recipients: "",
                    date: new Date().toISOString(),
                    subject: "",
                    body: "",
                    attachments: [],
                    threadId: "",
                };
            },
        );
    }

    static googleMailSearchCommonFilters(
        ai: Genkit,
        nangoSecret: string,
        nangoIntegrationId: string,
        connectionId: string,
        session: ChatSession,
    ) {
        return new SemurEngineAiToolSDK(
            ai,
            {
                name: "google_mail_search_common_filters",
                description: "Search for emails based on date range, and thread ID filters, ordered by date descending.",
                inputSchema: ZodGoogleMailEmailsSearchSchema,
                outputSchema: z.object({
                    emails: z.array(ZodGoogleMailEmail).describe("A list of email records matching the search criteria."),
                    totalCount: z.number(),
                }),
            },
            async (input) => {
                try {
                    // If id is provided, ignore other filters and get by ID
                    if (input.id) {
                        const email = await UserSyncGoogleMailAccessor.get(
                            session.userId,
                            nangoIntegrationId,
                            input.id,
                        );

                        return {
                            emails: [{
                                id: email.id,
                                sender: email.sender,
                                recipients: email.recipients,
                                date: email.date?.toISOString() || (new Date()).toISOString(),
                                subject: email.subject,
                                body: email.fullContent,
                                attachments: email.attachments,
                                threadId: email.threadId,
                            }],
                            totalCount: 1,
                        };
                    }

                    let fromTimestamp = undefined;
                    let toTimestamp = undefined;
                    if (input.dateFrom) {
                        fromTimestamp = Timestamp.fromDate(new Date(input.dateFrom));
                    }

                    if (input.dateTo) {
                        toTimestamp = Timestamp.fromDate(new Date(input.dateTo));
                    }

                    const syncGoogleMailEmails = await UserSyncGoogleMailAccessor.query(
                        UserSyncGoogleMailQueryKey.CommonFilters,
                        {
                            userId: session.userId,
                            nangoIntegrationId: nangoIntegrationId,
                            from: fromTimestamp,
                            to: toTimestamp,
                            threadId: input.threadId || undefined,
                            limit: input.limit ? input.limit : 50,
                        },
                    );

                    const emails = syncGoogleMailEmails.map((email) => ({
                        id: email.id,
                        sender: email.sender,
                        recipients: email.recipients,
                        date: email.date?.toISOString() || (new Date()).toISOString(),
                        subject: email.subject,
                        body: email.body,
                        attachments: email.attachments,
                        threadId: email.threadId,
                    }));

                    // Truncate email bodies to fit within token limits
                    const tokensPerEmail = GeminiModelsConfig.freeContextTokenLimit / (emails.length || 1);
                    for (const email of emails) {
                        const tokensOfEmailMetadata = JSON.stringify({
                            id: email.id,
                            sender: email.sender,
                            recipients: email.recipients,
                            date: email.date,
                            subject: email.subject,
                            attachments: email.attachments,
                            threadId: email.threadId,
                        }).length / 4;
                        email.body = GeminiModelsConfig.processTextWithTokenLimit(email.body, tokensPerEmail - tokensOfEmailMetadata);
                    }

                    return {
                        emails: emails,
                        totalCount: emails.length,
                    };
                } catch (error) {
                    logger.error("Error in googleMailSearchCommonFilters tool:", error);
                    throw SemurEngineErrorBuilder.internalError("Failed to search emails");
                }
            },
            session,
            AgentTool.GOOGLE_MAIL_SEARCH_COMMON_FILTERS,
            () => {
                return {
                    emails: [],
                    totalCount: 0,
                };
            },
        );
    }


    static googleMailVectorSearch(
        ai: Genkit,
        nangoSecret: string,
        nangoIntegrationId: string,
        connectionId: string,
        session: ChatSession,
    ) {
        return new SemurEngineAiToolSDK(
            ai,
            {
                name: "google_mail_vector_search",
                description: "Search for emails using semantic/vector search based on " +
                    "fuzzy/semantic lookups across sender, subject, and cleaned body",
                inputSchema: ZodGoogleMailVectorSearchSchema,
                outputSchema: z.object({
                    emails: z.array(ZodGoogleMailEmail).describe("A list of email records matching the search criteria."),
                    totalCount: z.number(),
                }),
            },
            async (input) => {
                const firestore = SemurEngineConfig.db;
                const retriever = defineFirestoreRetriever(ai, {
                    name: "googleMailVectorSearch",
                    firestore,
                    collection: `users/${session.userId}/nango_connections/${nangoIntegrationId}/syncs`,
                    contentField: "fullContent", // Field containing document content
                    vectorField: "embedding", // Field containing vector embeddings
                    embedder: googleAI.embedder("text-embedding-004", {outputDimensionality: 768}), // Embedder to generate embeddings
                    distanceMeasure: "COSINE", // Default is 'COSINE'; other options: 'EUCLIDEAN', 'DOT_PRODUCT'
                });
                const docs = await ai.retrieve({
                    retriever: retriever,
                    query: input.query,
                    options: {
                        limit: input.limit,
                    },
                });

                const emails = docs.map((doc) => {
                    const data = doc.metadata as Record<string, unknown>;
                    return {
                        id: data.id,
                        sender: data.sender,
                        recipients: data.recipients,
                        // TODO: Need to investigate why date is coming in this format, instead of Timestamp
                        date: new Date((data.date as {
                            _seconds: number,
                            _nanoseconds: number
                        })._seconds * 1000).toISOString(),
                        subject: data.subject,
                        body: data.body,
                        attachments: data.attachments,
                        threadId: data.threadId,
                    };
                });

                return {
                    emails: emails,
                    totalCount: emails.length,
                };
            },
            session,
            AgentTool.GOOGLE_MAIL_VECTOR_SEARCH,
            () => {
                return {
                    emails: [],
                    totalCount: 0,
                };
            },
        );
    }

    static googleMailGetSyncInformation(
        ai: Genkit,
        nangoSecret: string,
        nangoIntegrationId: string,
        connectionId: string,
        session: ChatSession,
    ) {
        return new SemurEngineAiToolSDK(
            ai,
            {
                name: "google_mail_get_sync_information",
                description: "Get information about the Google Mail sync status, including last sync time and sync status.",
                outputSchema: ZodSyncInformation,
            },
            async (input) => {
                const syncInformation = await UserSyncGoogleMailAccessor.getSyncInfo(
                    session.userId,
                    nangoIntegrationId,
                );
                return {
                    integrationId: syncInformation.nangoIntegrationId,
                    updatedAt: syncInformation.updatedAt ? syncInformation.updatedAt.toISOString() : new Date(0).toISOString(),
                    status: SyncHelper.convertSyncStatusToString(syncInformation.status),
                    errorMessage: syncInformation.errorMessage,
                };
            },
            session,
            AgentTool.GOOGLE_MAIL_GET_SYNC_INFORMATION,
            () => {
                return {
                    // TODO: Magic value
                    integrationId: nangoIntegrationId,
                    updatedAt: new Date().toISOString(),
                    errorMessage: "unknown error",
                };
            },
        );
    }

    static googleMailSync(
        ai: Genkit,
        nangoSecret: string,
        nangoIntegrationId: string,
        connectionId: string,
        session: ChatSession,
    ) {
        return new SemurEngineAiToolSDK(
            ai,
            {
                name: "google_mail_sync",
                description: "Trigger a sync for Google Mail. " +
                    "This will start the synchronization process to fetch the latest emails from the connected Gmail account. " +
                    "To check the status of the process use google_mail_get_sync_information tool",
                outputSchema: ZodSyncInformation.describe("Information about the sync status after running the sync."),
            },
            async (input) => {
                const syncGoogleMailEmailsRequest: SyncGoogleMailEmailsFromNangoToFirestoreRequest = {
                    userId: session.userId,
                    integrationId: nangoIntegrationId,
                    limit: 100,
                    filter: [
                        SyncFilter.ADDED,
                        SyncFilter.UPDATED,
                        SyncFilter.DELETED,
                    ],
                };

                await privateSyncGoogleMailEmailsFromNangoToFirestore(
                    syncGoogleMailEmailsRequest,
                    new SemurEngineEndpoint("google_mail_sync_tool"),
                );

                const nangoTriggerSyncRequest: NangoTriggerSyncRequest = {
                    providerConfigKey: nangoIntegrationId,
                    syncs: [],
                    connectionId: connectionId,
                    syncMode: SyncMode.INCREMENTAL,
                    userId: session.userId,
                };
                await triggerNangoSync(nangoTriggerSyncRequest);

                const syncInformation = await UserSyncGoogleMailAccessor.getSyncInfo(
                    session.userId,
                    nangoIntegrationId,
                );
                return {
                    integrationId: syncInformation.nangoIntegrationId,
                    updatedAt: syncInformation.updatedAt ? syncInformation.updatedAt.toISOString() : new Date(0).toISOString(),
                    status: SyncHelper.convertSyncStatusToString(syncInformation.status),
                    errorMessage: syncInformation.errorMessage,
                };
            },
            session,
            AgentTool.GOOGLE_MAIL_SYNC,
            () => {
                return {
                    // TODO: Magic value
                    integrationId: nangoIntegrationId,
                    updatedAt: new Date().toISOString(),
                    errorMessage: "error",
                };
            },
        );
    }

    static googleMailSendEmail(
        ai: Genkit,
        nangoSecret: string,
        connectionId: string,
        session: ChatSession,
    ) {
        return new SemurEngineAiToolSDK(
            ai,
            {
                name: "google_mail_send_email",
                description: "Sends an email using the connected Gmail account.",
                inputSchema: ZodGoogleMailSendEmailSchema,
                // {
                //     "id": "<string>",
                //     "threadId": "<string>"
                // }
                outputSchema: z.object({
                    id: z.string().describe("The unique identifier of the sent email."),
                    threadId: z.string().describe("The thread ID of the sent email."),
                    success: z.boolean().describe("Indicates whether the email was sent successfully."),
                }),
            },
            async (input) => {
                const nango = getNangoClient(nangoSecret);
                const response = await nango.triggerAction(
                    // TODO: Magic value
                    "google-mail",
                    connectionId,
                    "send-email",
                    {
                        to: input.to,
                        headers: input.headers,
                        subject: input.subject,
                        body: input.body,
                    },
                ) as { id?: string; threadId?: string };
                if (!response || !response.id || !response.threadId) {
                    throw SemurEngineErrorBuilder.internalError("Failed to send email via Nango action");
                }
                return {
                    id: response.id,
                    threadId: response.threadId,
                    success: true,
                };
            },
            session,
            AgentTool.GOOGLE_MAIL_SEND_EMAIL,
            () => {
                return {
                    id: "",
                    threadId: "",
                    success: false,
                };
            },
        );
    }


    // TODO: Deprecate this method in favor of syncing from Nango
    static googleMailGetEmails(
        ai: Genkit,
        nangoSecret: string,
        connectionId: string,
        session: ChatSession,
    ) {
        return new SemurEngineAiToolSDK(
            ai,
            {
                name: "google_mail_get_emails",
                description: "Fetches a list of emails from gmail. Use limit field in input to avoid input overflow. " +
                    "Goes back default to 1 year but metadata can be set " +
                    "using the `backfillPeriodMs` property to change the lookback. The property should be set in milliseconds.",
                inputSchema: z.object({
                    modifiedAfter: z.string().optional().describe("A string timestamp (e.g., 2023-05-31T11:46:13.390Z) " +
                        "used to fetch records modified after this date and time. If not provided, all records are returned. " +
                        "The modified_after parameter is less precise than cursor, " +
                        "as multiple records may share the same modification timestamp"),
                    limit: z.number().min(1).max(1000).default(100).optional().describe(
                        "The maximum number of records to return per page, from 1 - 1000. Defaults to 100."),
                    cursor: z.string().optional().describe("A marker used to fetch records modified after a specific point in time. " +
                        "If not provided, all records are returned. Each record includes a cursor value found in _nango_metadata.cursor. " +
                        "Save the cursor from the last record retrieved to track your sync progress. " +
                        "Use the cursor parameter together with the limit parameter to paginate through records. " +
                        "The cursor is more precise than modified_after, " +
                        "as it can differentiate between records with the same modification timestamp."),
                    filter: z.enum(["added", "updated", "deleted", "ADDED", "UPDATED", "DELETED"]).optional()
                        .describe("Filter to only show results that have been added, updated, or deleted."),
                }),
                outputSchema: z.object({
                    records: z.array(z.object({
                        id: z.string().describe("The unique identifier of the email."),
                        sender: z.string().describe("The email address of the sender."),
                        recipients: z.string().optional().describe("The email addresses of the recipients."),
                        date: z.string().describe("The date and time when the email was sent."),
                        subject: z.string().describe("The subject of the email."),
                        body: z.string().optional().describe("The body content of the email."),
                        attachments: z.array(z.object({
                            filename: z.string().describe("The name of the attachment file."),
                            mimeType: z.string().describe("The MIME type of the attachment."),
                            size: z.number().describe("The size of the attachment in bytes."),
                            attachmentId: z.string().describe("The unique identifier of the attachment."),
                        })).describe("A list of attachments associated with the email."),
                        threadId: z.string().describe("The identifier of the thread to which this email belongs."),
                        _nango_metadata: z.object({
                            deleted_at: z.string().nullable().describe("The date and time when the record was deleted, or null if not deleted."),
                            last_action: z.enum(["ADDED", "UPDATED", "DELETED"]).describe("The last action performed on the record."),
                            first_seen_at: z.string().describe("The date and time when the record was first seen."),
                            cursor: z.string().describe("A marker used for pagination and tracking sync progress."),
                            last_modified_at: z.string().describe("The date and time when the record was last modified."),
                        }).describe("Metadata about the record managed by Nango."),
                    })).describe("A list of email records fetched from Gmail."),
                }),
            },
            async (input) => {
                const nango = getNangoClient(nangoSecret);
                const rawRecords = await nango.listRecords({
                    providerConfigKey: "google-mail",
                    connectionId: connectionId,
                    model: "GmailEmail",
                    modifiedAfter: input.modifiedAfter,
                    limit: input.limit,
                    cursor: input.cursor,
                    filter: input.filter,
                });

                // Convert rawRecords to match the output schema

                // WARN: The any type is used here because the structure of rawRecords is not strictly defined.
                /* eslint-disable @typescript-eslint/no-explicit-any */
                const records = rawRecords.records.map((record: Record<string, any>) => ({
                    id: record.id,
                    sender: record.sender,
                    recipients: record.recipients,
                    date: record.date,
                    subject: record.subject,
                    body: record.body,
                    attachments: record.attachments,
                    threadId: record.threadId,
                    _nango_metadata: {
                        deleted_at: record._nango_metadata.deleted_at,
                        last_action: record._nango_metadata.last_action,
                        first_seen_at: record._nango_metadata.first_seen_at,
                        cursor: record._nango_metadata.cursor,
                        last_modified_at: record._nango_metadata.last_modified_at,
                    },
                }));

                return {
                    records: records,
                };
            },
            session,
            AgentTool.GOOGLE_MAIL_GET_EMAILS,
            () => {
                return {
                    records: [],
                };
            },
        );
    }
}
