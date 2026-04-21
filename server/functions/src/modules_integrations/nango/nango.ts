import {Nango} from "@nangohq/node";
import {SemurEngineConfig} from "../../config";
import {
    SemurEngineEndpoint,
    SemurEngineErrorBuilder,
    SemurEngineRequestParams,
    SemurEngineResponder,
} from "../../semur_engine/semur_engine";
import {
    NangoConnectionWebhookEndUser,
    NangoConnectionWebhookError,
    NangoConnectionWebhookRequest,
    NangoSessionTokenRequest,
    NangoSessionTokenResponse, NangoSyncWebhookRequest, NangoSyncWebhookResponseResults, NangoTriggerSyncRequest,
    NangoTriggerSyncResponse,
    NangoUserConnectionsRequest, NangoUserConnectionsResponse,
} from "../../models.pb/semur-engine/nango-engine/nango_engine";
import {SemurEngineErrorCode} from "../../models.pb/semur-engine/semur_engine";
import {UserAccessor, UserNangoConnectionQueryKey} from "../../accessors/users/user_accessor";
import {
    NangoConnection,
    NangoConnectionError,
    NangoConnectionPublic,
    NangoConnectionStatus,
} from "../../models.pb/nango/nango";
import {firestore} from "firebase-admin";
import {SemurEngineEndpointsSecrets} from "../../semur_engine/semur_engine_types";
import Timestamp = firestore.Timestamp;
import {Request} from "express";
import {privateSyncGoogleMailEmailsFromNangoToFirestore} from "../syncs/google-mail_sync";
import {

    SyncGoogleMailEmailsFromNangoToFirestoreRequest,
} from "../../models.pb/semur-engine/syncs-engine/sync_engine_google-mail";
import {NangoSyncsHelper} from "../../helpers/nango/nango_syncs_helper";
import {UserSyncGoogleMailAccessor} from "../../accessors/users/syncs/user_sync_google_mail_accessor";
import {SyncInformation, SyncStatus} from "../../models.pb/syncs/sync";
import {
    SyncGoogleCalendarEventsFromNangoToFirestoreRequest,
} from "../../models.pb/semur-engine/syncs-engine/sync_engine_google-calendar";
import {privateSyncGoogleCalendarEventsFromNangoToFirestore} from "../syncs/google-calendar_sync";
import {SyncFilter} from "../../models.pb/semur-engine/syncs-engine/sync_engine";
import {
    SyncOutlookMailEmailsFromNangoToFirestoreRequest,
} from "../../models.pb/semur-engine/syncs-engine/sync_engine_outlook-mail";
import {privateSyncOutlookMailEmailsFromNangoToFirestore} from "../syncs/outlook-mail_sync";
import {getNangoSecret} from "../../runtime/runtime_config";
import {verifyNangoWebhookRequest} from "../../runtime/nango_webhooks";
import {IntegrationIds} from "../../runtime/integration_ids";
import {criticalNangoCallableOptions} from "../../runtime/function_profiles";

const moduleName = SemurEngineConfig.isDev ? "nango-dev" : "nango";

// Lazy initialization function for Nango client
export const getNangoClient = (nangoSecret: string = getNangoSecret()) => {
    return new Nango({secretKey: nangoSecret});
};

export const userConnections = new SemurEngineEndpoint(`${moduleName}-userConnections`).onCall(
    // TODO: Enable App Check later
    {
        ...criticalNangoCallableOptions,
        enforceAppCheck: false,
    },
    async (request, endpoint) => {
        if (!request.auth || !request.auth.uid) {
            throw SemurEngineErrorBuilder.unauthorized("You are not authenticated");
        }
        const nangoUserConnectionsRequest: NangoUserConnectionsRequest = {
            userId: request.data.userId,
            organizationId: request.data.organizationId || null,
        };

        if (!nangoUserConnectionsRequest.userId) {
            throw SemurEngineErrorBuilder.badRequest("User ID is required");
        }

        // Ask Nango for a secure token
        try {
            const connections = await UserAccessor.nangoConnectionQuery(UserNangoConnectionQueryKey.All, {
                userId: nangoUserConnectionsRequest.userId,
            });

            // Convert connections to NangoConnectionPublic
            const connectionsPublic = connections.map((connection: NangoConnection) => NangoConnectionPublic.create({
                id: connection.id,
                userId: connection.userId,
                organizationId: connection.organizationId,
                status: connection.status,
                provider: connection.provider,
                // TODO: There is some problem with receiving this value in Client. For now, leave it not used
                // updatedAt: connection.updatedAt,
            }));

            return NangoUserConnectionsResponse.create({
                error: SemurEngineErrorCode.NO_ERROR,
                message: "Success",
                connections: connectionsPublic,
            });
        } catch (error) {
            throw SemurEngineErrorBuilder.nangoError(`Failed to get user connections: ${error}`);
        }
    },
);

