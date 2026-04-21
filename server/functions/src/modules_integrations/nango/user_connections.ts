import {SemurEngineConfig} from "../../config";
import {
    SemurEngineEndpoint,
    SemurEngineErrorBuilder,
} from "../../semur_engine/semur_engine";
import {
    NangoUserConnectionsRequest,
    NangoUserConnectionsResponse,
} from "../../models.pb/semur-engine/nango-engine/nango_engine";
import {SemurEngineErrorCode} from "../../models.pb/semur-engine/semur_engine";
import {
    UserAccessor,
    UserNangoConnectionQueryKey,
} from "../../accessors/users/user_accessor";
import {
    NangoConnection,
    NangoConnectionPublic,
} from "../../models.pb/nango/nango";
import {criticalNangoCallableOptions} from "../../runtime/function_profiles";

const moduleName = SemurEngineConfig.isDev ? "nango-dev" : "nango";

export const userConnections = new SemurEngineEndpoint(
    `${moduleName}-userConnections`,
).onCall(
    {
        ...criticalNangoCallableOptions,
        enforceAppCheck: false,
    },
    async (request) => {
        if (!request.auth || !request.auth.uid) {
            throw SemurEngineErrorBuilder.unauthorized(
                "You are not authenticated",
            );
        }

        const nangoUserConnectionsRequest: NangoUserConnectionsRequest = {
            userId: request.data.userId,
            organizationId: request.data.organizationId || null,
        };

        if (!nangoUserConnectionsRequest.userId) {
            throw SemurEngineErrorBuilder.badRequest("User ID is required");
        }

        if (nangoUserConnectionsRequest.userId !== request.auth.uid) {
            throw SemurEngineErrorBuilder.permissionDenied(
                "You can only load your own integrations",
            );
        }

        try {
            const connections = await UserAccessor.nangoConnectionQuery(
                UserNangoConnectionQueryKey.All,
                {
                    userId: nangoUserConnectionsRequest.userId,
                },
            );

            const connectionsPublic = connections.map(
                (connection: NangoConnection) => NangoConnectionPublic.create({
                    id: connection.id,
                    userId: connection.userId,
                    organizationId: connection.organizationId,
                    status: connection.status,
                    provider: connection.provider,
                }),
            );

            return NangoUserConnectionsResponse.create({
                error: SemurEngineErrorCode.NO_ERROR,
                message: "Success",
                connections: connectionsPublic,
            });
        } catch (error) {
            throw SemurEngineErrorBuilder.nangoError(
                `Failed to get user connections: ${error}`,
            );
        }
    },
);
