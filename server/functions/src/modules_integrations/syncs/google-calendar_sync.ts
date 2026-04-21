import {SemurEngineConfig} from "../../config";
import {Nango} from "@nangohq/node";
import {SemurEngineEndpoint, SemurEngineErrorBuilder} from "../../semur_engine/semur_engine";
import {SemurEngineErrorCode} from "../../models.pb/semur-engine/semur_engine";
import {SemurEngineEndpointsSecrets} from "../../semur_engine/semur_engine_types";
import {SyncInformation, SyncMode, SyncNangoMetadata, SyncStatus} from "../../models.pb/syncs/sync";
import {UserAccessor} from "../../accessors/users/user_accessor";
import {triggerNangoSync} from "../nango/nango";
import {NangoTriggerSyncRequest} from "../../models.pb/semur-engine/nango-engine/nango_engine";
import {
    SyncGoogleCalendarEventsFromNangoToFirestoreRequest, SyncGoogleCalendarEventsFromNangoToFirestoreResponse,
    SyncGoogleCalendarEventsRequest,
} from "../../models.pb/semur-engine/syncs-engine/sync_engine_google-calendar";
import {UserSyncGoogleCalendarAccessor} from "../../accessors/users/syncs/user_sync_google_calendar_accessor";
import {SyncHelper} from "../../helpers/syncs/sync_helper";
import {
    SyncGoogleCalendarEvent, SyncGoogleCalendarEventAttendee,
    SyncGoogleCalendarEventCreator,
    SyncGoogleCalendarEventOrganizer,
} from "../../models.pb/syncs/sync_google-calendar";
import {IntegrationIds} from "../../runtime/integration_ids";
import {getNangoSecret} from "../../runtime/runtime_config";

const moduleName = SemurEngineConfig.isDev ? "sync_google_calendar-dev" : "sync_google_calendar";

// Lazy initialization function for Nango client
export const getNangoClient = (nangoSecret: string = getNangoSecret()) => {
    return new Nango({secretKey: nangoSecret});
};

export const events = new SemurEngineEndpoint(`${moduleName}-events`).onCall(
    // TODO: Enable App Check later
    {
        enforceAppCheck: false,
        secrets: SemurEngineEndpointsSecrets[`${moduleName}-events`],
        timeoutSeconds: 1200, // 20 minutes
    },
    async (request, endpoint) => {
        if (!request.auth || !request.auth.uid) {
            throw SemurEngineErrorBuilder.unauthorized("You are not authenticated");
        }
        const syncGoogleCalendarEventsRequest: SyncGoogleCalendarEventsRequest = {
            userId: request.data.userId,
            integrationId: request.data.integrationId,
        };

        // Get connection id
        let nangoConnection;
        try {
            nangoConnection = await UserAccessor.nangoConnectionGet(
                syncGoogleCalendarEventsRequest.userId,
                syncGoogleCalendarEventsRequest.integrationId,
            );
        } catch (error) {
            throw SemurEngineErrorBuilder.notFound(`Nango connection not found for user ID ${syncGoogleCalendarEventsRequest.userId} 
            and integration ID ${syncGoogleCalendarEventsRequest.integrationId}`);
        }

        const nangoTriggerSyncRequest: NangoTriggerSyncRequest = {
            providerConfigKey: syncGoogleCalendarEventsRequest.integrationId,
            syncs: [],
            connectionId: nangoConnection.connectionId,
            syncMode: SyncMode.INCREMENTAL,
            userId: nangoConnection.userId,
        };

        return await triggerNangoSync(nangoTriggerSyncRequest, endpoint);
    },
);

export const eventsFromNangoToFirestore = new SemurEngineEndpoint(`${moduleName}-eventsFromNangoToFirestore`).onCall(
    // TODO: Enable App Check later
    {
        enforceAppCheck: false,
        secrets: SemurEngineEndpointsSecrets[`${moduleName}-eventsFromNangoToFirestore`],
        timeoutSeconds: 1200, // 20 minutes
    },
    async (request, endpoint) => {
        if (!request.auth || !request.auth.uid) {
            throw SemurEngineErrorBuilder.unauthorized("You are not authenticated");
        }
        const syncGoogleCalendarEventsFromNangoToFirestoreRequest: SyncGoogleCalendarEventsFromNangoToFirestoreRequest = {
            userId: request.data.userId,
            integrationId: request.data.integrationId,
            limit: request.data.limit || 100,
            filter: request.data.filter || undefined,
        };

        return await privateSyncGoogleCalendarEventsFromNangoToFirestore(syncGoogleCalendarEventsFromNangoToFirestoreRequest, endpoint);
    },
);

