import {SemurEngineConfig} from "../../config";
import {Nango} from "@nangohq/node";
import {SemurEngineEndpoint, SemurEngineErrorBuilder} from "../../semur_engine/semur_engine";
import {SemurEngineErrorCode} from "../../models.pb/semur-engine/semur_engine";
import {SemurEngineEndpointsSecrets} from "../../semur_engine/semur_engine_types";
import {
    SyncGoogleMailEmailsFromNangoToFirestoreRequest,
    SyncGoogleMailEmailsFromNangoToFirestoreResponse,
    SyncGoogleMailEmailsRequest,
} from "../../models.pb/semur-engine/syncs-engine/sync_engine_google-mail";
import {SyncHelper} from "../../helpers/syncs/sync_helper";
import {
    SyncGoogleMailEmail,
    SyncGoogleMailEmailAttachment,
} from "../../models.pb/syncs/sync_google-mail";
import {UserSyncGoogleMailAccessor} from "../../accessors/users/syncs/user_sync_google_mail_accessor";
import {SyncInformation, SyncMode, SyncNangoMetadata, SyncStatus} from "../../models.pb/syncs/sync";
import {UserAccessor} from "../../accessors/users/user_accessor";
import {triggerNangoSync} from "../nango/nango";
import {NangoTriggerSyncRequest} from "../../models.pb/semur-engine/nango-engine/nango_engine";
import {convert} from "html-to-text";
import {logger} from "firebase-functions";
import {IntegrationIds} from "../../runtime/integration_ids";
import {getNangoSecret} from "../../runtime/runtime_config";

const moduleName = SemurEngineConfig.isDev ? "sync_google_mail-dev" : "sync_google_mail";

// Lazy initialization function for Nango client
export const getNangoClient = (nangoSecret: string = getNangoSecret()) => {
    return new Nango({secretKey: nangoSecret});
};

export const emails = new SemurEngineEndpoint(`${moduleName}-emails`).onCall(
    // TODO: Enable App Check later
    {
        enforceAppCheck: false,
        secrets: SemurEngineEndpointsSecrets[`${moduleName}-emails`],
        timeoutSeconds: 1200, // 20 minutes
    },
    async (request, endpoint) => {
        if (!request.auth || !request.auth.uid) {
            throw SemurEngineErrorBuilder.unauthorized("You are not authenticated");
        }
        const syncGoogleMailEmailsRequest: SyncGoogleMailEmailsRequest = {
            userId: request.data.userId,
            integrationId: request.data.integrationId,
        };

        // Get connection id
        let nangoConnection;
        try {
            nangoConnection = await UserAccessor.nangoConnectionGet(
                syncGoogleMailEmailsRequest.userId,
                syncGoogleMailEmailsRequest.integrationId,
            );
        } catch (error) {
            throw SemurEngineErrorBuilder.notFound(`Nango connection not found for user ID ${syncGoogleMailEmailsRequest.userId} 
            and integration ID ${syncGoogleMailEmailsRequest.integrationId}`);
        }

        const nangoTriggerSyncRequest: NangoTriggerSyncRequest = {
            providerConfigKey: syncGoogleMailEmailsRequest.integrationId,
            syncs: [],
            connectionId: nangoConnection.connectionId,
            syncMode: SyncMode.INCREMENTAL,
            userId: nangoConnection.userId,
        };

        return await triggerNangoSync(nangoTriggerSyncRequest, endpoint);
    },
);

export const emailsFromNangoToFirestore = new SemurEngineEndpoint(`${moduleName}-emailsFromNangoToFirestore`).onCall(
    // TODO: Enable App Check later
    {
        enforceAppCheck: false,
        secrets: SemurEngineEndpointsSecrets[`${moduleName}-emailsFromNangoToFirestore`],
        timeoutSeconds: 1200, // 20 minutes
    },
    async (request, endpoint) => {
        if (!request.auth || !request.auth.uid) {
            throw SemurEngineErrorBuilder.unauthorized("You are not authenticated");
        }
        const syncGoogleMailEmailsRequest: SyncGoogleMailEmailsFromNangoToFirestoreRequest = {
            userId: request.data.userId,
            integrationId: request.data.integrationId,
            limit: request.data.limit || 100,
            filter: request.data.filter || undefined,
        };

        return await privateSyncGoogleMailEmailsFromNangoToFirestore(syncGoogleMailEmailsRequest, endpoint);
    },
);