export const sessionToken = new SemurEngineEndpoint(`${moduleName}-sessionToken`).onCall(
    // TODO: Enable App Check later
    {
        ...criticalNangoCallableOptions,
        enforceAppCheck: false,
        secrets: SemurEngineEndpointsSecrets[`${moduleName}-sessionToken`],
    },
    async (request, endpoint) => {
        if (!request.auth || !request.auth.uid) {
            throw SemurEngineErrorBuilder.unauthorized("You are not authenticated");
        }
        const nangoSessionTokenRequest: NangoSessionTokenRequest = {
            integrationId: request.data.integrationId,
            userId: request.data.userId,
            userEmail: request.data.userEmail || null,
            userName: request.data.userName || null,
        };

        if (!nangoSessionTokenRequest.integrationId || nangoSessionTokenRequest.integrationId.length === 0) {
            throw SemurEngineErrorBuilder.badRequest("Integration ID is required");
        }

        // Ask Nango for a secure token
        try {
            const nango = getNangoClient();
            const res = await nango.createConnectSession({
                end_user: {
                    id: nangoSessionTokenRequest.userId || request.auth.uid,
                    email: nangoSessionTokenRequest.userEmail || undefined,
                    display_name: nangoSessionTokenRequest.userName || undefined,
                },
                allowed_integrations: [nangoSessionTokenRequest.integrationId],
            });

            if (!res || !res.data || !res.data.token) {
                // Return instead of throwing, as throwing will be caught locally
                return NangoSessionTokenResponse.create({
                    error: SemurEngineErrorCode.NANGO_SESSION_TOKEN_ERROR,
                    message: "Failed to get token from Nango",
                    token: undefined,
                });
            }

            return NangoSessionTokenResponse.create({
                error: SemurEngineErrorCode.NO_ERROR,
                message: "Success",
                token: res.data.token,
            });
        } catch (error) {
            throw SemurEngineErrorBuilder.nangoError(`Failed to get token from Nango: ${error}`);
        }
    },
);

export const webhook = new SemurEngineEndpoint(`${moduleName}-webhook`).onRequest(
    // {cors: [/gosemur\.com$/], region: "europe-north1"},
    {
        cors: true,
        secrets: SemurEngineEndpointsSecrets[`${moduleName}-webhook`],
        timeoutSeconds: 1200, // 10 minutes
    },
    async (request, responder, endpoint) => {
        // Verify request method
        if (!verifyNangoWebhookRequest(request)) {
            throw SemurEngineErrorBuilder.unauthorized("Invalid or missing Nango webhook signature");
        }

        if (!request.body.type) {
            throw SemurEngineErrorBuilder.badRequest("Missing webhook type");
        }

        switch (request.body.type) {
            case "auth":
                await processConnectionWebhook(request, responder, endpoint);
                break;
            case "sync":
                await processSyncWebhook(request, responder, endpoint);
                break;
            default:
                // Ignore other webhook types for now
                responder.success();
                break;
        }
    },
    new SemurEngineRequestParams(
        ["POST"],
        false,
        true,
        false,
    ),
);