export const privateSyncGoogleCalendarEventsFromNangoToFirestore = async (
    syncGoogleCalendarEventsFromNangoToFirestoreRequest: SyncGoogleCalendarEventsFromNangoToFirestoreRequest,
    endpoint: SemurEngineEndpoint,
    success: boolean = true,
    isEmptySync: boolean = false,
) => {
    if (!syncGoogleCalendarEventsFromNangoToFirestoreRequest.userId) {
        throw SemurEngineErrorBuilder.badRequest("User ID is required");
    }

    if (!syncGoogleCalendarEventsFromNangoToFirestoreRequest.integrationId ||
        syncGoogleCalendarEventsFromNangoToFirestoreRequest.integrationId.length === 0) {
        throw SemurEngineErrorBuilder.badRequest("Integration ID is required");
    }

    // Get connection id
    let nangoConnection;
    try {
        nangoConnection = await UserAccessor.nangoConnectionGet(
            syncGoogleCalendarEventsFromNangoToFirestoreRequest.userId,
            syncGoogleCalendarEventsFromNangoToFirestoreRequest.integrationId,
        );
    } catch (error) {
        throw SemurEngineErrorBuilder.notFound(`Nango connection not found for user ID ${syncGoogleCalendarEventsFromNangoToFirestoreRequest.userId} 
            and integration ID ${syncGoogleCalendarEventsFromNangoToFirestoreRequest.integrationId}`);
    }

    // Get the sync information
    let cursor: string | undefined;
    let modifiedAfter: Date | undefined;
    if (await UserSyncGoogleCalendarAccessor.existsSyncInfo(
        syncGoogleCalendarEventsFromNangoToFirestoreRequest.userId,
        syncGoogleCalendarEventsFromNangoToFirestoreRequest.integrationId,
    )) {
        const syncInfo = await UserSyncGoogleCalendarAccessor.getSyncInfo(
            syncGoogleCalendarEventsFromNangoToFirestoreRequest.userId,
            syncGoogleCalendarEventsFromNangoToFirestoreRequest.integrationId,
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
        await UserSyncGoogleCalendarAccessor.updateCustomFieldsSyncInfo(
            syncGoogleCalendarEventsFromNangoToFirestoreRequest.userId,
            syncGoogleCalendarEventsFromNangoToFirestoreRequest.integrationId,
            {
                updatedAt: new Date(),
                status: SyncStatus.IN_PROGRESS,
            },
        );
    } else {
        // Set initial sync info
        if (isEmptySync) {
            await UserSyncGoogleCalendarAccessor.setSyncInfo(
                syncGoogleCalendarEventsFromNangoToFirestoreRequest.userId,
                syncGoogleCalendarEventsFromNangoToFirestoreRequest.integrationId,
                SyncInformation.create({
                    id: UserSyncGoogleCalendarAccessor.firestoreSyncDocumentId,
                    nangoIntegrationId: syncGoogleCalendarEventsFromNangoToFirestoreRequest.integrationId,
                    updatedAt: new Date(),
                    status: SyncStatus.PENDING,
                }),
            );
            return SyncGoogleCalendarEventsFromNangoToFirestoreResponse.create({
                error: SemurEngineErrorCode.NO_ERROR,
                message: "Empty sync is saved",
            });
        }
        await UserSyncGoogleCalendarAccessor.setSyncInfo(
            syncGoogleCalendarEventsFromNangoToFirestoreRequest.userId,
            syncGoogleCalendarEventsFromNangoToFirestoreRequest.integrationId,
            SyncInformation.create({
                id: UserSyncGoogleCalendarAccessor.firestoreSyncDocumentId,
                nangoIntegrationId: syncGoogleCalendarEventsFromNangoToFirestoreRequest.integrationId,
                updatedAt: new Date(),
                status: SyncStatus.IN_PROGRESS,
            }),
        );
    }

    // If unsuccessful sync, update the sync status to failed and return
    if (!success) {
        await UserSyncGoogleCalendarAccessor.updateCustomFieldsSyncInfo(
            syncGoogleCalendarEventsFromNangoToFirestoreRequest.userId,
            syncGoogleCalendarEventsFromNangoToFirestoreRequest.integrationId,
            {
                status: SyncStatus.FAILED,
            },
        );
        return SyncGoogleCalendarEventsFromNangoToFirestoreResponse.create({
            error: SemurEngineErrorCode.NO_ERROR,
            message: "Unsuccessful sync is saved",
        });
    }

    // Currently empty sync should still get the data from Nango to prevent inconsistency
    // // If empty sync
    // if (isEmptySync) {
    //     await UserSyncGoogleCalendarAccessor.updateCustomFieldsSyncInfo(
    //         syncGoogleCalendarEventsRequest.userId,
    //         syncGoogleCalendarEventsRequest.integrationId,
    //         {
    //             updatedAt: new Date(),
    //             status: SyncStatus.COMPLETED,
    //         },
    //     );
    //     return SyncGoogleCalendarEventsFromNangoToFirestoreResponse.create({
    //         error: SemurEngineErrorCode.NO_ERROR,
    //         message: "Empty sync is saved",
    //     });
    // }

    try {
        const nango = getNangoClient();
        endpoint.logger.info("Fetching records from Nango", {
            request: {
                providerConfigKey: IntegrationIds.googleCalendar,
                connectionId: nangoConnection.connectionId,
                model: "GoogleCalendarEvent",
                modifiedAfter: modifiedAfter?.toISOString(), // e.g., 2023-05-31T11:46:13.390Z
                limit: syncGoogleCalendarEventsFromNangoToFirestoreRequest.limit,
                cursor: cursor,
                filter: SyncHelper.convertSyncFiltersToFilterAction(syncGoogleCalendarEventsFromNangoToFirestoreRequest.filter || []),
            },
        });
        const rawRecords = await nango.listRecords({
            providerConfigKey: IntegrationIds.googleCalendar,
            connectionId: nangoConnection.connectionId,
            model: "GoogleCalendarEvent",
            modifiedAfter: modifiedAfter?.toISOString(), // e.g., 2023-05-31T11:46:13.390Z
            limit: syncGoogleCalendarEventsFromNangoToFirestoreRequest.limit,
            cursor: cursor,
            filter: SyncHelper.convertSyncFiltersToFilterAction(syncGoogleCalendarEventsFromNangoToFirestoreRequest.filter || []),
        });
        endpoint.logger.info(`Response records from Nango: ${rawRecords.records.length}`);
        let isErrorLess = true;

        let cursorOfTheLatestEvent: string | undefined = undefined;
        let dateOfTheLatestEvent: Date | undefined = undefined;

        // WARN: The any type is used here because the structure of rawRecords is not strictly defined.
        /* eslint-disable @typescript-eslint/no-explicit-any */
        for (const record of rawRecords.records) {
            try {
                const syncGoogleCalendarEvent = SyncGoogleCalendarEvent.create({
                    id: record.id.toString(),
                    kind: record.kind,
                    etag: record.etag,
                    status: record.status,
                    htmlLink: record.htmlLink,
                    created: record.created ? new Date(record.created) : new Date(),
                    updated: record.updated ? new Date(record.updated) : new Date(),
                    summary: record.summary,
                    description: record.description,
                    fullContent: record.description + "\n" +
                        record.summary + "\n" +
                        `Creator: ${record.creator.email} ${record.creator.displayName}` + "\n" +
                        `Organizer: ${record.organizer.email} ${record.organizer.displayName}` + "\n" + record.location,
                    location: record.location,
                    creator: record.creator ? SyncGoogleCalendarEventCreator.create({
                        id: record.creator.id,
                        email: record.creator.email,
                        displayName: record.creator.displayName,
                        self: record.creator.self,
                    }) : undefined,
                    organizer: record.organizer ? SyncGoogleCalendarEventOrganizer.create({
                        id: record.organizer.id,
                        email: record.organizer.email,
                        displayName: record.organizer.displayName,
                        self: record.organizer.self,
                    }) : undefined,
                    start: record.start ? new Date(record.start.dateTime || record.start.date) : new Date(),
                    end: record.end ? new Date(record.end.dateTime || record.end.date) : new Date(),
                    endTimeUnspecified: record.endTimeUnspecified,
                    recurrence: record.recurrence || [],
                    recurringEventId: record.recurringEventId,
                    attendees: record.attendees ? record.attendees.map((attendee: Record<string, any>) =>
                        (SyncGoogleCalendarEventAttendee.create({
                            id: attendee.id,
                            email: attendee.email,
                            displayName: attendee.displayName,
                            organizer: attendee.organizer,
                            self: attendee.self,
                            resource: attendee.resource,
                            optional: attendee.optional,
                            responseStatus: attendee.responseStatus,
                            comment: attendee.comment,
                            additionalGuests: attendee.additionalGuests,
                        }))) : [],
                    attendeesOmitted: record.attendeesOmitted,
                    hangoutLink: record.hangoutLink,
                    nangoMetadata: SyncNangoMetadata.create({
                        deletedAt: record._nango_metadata.deleted_at ? new Date(record._nango_metadata.deleted_at) : undefined,
                        lastAction: record._nango_metadata.last_action,
                        firstSeenAt: new Date(record._nango_metadata.first_seen_at),
                        cursor: record._nango_metadata.cursor,
                        lastModifiedAt: new Date(record._nango_metadata.last_modified_at),
                    }),
                });

                // Update cursor and start date of the latest event by comparing dates
                if ((!dateOfTheLatestEvent || (syncGoogleCalendarEvent.start || dateOfTheLatestEvent) > dateOfTheLatestEvent) &&
                    syncGoogleCalendarEvent.nangoMetadata?.cursor) {
                    dateOfTheLatestEvent = syncGoogleCalendarEvent.start;
                    cursorOfTheLatestEvent = syncGoogleCalendarEvent.nangoMetadata?.cursor;
                }

                // Save to Firestore
                await UserSyncGoogleCalendarAccessor.set(
                    syncGoogleCalendarEventsFromNangoToFirestoreRequest.userId,
                    syncGoogleCalendarEventsFromNangoToFirestoreRequest.integrationId,
                    syncGoogleCalendarEvent,
                );
            } catch (e) {
                isErrorLess = false;
                endpoint.logger.error(`${moduleName}-events:error saving record`, e);
            }
        }
        endpoint.logger.info("Finished processing records from Nango");

        // Save the sync information
        await UserSyncGoogleCalendarAccessor.setSyncInfo(
            syncGoogleCalendarEventsFromNangoToFirestoreRequest.userId,
            syncGoogleCalendarEventsFromNangoToFirestoreRequest.integrationId,
            SyncInformation.create({
                id: UserSyncGoogleCalendarAccessor.firestoreSyncDocumentId,
                nangoIntegrationId: syncGoogleCalendarEventsFromNangoToFirestoreRequest.integrationId,
                updatedAt: new Date(),
                nangoNextCursor: cursorOfTheLatestEvent || cursor || undefined,
                status: isErrorLess ? SyncStatus.COMPLETED : SyncStatus.PARTIALLY_COMPLETED,
            }),
        );

        return SyncGoogleCalendarEventsFromNangoToFirestoreResponse.create({
            error: SemurEngineErrorCode.NO_ERROR,
            message: "Success",
        });
    } catch (error) {
        endpoint.logger.error(`${moduleName}-events:error fetching records from Nango`, error);
        // Update the sync status to failed
        await UserSyncGoogleCalendarAccessor.updateCustomFieldsSyncInfo(
            syncGoogleCalendarEventsFromNangoToFirestoreRequest.userId,
            syncGoogleCalendarEventsFromNangoToFirestoreRequest.integrationId,
            {
                status: SyncStatus.FAILED,
            },
        );
        throw SemurEngineErrorBuilder.nangoError(`Failed to get user connections: ${error}`);
    }
};