export const privateSyncGoogleMailEmailsFromNangoToFirestore = async (
    syncGoogleMailEmailsRequest: SyncGoogleMailEmailsFromNangoToFirestoreRequest,
    endpoint: SemurEngineEndpoint,
    success: boolean = true,
    isEmptySync: boolean = false,
) => {
    logger.info(`${moduleName}-emailsFromNangoToFirestore:request`, {request: syncGoogleMailEmailsRequest});
    if (!syncGoogleMailEmailsRequest.userId) {
        throw SemurEngineErrorBuilder.badRequest("User ID is required");
    }

    if (!syncGoogleMailEmailsRequest.integrationId || syncGoogleMailEmailsRequest.integrationId.length === 0) {
        throw SemurEngineErrorBuilder.badRequest("Integration ID is required");
    }

    // Get connection id
    logger.info(`Getting Nango connection for user ID ${syncGoogleMailEmailsRequest.userId}`);
    let nangoConnection;
    try {
        nangoConnection = await UserAccessor.nangoConnectionGet(
            syncGoogleMailEmailsRequest.userId,
            syncGoogleMailEmailsRequest.integrationId,
        );
    } catch (error) {
        logger.error("Error getting Nango connection", error);
        throw SemurEngineErrorBuilder.notFound(`Nango connection not found for user ID ${syncGoogleMailEmailsRequest.userId} 
            and integration ID ${syncGoogleMailEmailsRequest.integrationId}`);
    }

    // Get the sync information
    let cursor: string | undefined;
    let modifiedAfter: Date | undefined;
    if (await UserSyncGoogleMailAccessor.existsSyncInfo(
        syncGoogleMailEmailsRequest.userId,
        syncGoogleMailEmailsRequest.integrationId,
    )) {
        logger.info("Sync info exists, getting sync info");
        const syncInfo = await UserSyncGoogleMailAccessor.getSyncInfo(
            syncGoogleMailEmailsRequest.userId,
            syncGoogleMailEmailsRequest.integrationId,
        );
        if (syncInfo.status === SyncStatus.IN_PROGRESS &&
            (syncInfo.updatedAt && syncInfo.updatedAt >= new Date(Date.now() - 5 * 60 * 1000))) {
            // TODO: Add proper error code for this scenario, and update the backend
            // TODO: Instead of throwing an error, return a response with a specific error code
            throw SemurEngineErrorBuilder.conflict("A sync is already in progress. Please try again later.");
        }
        // If the last sync was completed, use its nangoNextCursor as cursor
        cursor = syncInfo.nangoNextCursor;
        // If cursor is given, use the updatedAt as modifiedAfter filter
        if (cursor) {
            modifiedAfter = syncInfo.updatedAt;
        }

        // Set sync info to in progress
        await UserSyncGoogleMailAccessor.updateCustomFieldsSyncInfo(
            syncGoogleMailEmailsRequest.userId,
            syncGoogleMailEmailsRequest.integrationId,
            {
                updatedAt: new Date(),
                status: SyncStatus.IN_PROGRESS,
            },
        );
    } else {
        logger.info("Sync info does not exist, creating new sync info");
        // Set initial sync info
        if (isEmptySync) {
            await UserSyncGoogleMailAccessor.setSyncInfo(
                syncGoogleMailEmailsRequest.userId,
                syncGoogleMailEmailsRequest.integrationId,
                SyncInformation.create({
                    id: UserSyncGoogleMailAccessor.firestoreSyncDocumentId,
                    nangoIntegrationId: syncGoogleMailEmailsRequest.integrationId,
                    updatedAt: new Date(),
                    status: SyncStatus.PENDING,
                }),
            );
            return SyncGoogleMailEmailsFromNangoToFirestoreResponse.create({
                error: SemurEngineErrorCode.NO_ERROR,
                message: "Empty sync is saved",
            });
        }
        await UserSyncGoogleMailAccessor.setSyncInfo(
            syncGoogleMailEmailsRequest.userId,
            syncGoogleMailEmailsRequest.integrationId,
            SyncInformation.create({
                id: UserSyncGoogleMailAccessor.firestoreSyncDocumentId,
                nangoIntegrationId: syncGoogleMailEmailsRequest.integrationId,
                updatedAt: new Date(),
                status: SyncStatus.IN_PROGRESS,
            }),
        );
    }

    // If unsuccessful sync, update the sync status to failed and return
    if (!success) {
        await UserSyncGoogleMailAccessor.updateCustomFieldsSyncInfo(
            syncGoogleMailEmailsRequest.userId,
            syncGoogleMailEmailsRequest.integrationId,
            {
                status: SyncStatus.FAILED,
            },
        );
        return SyncGoogleMailEmailsFromNangoToFirestoreResponse.create({
            error: SemurEngineErrorCode.NO_ERROR,
            message: "Unsuccessful sync is saved",
        });
    }

    // Currently empty sync should still get the data from Nango to prevent inconsistency
    // // If empty sync
    // if (isEmptySync) {
    //     await UserSyncGoogleMailAccessor.updateCustomFieldsSyncInfo(
    //         syncGoogleMailEmailsRequest.userId,
    //         syncGoogleMailEmailsRequest.integrationId,
    //         {
    //             updatedAt: new Date(),
    //             status: SyncStatus.COMPLETED,
    //         },
    //     );
    //     return SyncGoogleMailEmailsFromNangoToFirestoreResponse.create({
    //         error: SemurEngineErrorCode.NO_ERROR,
    //         message: "Empty sync is saved",
    //     });
    // }

    try {
        const nango = getNangoClient();
        endpoint.logger.info("Fetching records from Nango", {
            request: {
                providerConfigKey: IntegrationIds.googleMail,
                connectionId: nangoConnection.connectionId,
                model: "GmailEmail",
                modifiedAfter: modifiedAfter?.toISOString(), // e.g., 2023-05-31T11:46:13.390Z
                limit: syncGoogleMailEmailsRequest.limit,
                cursor: cursor,
                filter: SyncHelper.convertSyncFiltersToFilterAction(syncGoogleMailEmailsRequest.filter || []),
            },
        });
        const rawRecords = await nango.listRecords({
            providerConfigKey: IntegrationIds.googleMail,
            connectionId: nangoConnection.connectionId,
            model: "GmailEmail",
            modifiedAfter: modifiedAfter?.toISOString(), // e.g., 2023-05-31T11:46:13.390Z
            limit: syncGoogleMailEmailsRequest.limit,
            cursor: cursor,
            filter: SyncHelper.convertSyncFiltersToFilterAction(syncGoogleMailEmailsRequest.filter || []),
        });
        endpoint.logger.info(`Response records from Nango: ${rawRecords.records.length}`);
        let isErrorLess = true;

        let cursorOfTheLatestEmail: string | undefined = undefined;
        let dateOfTheLatestEmail: Date | undefined = undefined;

        // WARN: The any type is used here because the structure of rawRecords is not strictly defined.
        /* eslint-disable @typescript-eslint/no-explicit-any */
        for (const record of rawRecords.records) {
            try {
                // In your function:
                const cleanBody = convert(record.body, {
                    wordwrap: false,
                    selectors: [
                        {selector: "a", options: {ignoreHref: true}}, // Remove links
                        {selector: "img", format: "skip"}, // Skip images
                    ],
                });
                const syncGoogleMailEmail = SyncGoogleMailEmail.create({
                    id: record.id.toString(),
                    sender: record.sender,
                    recipients: record.recipients,
                    date: new Date(record.date || Date.now()), // Convert from string, like "2025-09-15T05:41:14.000Z"
                    subject: record.subject,
                    body: record.body,
                    fullContent: record.sender + "\n" + record.subject + "\n" + cleanBody,
                    attachments: record.attachments ? record.attachments.map((attachment: Record<string, any>) =>
                        (SyncGoogleMailEmailAttachment.create({
                            filename: attachment.filename,
                            mimeType: attachment.mimeType,
                            size: attachment.size,
                            attachmentId: attachment.attachmentId,
                        }))) : [],
                    threadId: record.threadId,
                    nangoMetadata: SyncNangoMetadata.create({
                        deletedAt: record._nango_metadata.deleted_at ? new Date(record._nango_metadata.deleted_at) : undefined,
                        lastAction: record._nango_metadata.last_action,
                        firstSeenAt: new Date(record._nango_metadata.first_seen_at),
                        cursor: record._nango_metadata.cursor,
                        lastModifiedAt: new Date(record._nango_metadata.last_modified_at),
                    }),
                });

                // Update cursor and date of the latest email by comparing dates
                if ((!dateOfTheLatestEmail || (syncGoogleMailEmail.date || dateOfTheLatestEmail) > dateOfTheLatestEmail) &&
                    syncGoogleMailEmail.nangoMetadata?.cursor) {
                    dateOfTheLatestEmail = syncGoogleMailEmail.date;
                    cursorOfTheLatestEmail = syncGoogleMailEmail.nangoMetadata?.cursor;
                }

                // Save to Firestore
                await UserSyncGoogleMailAccessor.set(
                    syncGoogleMailEmailsRequest.userId,
                    syncGoogleMailEmailsRequest.integrationId,
                    syncGoogleMailEmail,
                );
            } catch (e) {
                isErrorLess = false;
                endpoint.logger.error(`${moduleName}-emails:error saving record`, e);
            }
        }
        endpoint.logger.info("Finished processing records from Nango");

        // Save the sync information
        await UserSyncGoogleMailAccessor.setSyncInfo(
            syncGoogleMailEmailsRequest.userId,
            syncGoogleMailEmailsRequest.integrationId,
            SyncInformation.create({
                id: UserSyncGoogleMailAccessor.firestoreSyncDocumentId,
                nangoIntegrationId: syncGoogleMailEmailsRequest.integrationId,
                updatedAt: new Date(),
                // TODO: Maybe use cursoe from emails?
                nangoNextCursor: cursorOfTheLatestEmail || cursor || undefined,
                status: isErrorLess ? SyncStatus.COMPLETED : SyncStatus.PARTIALLY_COMPLETED,
            }),
        );

        return SyncGoogleMailEmailsFromNangoToFirestoreResponse.create({
            error: SemurEngineErrorCode.NO_ERROR,
            message: "Success",
        });
    } catch (error) {
        endpoint.logger.error(`${moduleName}-emails:error fetching records from Nango`, error);
        // Update the sync status to failed
        await UserSyncGoogleMailAccessor.updateCustomFieldsSyncInfo(
            syncGoogleMailEmailsRequest.userId,
            syncGoogleMailEmailsRequest.integrationId,
            {
                status: SyncStatus.FAILED,
            },
        );
        throw SemurEngineErrorBuilder.nangoError(`Failed to get user connections: ${error}`);
    }
};