export const triggerNangoSync = async (
    request: NangoTriggerSyncRequest,
    endpoint?: SemurEngineEndpoint,
) => {
    if (!request.providerConfigKey || request.providerConfigKey.length === 0) {
        throw SemurEngineErrorBuilder.badRequest("Provider config key is required");
    }
    if (!request.connectionId || request.connectionId.length === 0) {
        throw SemurEngineErrorBuilder.badRequest("Connection ID is required");
    }
    try {
        const nango = getNangoClient();
        if (endpoint && endpoint.logger) {
            endpoint.logger.info("Triggering Nango sync", {request});
        }


        await nango.triggerSync(
            request.providerConfigKey,
            request.syncs,
            request.connectionId,
            NangoSyncsHelper.convertSyncModeToString(request.syncMode),
        );


        if (await UserSyncGoogleMailAccessor.existsSyncInfo(
            request.userId,
            request.providerConfigKey,
        )) {
            // Update the sync status to pending
            await UserSyncGoogleMailAccessor.updateCustomFieldsSyncInfo(
                request.userId,
                request.providerConfigKey,
                {
                    status: SyncStatus.PENDING,
                },
            );
        } else {
            await UserSyncGoogleMailAccessor.setSyncInfo(
                request.userId,
                request.providerConfigKey,
                SyncInformation.create({
                    id: UserSyncGoogleMailAccessor.firestoreSyncDocumentId,
                    nangoIntegrationId: request.providerConfigKey,
                    updatedAt: new Date(),
                    status: SyncStatus.PENDING,
                }),
            );
        }

        if (endpoint && endpoint.logger) {
            endpoint.logger.info("Successfully triggered Nango sync");
        }
        return NangoTriggerSyncResponse.create({
            error: SemurEngineErrorCode.NO_ERROR,
            message: "Successfully triggered sync",
        });
    } catch (error) {
        // Update the sync status to failed
        throw SemurEngineErrorBuilder.nangoError(`Failed to trigger sync: ${error}`);
    }
};

const processConnectionWebhook = async (request: Request, responder: SemurEngineResponder, endpoint: SemurEngineEndpoint) => {
    const nangoConnectionWebhookRequest: NangoConnectionWebhookRequest = {
        type: request.body.type,
        operation: request.body.operation,
        connectionId: request.body.connectionId,
        authMode: request.body.authMode || null,
        providerConfigKey: request.body.providerConfigKey || null,
        provider: request.body.provider || null,
        environment: request.body.environment || null,
        success: request.body.success || false,
        endUser: NangoConnectionWebhookEndUser.create({
            endUserId: request.body.endUser.endUserId || null,
            organizationId: request.body.endUser.organizationId || null,
        }),
        error: NangoConnectionWebhookError.create({
            type: request.body.error?.type || null,
            message: request.body.error?.message || null,
        }),
    };
    if (nangoConnectionWebhookRequest.type !== "auth" || !nangoConnectionWebhookRequest.endUser ||
        !nangoConnectionWebhookRequest.endUser.endUserId || !nangoConnectionWebhookRequest.providerConfigKey) {
        throw SemurEngineErrorBuilder.badRequest("Invalid webhook request");
    }
    await UserAccessor.nangoConnectionSet(
        nangoConnectionWebhookRequest.endUser.endUserId,
        NangoConnection.create({
            id: nangoConnectionWebhookRequest.providerConfigKey,
            userId: nangoConnectionWebhookRequest.endUser.endUserId,
            organizationId: nangoConnectionWebhookRequest.endUser.organizationId,
            connectionId: request.body.connectionId,
            status: nangoConnectionWebhookRequest.success ?
                NangoConnectionStatus.NANGO_CONNECTION_ACTIVE : NangoConnectionStatus.NANGO_CONNECTION_INACTIVE,
            provider: nangoConnectionWebhookRequest.provider,
            authMode: nangoConnectionWebhookRequest.authMode,
            nangoError: NangoConnectionError.create({
                type: nangoConnectionWebhookRequest.error?.type || undefined,
                message: nangoConnectionWebhookRequest.error?.message || undefined,
            }),
            updatedAt: Timestamp.now().toDate(),
        }),
    );
    responder.success();
};

