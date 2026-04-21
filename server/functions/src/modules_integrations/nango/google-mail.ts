import {Nango} from "@nangohq/node";
import {SemurEngineConfig} from "../../config";
import {
    SemurEngineEndpoint,
    SemurEngineErrorBuilder,
} from "../../semur_engine/semur_engine";
import {SemurEngineErrorCode} from "../../models.pb/semur-engine/semur_engine";
import {UserAccessor} from "../../accessors/users/user_accessor";
import {SemurEngineEndpointsSecrets} from "../../semur_engine/semur_engine_types";
import {
    NangoGoogleMailSendEmailRequest,
    NangoGoogleMailSendEmailResponse,
} from "../../models.pb/semur-engine/nango-engine/google-mail_engine";
import {IntegrationIds} from "../../runtime/integration_ids";
import {getNangoSecret} from "../../runtime/runtime_config";

const moduleName = SemurEngineConfig.isDev ? "nango-google-mail-dev" : "nango-google-mail";

// Lazy initialization function for Nango client
export const getNangoClient = (nangoSecret: string = getNangoSecret()) => {
    return new Nango({secretKey: nangoSecret});
};

export const sendEmail = new SemurEngineEndpoint(`${moduleName}-sendEmail`).onCall(
    // TODO: Enable App Check later
    {enforceAppCheck: false, secrets: SemurEngineEndpointsSecrets[`${moduleName}-sendEmail`]},
    async (request, endpoint) => {
        if (!request.auth || !request.auth.uid) {
            throw SemurEngineErrorBuilder.unauthorized("You are not authenticated");
        }
        const nangoGoogleMailSendEmailRequest: NangoGoogleMailSendEmailRequest = {
            userId: request.data.userId,
            to: request.data.to,
            headers: request.data.headers || {},
            subject: request.data.subject || undefined,
            body: request.data.body,
        };

        if (!nangoGoogleMailSendEmailRequest.userId || nangoGoogleMailSendEmailRequest.userId.length === 0) {
            throw SemurEngineErrorBuilder.badRequest("User ID is required");
        }

        if (!nangoGoogleMailSendEmailRequest.to) {
            throw SemurEngineErrorBuilder.badRequest("Recipient email address is required");
        }

        if (!nangoGoogleMailSendEmailRequest.body) {
            throw SemurEngineErrorBuilder.badRequest("Email body is required");
        }

        // Get connection id
        let nangoConnection;
        try {
            nangoConnection = await UserAccessor.nangoConnectionGet(
                nangoGoogleMailSendEmailRequest.userId,
                IntegrationIds.googleMail,
            );
        } catch (error) {
            throw SemurEngineErrorBuilder.notFound(
                `Nango connection not found for user ID ${nangoGoogleMailSendEmailRequest.userId} ` +
                `and integration ID ${IntegrationIds.googleMail}: ${error}`,
            );
        }

        const nango = getNangoClient();
        const response = await nango.triggerAction(
            IntegrationIds.googleMail,
            nangoConnection.connectionId,
            "send-email",
            {
                to: nangoGoogleMailSendEmailRequest.to,
                headers: nangoGoogleMailSendEmailRequest.headers,
                subject: nangoGoogleMailSendEmailRequest.subject,
                body: nangoGoogleMailSendEmailRequest.body,
            },
        ) as { id?: string; threadId?: string };
        if (!response || !response.id || !response.threadId) {
            throw SemurEngineErrorBuilder.internalError("Failed to send email");
        }

        return NangoGoogleMailSendEmailResponse.create({
            error: SemurEngineErrorCode.NO_ERROR,
            message: "Success",
        });
    },
);
