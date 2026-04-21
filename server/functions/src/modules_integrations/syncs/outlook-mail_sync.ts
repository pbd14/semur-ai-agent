import {SemurEngineConfig} from "../../config";
import {Nango} from "@nangohq/node";
import {SemurEngineEndpoint, SemurEngineErrorBuilder} from "../../semur_engine/semur_engine";
import {SemurEngineErrorCode} from "../../models.pb/semur-engine/semur_engine";
import {SemurEngineEndpointsSecrets} from "../../semur_engine/semur_engine_types";
import {SyncHelper} from "../../helpers/syncs/sync_helper";
import {SyncInformation, SyncMode, SyncNangoMetadata, SyncStatus} from "../../models.pb/syncs/sync";
import {UserAccessor} from "../../accessors/users/user_accessor";
import {triggerNangoSync} from "../nango/nango";
import {NangoTriggerSyncRequest} from "../../models.pb/semur-engine/nango-engine/nango_engine";
import {convert} from "html-to-text";
import {logger} from "firebase-functions";
import {
    SyncOutlookMailEmailsFromNangoToFirestoreRequest, SyncOutlookMailEmailsFromNangoToFirestoreResponse,
    SyncOutlookMailEmailsRequest,
} from "../../models.pb/semur-engine/syncs-engine/sync_engine_outlook-mail";
import {UserSyncOutlookMailAccessor} from "../../accessors/users/syncs/user_sync_outlook_mail_accessor";
import {SyncOutlookEmail, SyncOutlookEmailAttachment} from "../../models.pb/syncs/sync_outlook";
import {IntegrationIds} from "../../runtime/integration_ids";
import {getNangoSecret} from "../../runtime/runtime_config";

const moduleName = SemurEngineConfig.isDev ? "sync_outlook_mail-dev" : "sync_outlook_mail";

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
        const syncOutlookMailEmailsRequest: SyncOutlookMailEmailsRequest = {
            userId: request.data.userId,
            integrationId: request.data.integrationId,
        };

        // Get connection id
        let nangoConnection;
        try {
            nangoConnection = await UserAccessor.nangoConnectionGet(
                syncOutlookMailEmailsRequest.userId,
                syncOutlookMailEmailsRequest.integrationId,
            );
        } catch (error) {
            throw SemurEngineErrorBuilder.notFound(`Nango connection not found for user ID ${syncOutlookMailEmailsRequest.userId} 
            and integration ID ${syncOutlookMailEmailsRequest.integrationId}`);
        }

        const nangoTriggerSyncRequest: NangoTriggerSyncRequest = {
            providerConfigKey: syncOutlookMailEmailsRequest.integrationId,
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
        const syncOutlookMailEmailsFromNangoToFirestoreRequest: SyncOutlookMailEmailsFromNangoToFirestoreRequest = {
            userId: request.data.userId,
            integrationId: request.data.integrationId,
            limit: request.data.limit || 100,
            filter: request.data.filter || undefined,
        };

        return await privateSyncOutlookMailEmailsFromNangoToFirestore(syncOutlookMailEmailsFromNangoToFirestoreRequest, endpoint);
    },
);