const processSyncWebhook = async (request: Request, responder: SemurEngineResponder, endpoint: SemurEngineEndpoint) => {
    const nangoSyncWebhookRequest: NangoSyncWebhookRequest = {
        type: request.body.type,
        connectionId: request.body.connectionId,
        providerConfigKey: request.body.providerConfigKey || null,
        syncName: request.body.syncName || null,
        model: request.body.model || null,
        syncType: request.body.syncType || null,
        success: request.body.success || false,
        modifiedAfter: new Date(request.body.modifiedAfter ?? Date.now()),
        responseResults: NangoSyncWebhookResponseResults.create({
            added: request.body.responseResults?.added || 0,
            updated: request.body.responseResults?.updated || 0,
            deleted: request.body.responseResults?.deleted || 0,
        }),
    };
    if (nangoSyncWebhookRequest.type !== "sync" || !nangoSyncWebhookRequest.connectionId || !nangoSyncWebhookRequest.providerConfigKey) {
        throw SemurEngineErrorBuilder.badRequest("Invalid webhook request");
    }

    responder.success();

    try {
        // Get user ID from connection ID
        const userId = await UserAccessor.nangoConnectionIdToUserIdMappingGet(request.body.connectionId);

        switch (nangoSyncWebhookRequest.providerConfigKey) {
            case IntegrationIds.googleMail: {
                const syncGoogleMailEmailsRequest: SyncGoogleMailEmailsFromNangoToFirestoreRequest = {
                    userId: userId,
                    integrationId: nangoSyncWebhookRequest.providerConfigKey,
                    // TODO: Magic Value
                    limit: 500,
                    filter: [
                        SyncFilter.ADDED,
                        SyncFilter.UPDATED,
                        SyncFilter.DELETED,
                    ],
                };

                await privateSyncGoogleMailEmailsFromNangoToFirestore(
                    syncGoogleMailEmailsRequest,
                    endpoint,
                    nangoSyncWebhookRequest.success,
                    (nangoSyncWebhookRequest.responseResults?.added || 0) > 0 || (nangoSyncWebhookRequest.responseResults?.updated || 0) > 0,
                );
                break;
            }
            case IntegrationIds.googleCalendar: {
                const syncGoogleCalendarEventsFromNangoToFirestoreRequest: SyncGoogleCalendarEventsFromNangoToFirestoreRequest = {
                    userId: userId,
                    integrationId: nangoSyncWebhookRequest.providerConfigKey,
                    // TODO: Magic Value
                    limit: 100,
                    filter: [
                        SyncFilter.ADDED,
                        SyncFilter.UPDATED,
                        SyncFilter.DELETED,
                    ],
                };

                await privateSyncGoogleCalendarEventsFromNangoToFirestore(
                    syncGoogleCalendarEventsFromNangoToFirestoreRequest,
                    endpoint,
                    nangoSyncWebhookRequest.success,
                    (nangoSyncWebhookRequest.responseResults?.added || 0) > 0 || (nangoSyncWebhookRequest.responseResults?.updated || 0) > 0,
                );
                break;
            }

            case IntegrationIds.outlookMail: {
                const syncOutlookMailEmailsFromNangoToFirestoreRequest: SyncOutlookMailEmailsFromNangoToFirestoreRequest = {
                    userId: userId,
                    integrationId: nangoSyncWebhookRequest.providerConfigKey,
                    limit: 100,
                    filter: [
                        SyncFilter.ADDED,
                        SyncFilter.UPDATED,
                        SyncFilter.DELETED,
                    ],
                };

                await privateSyncOutlookMailEmailsFromNangoToFirestore(
                    syncOutlookMailEmailsFromNangoToFirestoreRequest,
                    endpoint,
                    nangoSyncWebhookRequest.success,
                    (nangoSyncWebhookRequest.responseResults?.added || 0) > 0 || (nangoSyncWebhookRequest.responseResults?.updated || 0) > 0,
                );
                break;
            }

            default:
                endpoint.logger.warn(`processSyncWebhook: Unsupported providerConfigKey ${nangoSyncWebhookRequest.providerConfigKey}`);
                return;
        }
    } catch (e) {
        endpoint.logger.warn(`processSyncWebhook error running sync: ${e}`);
    }
};