export const privateSyncOutlookMailEmailsFromNangoToFirestore = async (
    syncOutlookMailEmailsFromNangoToFirestoreRequest: SyncOutlookMailEmailsFromNangoToFirestoreRequest,
    endpoint: SemurEngineEndpoint,
    success: boolean = true,
    isEmptySync: boolean = false,
) => {
    logger.info(`${moduleName}-emailsFromNangoToFirestore:request`, {request: syncOutlookMailEmailsFromNangoToFirestoreRequest});
    if (!syncOutlookMailEmailsFromNangoToFirestoreRequest.userId) {
        throw SemurEngineErrorBuilder.badRequest("User ID is required");
    }

    if (!syncOutlookMailEmailsFromNangoToFirestoreRequest.integrationId ||
        syncOutlookMailEmailsFromNangoToFirestoreRequest.integrationId.length === 0) {
        throw SemurEngineErrorBuilder.badRequest("Integration ID is required");
    }

    // Get connection id
    logger.info(`Getting Nango connection for user ID ${syncOutlookMailEmailsFromNangoToFirestoreRequest.userId}`);
    let nangoConnection;
    try {
        nangoConnection = await UserAccessor.nangoConnectionGet(
            syncOutlookMailEmailsFromNangoToFirestoreRequest.userId,
            syncOutlookMailEmailsFromNangoToFirestoreRequest.integrationId,
        );
    } catch (error) {
        logger.error("Error getting Nango connection", error);
        throw SemurEngineErrorBuilder.notFound(`Nango connection not found for user ID ${syncOutlookMailEmailsFromNangoToFirestoreRequest.userId} 
            and integration ID ${syncOutlookMailEmailsFromNangoToFirestoreRequest.integrationId}`);
    }

    // Get the sync information
    let cursor: string | undefined;
    let modifiedAfter: Date | undefined;
    if (await UserSyncOutlookMailAccessor.existsSyncInfo(
        syncOutlookMailEmailsFromNangoToFirestoreRequest.userId,
        syncOutlookMailEmailsFromNangoToFirestoreRequest.integrationId,
    )) {
        logger.info("Sync info exists, getting sync info");
        const syncInfo = await UserSyncOutlookMailAccessor.getSyncInfo(
            syncOutlookMailEmailsFromNangoToFirestoreRequest.userId,
            syncOutlookMailEmailsFromNangoToFirestoreRequest.integrationId,
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
        await UserSyncOutlookMailAccessor.updateCustomFieldsSyncInfo(
            syncOutlookMailEmailsFromNangoToFirestoreRequest.userId,
            syncOutlookMailEmailsFromNangoToFirestoreRequest.integrationId,
            {
                updatedAt: new Date(),
                status: SyncStatus.IN_PROGRESS,
            },
        );
    } else {
        logger.info("Sync info does not exist, creating new sync info");
        // Set initial sync info
        if (isEmptySync) {
            await UserSyncOutlookMailAccessor.setSyncInfo(
                syncOutlookMailEmailsFromNangoToFirestoreRequest.userId,
                syncOutlookMailEmailsFromNangoToFirestoreRequest.integrationId,
                SyncInformation.create({
                    id: UserSyncOutlookMailAccessor.firestoreSyncDocumentId,
                    nangoIntegrationId: syncOutlookMailEmailsFromNangoToFirestoreRequest.integrationId,
                    updatedAt: new Date(),
                    status: SyncStatus.PENDING,
                }),
            );
            return SyncOutlookMailEmailsFromNangoToFirestoreResponse.create({
                error: SemurEngineErrorCode.NO_ERROR,
                message: "Empty sync is saved",
            });
        }
        await UserSyncOutlookMailAccessor.setSyncInfo(
            syncOutlookMailEmailsFromNangoToFirestoreRequest.userId,
            syncOutlookMailEmailsFromNangoToFirestoreRequest.integrationId,
            SyncInformation.create({
                id: UserSyncOutlookMailAccessor.firestoreSyncDocumentId,
                nangoIntegrationId: syncOutlookMailEmailsFromNangoToFirestoreRequest.integrationId,
                updatedAt: new Date(),
                status: SyncStatus.IN_PROGRESS,
            }),
        );
    }

    // If unsuccessful sync, update the sync status to failed and return
    if (!success) {
        await UserSyncOutlookMailAccessor.updateCustomFieldsSyncInfo(
            syncOutlookMailEmailsFromNangoToFirestoreRequest.userId,
            syncOutlookMailEmailsFromNangoToFirestoreRequest.integrationId,
            {
                status: SyncStatus.FAILED,
            },
        );
        return SyncOutlookMailEmailsFromNangoToFirestoreResponse.create({
            error: SemurEngineErrorCode.NO_ERROR,
            message: "Unsuccessful sync is saved",
        });
    }

    // Currently empty sync should still get the data from Nango to prevent inconsistency
    // // If empty sync
    // if (isEmptySync) {
    //     await UserSyncOutlookMailAccessor.updateCustomFieldsSyncInfo(
    //         syncOutlookMailEmailsFromNangoToFirestoreRequest.userId,
    //         syncOutlookMailEmailsFromNangoToFirestoreRequest.integrationId,
    //         {
    //             updatedAt: new Date(),
    //             status: SyncStatus.COMPLETED,
    //         },
    //     );
    //     return SyncOutlookMailEmailsFromNangoToFirestoreResponse.create({
    //         error: SemurEngineErrorCode.NO_ERROR,
    //         message: "Empty sync is saved",
    //     });
    // }

    try {
        const nango = getNangoClient();
        endpoint.logger.info("Fetching records from Nango", {
            request: {
                providerConfigKey: IntegrationIds.outlookMail,
                connectionId: nangoConnection.connectionId,
                model: "GmailEmail",
                modifiedAfter: modifiedAfter?.toISOString(), // e.g., 2023-05-31T11:46:13.390Z
                limit: syncOutlookMailEmailsFromNangoToFirestoreRequest.limit,
                cursor: cursor,
                filter: SyncHelper.convertSyncFiltersToFilterAction(syncOutlookMailEmailsFromNangoToFirestoreRequest.filter || []),
            },
        });
        const rawRecords = await nango.listRecords({
            providerConfigKey: IntegrationIds.outlookMail,
            connectionId: nangoConnection.connectionId,
            model: "OutlookEmail",
            modifiedAfter: modifiedAfter?.toISOString(), // e.g., 2023-05-31T11:46:13.390Z
            limit: syncOutlookMailEmailsFromNangoToFirestoreRequest.limit,
            cursor: cursor,
            filter: SyncHelper.convertSyncFiltersToFilterAction(syncOutlookMailEmailsFromNangoToFirestoreRequest.filter || []),
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
                const syncOutlookMailEmail = SyncOutlookEmail.create({
                    id: record.id.toString(),
                    sender: record.sender,
                    recipients: record.recipients,
                    date: new Date(record.date || Date.now()), // Convert from string, like "2025-09-15T05:41:14.000Z"
                    subject: record.subject,
                    body: record.body,
                    fullContent: record.sender + "\n" + record.subject + "\n" + cleanBody,
                    attachments: record.attachments ? record.attachments.map((attachment: Record<string, any>) =>
                        (SyncOutlookEmailAttachment.create({
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
                if ((!dateOfTheLatestEmail || (syncOutlookMailEmail.date || dateOfTheLatestEmail) > dateOfTheLatestEmail) &&
                    syncOutlookMailEmail.nangoMetadata?.cursor) {
                    dateOfTheLatestEmail = syncOutlookMailEmail.date;
                    cursorOfTheLatestEmail = syncOutlookMailEmail.nangoMetadata?.cursor;
                }

                // Save to Firestore
                await UserSyncOutlookMailAccessor.set(
                    syncOutlookMailEmailsFromNangoToFirestoreRequest.userId,
                    syncOutlookMailEmailsFromNangoToFirestoreRequest.integrationId,
                    syncOutlookMailEmail,
                );
            } catch (e) {
                isErrorLess = false;
                endpoint.logger.error(`${moduleName}-emails:error saving record`, e);
            }
        }
        endpoint.logger.info("Finished processing records from Nango");

        // Save the sync information
        await UserSyncOutlookMailAccessor.setSyncInfo(
            syncOutlookMailEmailsFromNangoToFirestoreRequest.userId,
            syncOutlookMailEmailsFromNangoToFirestoreRequest.integrationId,
            SyncInformation.create({
                id: UserSyncOutlookMailAccessor.firestoreSyncDocumentId,
                nangoIntegrationId: syncOutlookMailEmailsFromNangoToFirestoreRequest.integrationId,
                updatedAt: new Date(),
                // TODO: Maybe use cursoe from emails?
                nangoNextCursor: cursorOfTheLatestEmail || cursor || undefined,
                status: isErrorLess ? SyncStatus.COMPLETED : SyncStatus.PARTIALLY_COMPLETED,
            }),
        );

        return SyncOutlookMailEmailsFromNangoToFirestoreResponse.create({
            error: SemurEngineErrorCode.NO_ERROR,
            message: "Success",
        });
    } catch (error) {
        endpoint.logger.error(`${moduleName}-emails:error fetching records from Nango`, error);
        // Update the sync status to failed
        await UserSyncOutlookMailAccessor.updateCustomFieldsSyncInfo(
            syncOutlookMailEmailsFromNangoToFirestoreRequest.userId,
            syncOutlookMailEmailsFromNangoToFirestoreRequest.integrationId,
            {
                status: SyncStatus.FAILED,
            },
        );
        throw SemurEngineErrorBuilder.nangoError(`Failed to get user connections: ${error}`);
    }
};
