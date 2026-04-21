import {
    CallableOptions,
    CallableRequest,
    HttpsError,
    HttpsOptions,
    onCall,
    onRequest,
} from "firebase-functions/v2/https";
import {Request, Response} from "express";
import * as logger from "firebase-functions/logger";
import {
    Change,
    FirestoreEvent,
    onDocumentCreated,
    onDocumentUpdated,
    QueryDocumentSnapshot,
} from "firebase-functions/v2/firestore";
import {onSchedule, ScheduledEvent, ScheduleOptions} from "firebase-functions/v2/scheduler";
import {
    ErrorJson,
    SemurEngineEndpointsSecrets,
    SemurEngineEventType,
    LogData,
} from "./semur_engine_types";
import {SemurEngineConfig} from "../config";
import {nanoid} from "nanoid";
import {SemurEngineErrorCode, SemurEngineResponse} from "../models.pb/semur-engine/semur_engine";

/**
 * SemurEngineLogger is a utility class for logging messages with a request ID and function name.
 * It provides methods for logging info, error, warning, and debug messages.
 */
export class SemurEngineLogger {
    static loggableErrorCodes = [
        SemurEngineErrorCode.INTERNAL_ERROR,
        SemurEngineErrorCode.CONFLICT,
        SemurEngineErrorCode.UNAVAILABLE,
    ];

    private readonly functionName: string;
    private readonly requestId: string;

    /**
     * Creates an instance of SemurEngineLogger.
     * @param {string} functionName - The name of the function for logging context
     * @param {string} requestId - Optional request ID for tracking, generated if not provided
     */
    constructor(functionName: string, requestId?: string) {
        this.functionName = functionName;
        this.requestId = requestId || nanoid(10); // Generate a short unique ID for the request if not provided
    }

    /**
     * Logs a custom event to Firebase Analytics.
     * @param {string} eventName - The name of the event
     * @param {SemurEngineEventType} eventType - The type of the event (info, error, warning, debug)
     * @param {LogData} params - Additional parameters to log
     */
    customLogEvent(eventName: string, eventType: SemurEngineEventType, params: LogData = {}): void {
        switch (eventType) {
            case SemurEngineEventType.ERROR:
                this.error(eventName, {
                    ...params,
                    requestId: this.requestId,
                    functionName: this.functionName,
                });
                break;
            case SemurEngineEventType.WARNING:
                this.warn(eventName, {
                    ...params,
                    requestId: this.requestId,
                    functionName: this.functionName,
                });
                break;
            case SemurEngineEventType.DEBUG:
                this.debug(eventName, {
                    ...params,
                    requestId: this.requestId,
                    functionName: this.functionName,
                });
                break;
            case SemurEngineEventType.INFO:
            default:
                this.info(eventName, {
                    ...params,
                    requestId: this.requestId,
                    functionName: this.functionName,
                });
        }
    }

    /**
     * Logs an informational message with the request ID and function name.
     * @param {string} message - The message to log
     * @param {LogData} data - Additional data to include in the log
     */
    info(message: string, data: LogData = {}): void {
        logger.info(message, {
            ...data,
            requestId: this.requestId,
            functionName: this.functionName,
        });
    }

    /**
     * Logs an error message with the request ID and function name.
     * @param {string} message - The error message to log
     * @param {any} error - The error object or additional error data
     */
    error(message: string, error: unknown): void {
        logger.error(message, {
            error: error instanceof Error ? error.message : error,
            stack: error instanceof Error ? error.stack : null,
            requestId: this.requestId,
            functionName: this.functionName,
        });
    }

    /**
     * Logs a warning message with the request ID and function name.
     * @param {string} message - The warning message to log
     * @param {LogData} data - Additional data to include in the log
     */
    warn(message: string, data: LogData = {}): void {
        logger.warn(message, {
            ...data,
            requestId: this.requestId,
            functionName: this.functionName,
        });
    }

    /**
     * Logs a debug message with the request ID and function name.
     * @param {string} message - The debug message to log
     * @param {LogData} data - Additional data to include in the log
     */
    debug(message: string, data: LogData = {}): void {
        logger.debug(message, {
            ...data,
            requestId: this.requestId,
            functionName: this.functionName,
        });
    }
}

/**
 * SemurEngineError is a custom error class for handling errors in the Semur Engine.
 */
export class SemurEngineError extends Error {
    public code: SemurEngineErrorCode;
    public httpStatusCode: number;

    /**
     * Creates an instance of SemurEngineError.
     * @param {string} message The error message
     * @param {number} code The error code
     * @param {number} httpStatusCode The HTTP status code
     * @param {string} name The name of the error, defaults to 'SemurEngineError'
     */
    constructor({message, code = SemurEngineErrorCode.NO_ERROR, httpStatusCode = 500, name = "SemurEngineError"}: {
        message: string,
        code?: SemurEngineErrorCode,
        httpStatusCode?: number,
        name?: string
    }) {
        super(message);
        this.code = code;
        this.httpStatusCode = httpStatusCode;
        this.name = name;
    }

    /**
     * Converts the error to a JSON representation.
     * @return {ErrorJson} The JSON representation of the error
     */
    toJson(): ErrorJson {
        return {
            error: this.code.valueOf(),
            message: this.message,
            name: this.name,
        };
    }
}

/**
 * SemurEngineErrorBuilder is a utility class for building SemurEngineError instances.
 */
export class SemurEngineErrorBuilder {
    static noError(): SemurEngineError {
        return new SemurEngineError({message: "", code: SemurEngineErrorCode.NO_ERROR, httpStatusCode: 200});
    }

    static customError(message: string, code = SemurEngineErrorCode.CUSTOM_ERROR): SemurEngineError {
        return new SemurEngineError({message: message, code: code, httpStatusCode: 500});
    }

    static internalError(message = "Internal Server Error"): SemurEngineError {
        return new SemurEngineError({
            message: message,
            code: SemurEngineErrorCode.INTERNAL_ERROR,
            httpStatusCode: 500,
        });
    }

    static badRequest(message = "Bad Request"): SemurEngineError {
        return new SemurEngineError({message: message, code: SemurEngineErrorCode.BAD_REQUEST, httpStatusCode: 400});
    }

    static unauthorized(message = "Unauthorized"): SemurEngineError {
        return new SemurEngineError({message: message, code: SemurEngineErrorCode.UNAUTHORIZED, httpStatusCode: 401});
    }

    static notFound(message = "Not Found"): SemurEngineError {
        return new SemurEngineError({message: message, code: SemurEngineErrorCode.NOT_FOUND, httpStatusCode: 404});
    }

    static methodNotAllowed(message = "Method Not Allowed"): SemurEngineError {
        return new SemurEngineError({
            message: message,
            code: SemurEngineErrorCode.METHOD_NOT_ALLOWED,
            httpStatusCode: 405,
        });
    }

    static conflict(message = "Conflict"): SemurEngineError {
        return new SemurEngineError({message: message, code: SemurEngineErrorCode.CONFLICT, httpStatusCode: 409});
    }

    static tooManyRequests(message = "Too Many Requests"): SemurEngineError {
        return new SemurEngineError({
            message: message,
            code: SemurEngineErrorCode.TOO_MANY_REQUESTS,
            httpStatusCode: 429,
        });
    }

    static unavailable(message = "Service Unavailable"): SemurEngineError {
        return new SemurEngineError({message: message, code: SemurEngineErrorCode.UNAVAILABLE, httpStatusCode: 503});
    }

    static permissionDenied(message = "Permission Denied"): SemurEngineError {
        return new SemurEngineError({
            message: message,
            code: SemurEngineErrorCode.PERMISSION_DENIED,
            httpStatusCode: 403,
        });
    }

    // Nango
    static nangoError(message = "Nango Error"): SemurEngineError {
        return new SemurEngineError({
            message: message,
            code: SemurEngineErrorCode.NANGO_ERROR,
            httpStatusCode: 500,
        });
    }

    static nangoSessionTokenError(message = "Nango Session Token Error"): SemurEngineError {
        return new SemurEngineError({
            message: message,
            code: SemurEngineErrorCode.NANGO_SESSION_TOKEN_ERROR,
            httpStatusCode: 500,
        });
    }
}

/**
 * SemurEngineResponder is a utility class for responding to HTTP requests in a consistent manner.
 */
export class SemurEngineResponder {
    public requestId: string;
    public expressResponse: Response; // Type any to allow Express response methods
    /**
     * Creates an instance of SemurEngineResponder.
     * @param requestId
     * @param expressResponse
     */
    constructor(requestId: string, expressResponse: Response) {
        this.requestId = requestId;
        this.expressResponse = expressResponse;
    }

    /**
     * Responds to the HTTP request with a JSON object.
     * @param data
     * @param statusCode
     * @param errorModel
     * @return {*}
     */
    respond(data = {}, statusCode = 200, errorModel: SemurEngineError) {
        this.expressResponse.status(statusCode).json({
            requestId: this.requestId,
            error: errorModel.code || 0,
            message: errorModel.message || "",
            ...data,
        }).send();
    }

    /**
     * Responds to the HTTP request with a success message.
     * @param data
     * @return {*}
     */
    success(data = {}) {
        this.respond(data, 200, SemurEngineErrorBuilder.noError());
    }

    /**
     * Responds to the HTTP request with an error message.
     * @param data
     * @param statusCode
     * @param errorModel
     * @return {*}
     */
    error(data = {}, statusCode = 500, errorModel: SemurEngineError) {
        this.respond(data, statusCode, errorModel);
    }

    /**
     * Responds to the HTTP request with an internal server error message.
     * @param errorMessage
     * @return {*}
     */
    internalError(errorMessage = "Internal Server Error") {
        this.respond({}, 500, SemurEngineErrorBuilder.internalError(errorMessage));
    }

    /**
     * Responds to the HTTP request with a bad request message.
     * @param errorMessage
     * @return {*}
     */
    badRequest(errorMessage = "Bad Request") {
        this.respond({}, 400, SemurEngineErrorBuilder.badRequest(errorMessage));
    }

    /**
     * Responds to the HTTP request with an unauthorized message.
     * @param errorMessage
     * @return {*}
     */
    unauthorized(errorMessage = "Unauthorized") {
        this.respond({}, 401, SemurEngineErrorBuilder.unauthorized(errorMessage));
    }

    /**
     * Responds to the HTTP request with a not found message.
     * @param errorMessage
     * @return {*}
     */
    notFound(errorMessage = "Not Found") {
        this.respond({}, 404, SemurEngineErrorBuilder.notFound(errorMessage));
    }

    /**
     * Responds to the HTTP request with a method not allowed message.
     * @param errorMessage
     * @return {*}
     */
    methodNotAllowed(errorMessage = "Method Not Allowed") {
        this.respond({}, 405, SemurEngineErrorBuilder.methodNotAllowed(errorMessage));
    }

    /**
     * Responds to the HTTP request with a conflict message.
     * @param errorMessage
     * @return {*}
     */
    conflict(errorMessage = "Conflict") {
        this.respond({}, 409, SemurEngineErrorBuilder.conflict(errorMessage));
    }

    /**
     * Responds to the HTTP request with a too many requests message.
     * @param errorMessage
     * @return {*}
     */
    tooManyRequests(errorMessage = "Too Many Requests") {
        this.respond({}, 429, SemurEngineErrorBuilder.tooManyRequests(errorMessage));
    }

    /**
     * Responds to the HTTP request with a service unavailable message.
     * @param errorMessage
     * @return {*}
     */
    unavailable(errorMessage: string) {
        this.respond({}, 503, SemurEngineErrorBuilder.unavailable(errorMessage || "Service Unavailable"));
    }
}


/**
 * SemurEngineEndpoint is a utility class for handling requests in a structured way.
 */

export class SemurEngineEndpoint {
    public endpointName: string;
    public requestId: string;
    public logger: SemurEngineLogger;

    /**
     * Creates an instance of SemurEngineEndpoint.
     * @param endpointName
     */
    constructor(endpointName: string) {
        this.endpointName = endpointName;
        this.requestId = nanoid(10); // Generate a short unique ID for the request
        this.logger = new SemurEngineLogger(endpointName, this.requestId);
    }

    /**
     * Handles an HTTP request by calling the provided function.
     */
    onRequest(
        opts: HttpsOptions,
        functionCall: (request: Request, responder: SemurEngineResponder, endpoint: SemurEngineEndpoint) => (void | Promise<void>),
        requestParams = new SemurEngineRequestParams(),
    ) {
        return onRequest(
            opts,
            async (request, response) => {
                const responder = new SemurEngineResponder(this.requestId, response);
                try {
                    // Check allowed methods
                    if (requestParams.allowedMethods && !requestParams.allowedMethods.includes(request.method)) {
                        this.logger.customLogEvent(this.endpointName + ":method_not_allowed",
                            SemurEngineEventType.INFO,
                            {
                                method: request.method,
                                headers: request.headers,
                                body: request.body,
                            });
                        responder.methodNotAllowed();
                    }
                    // Check if need to respond before calling functionCall
                    if (requestParams.respondBeforeFunction) {
                        responder.success();
                    }
                    // Log the request with random unique and short id to track other logs for this request
                    this.logger.customLogEvent(this.endpointName + ":triggered",
                        SemurEngineEventType.INFO,
                        {
                            headers: request.headers,
                            body: request.body,
                            method: request.method,
                        });
                    // Call the function
                    (await functionCall)(request, responder, this);
                } catch (error: unknown) {
                    this.logger.customLogEvent(this.endpointName + ":error",
                        SemurEngineEventType.ERROR,
                        {
                            headers: request.headers,
                            body: request.body,
                            method: request.method,
                            errorCode: error instanceof SemurEngineError ? error.code : 500,
                            message: error instanceof SemurEngineError ? error.message : (error as Error).message || "Internal Server Error",
                        });
                    if (requestParams.respondOnError) {
                        if (error instanceof SemurEngineError) {
                            responder.error({}, error.httpStatusCode, error);
                        } else if (error instanceof HttpsError) {
                            switch (error.code) {
                                case "unauthenticated":
                                    responder.unauthorized(error.message);
                                    break;
                                case "not-found":
                                    responder.notFound(error.message);
                                    break;
                                case "invalid-argument":
                                    responder.badRequest(error.message);
                                    break;
                                case "permission-denied":
                                    responder.unauthorized(error.message);
                                    break;
                                case "resource-exhausted":
                                    responder.tooManyRequests(error.message);
                                    break;
                                case "failed-precondition":
                                    responder.conflict(error.message);
                                    break;
                                case "aborted":
                                    responder.conflict(error.message);
                                    break;
                                case "out-of-range":
                                    responder.conflict(error.message);
                                    break;
                                case "unimplemented":
                                    responder.methodNotAllowed(error.message);
                                    break;
                                case "internal":
                                    responder.internalError(error.message);
                                    break;
                                case "unavailable":
                                    responder.unavailable(error.message);
                                    break;
                                default:
                                    responder.error({}, 500, SemurEngineErrorBuilder.internalError(error.message || "Internal Server Error"));
                                    break;
                            }
                        } else {
                            responder.internalError(error instanceof Error ? error.message : "Internal Server Error");
                        }
                    } else {
                        if (requestParams.rethrowError) {
                            throw error;
                        }
                    }
                }
            },
        );
    }

    /**
     * Handles a callable function request by calling the provided function.
     * @param opts
     * @param functionCall
     * @return {Function<any, any>}
     */
    onCall(opts: CallableOptions, functionCall: (request: CallableRequest, endpoint: SemurEngineEndpoint) => Promise<unknown>) {
        return onCall(
            opts,
            async (request) => {
                this.logger.customLogEvent(this.endpointName + ":triggered",
                    SemurEngineEventType.INFO,
                    {
                        headers: request.rawRequest.headers,
                        body: request.data,
                        method: request.rawRequest.method,
                    });
                try {
                    const functionCallResult = await functionCall(request, this);
                    this.logger.customLogEvent(this.endpointName + ":finished",
                        SemurEngineEventType.INFO,
                        {
                            headers: request.rawRequest.headers,
                            body: request.data,
                            method: request.rawRequest.method,
                            result: {
                                ...(functionCallResult || {}),
                            },
                        },
                    );
                    return functionCallResult;
                } catch (error) {
                    // TODO: For SemurEngineError, add option to exclude logging
                    if (!(error instanceof SemurEngineError) || SemurEngineLogger.loggableErrorCodes.includes(error.code)) {
                        this.logger.customLogEvent(this.endpointName + ":error",
                            SemurEngineEventType.ERROR,
                            {
                                errorCode: error instanceof SemurEngineError ? error.code : SemurEngineErrorCode.INTERNAL_ERROR,
                                message: error instanceof SemurEngineError ? error.message : (error as Error).message || "Internal Server Error",
                            });
                    }
                    return SemurEngineResponse.create({
                        error: error instanceof SemurEngineError ? error.code : SemurEngineErrorCode.INTERNAL_ERROR,
                        message: error instanceof SemurEngineError ? error.message : (error as Error).message || "Internal Server Error",
                    });
                }
            },
        );
    }

    /**
     * Handles a Firestore document creation event by calling the provided function.
     */
    onDocumentCreated(
        document: string,
        functionCall: (event: FirestoreEvent<QueryDocumentSnapshot | undefined>, endpoint: SemurEngineEndpoint) => Promise<void>) {
        return onDocumentCreated(
            {
                document: document,
                secrets: SemurEngineEndpointsSecrets[this.endpointName] || [],
                database: SemurEngineConfig.dbId,
            },
            async (event) => {
                this.logger.customLogEvent(this.endpointName + ":triggered",
                    SemurEngineEventType.INFO,
                    {});
                try {
                    return (await functionCall)(event, this);
                } catch (error) {
                    this.logger.customLogEvent(this.endpointName + ":error",
                        SemurEngineEventType.ERROR,
                        {
                            errorCode: error instanceof SemurEngineError ? error.code : SemurEngineErrorCode.INTERNAL_ERROR,
                            message: error instanceof SemurEngineError ? error.message : (error as Error).message || "Internal Server Error",
                        });
                    throw error; // Rethrow the error to be handled by Firebase
                }
            },
        );
    }

    /**
     * Handles a Firestore document update event by calling the provided function.
     * @param opts
     * @param functionCall
     * @return {*}
     */
    onDocumentUpdated(
        document: string,
        functionCall: (event: FirestoreEvent<Change<QueryDocumentSnapshot> | undefined, Record<string, string>>,
                       endpoint: SemurEngineEndpoint) => Promise<void>) {
        return onDocumentUpdated(
            {
                document: document,
                secrets: SemurEngineEndpointsSecrets[this.endpointName] || [],
                database: SemurEngineConfig.dbId,
            },
            async (event) => {
                this.logger.customLogEvent(this.endpointName + ":triggered",
                    SemurEngineEventType.INFO,
                    {});
                try {
                    return (await functionCall)(event, this);
                } catch (error) {
                    this.logger.customLogEvent(this.endpointName + ":error",
                        SemurEngineEventType.ERROR,
                        {
                            errorCode: error instanceof SemurEngineError ? error.code : SemurEngineErrorCode.INTERNAL_ERROR,
                            message: error instanceof SemurEngineError ? error.message : (error as Error).message || "Internal Server Error",
                        });
                    throw error; // Rethrow the error to be handled by Firebase
                }
            },
        );
    }

    /**
     * Handles a scheduled function by calling the provided function.
     */
    onSchedule(opts: ScheduleOptions, functionCall: (event: ScheduledEvent, endpoint: SemurEngineEndpoint) => (void | Promise<void>)) {
        return onSchedule(
            opts,
            async (event) => {
                this.logger.customLogEvent(this.endpointName + ":triggered",
                    SemurEngineEventType.INFO,
                    {});
                try {
                    return (await functionCall)(event, this);
                } catch (error) {
                    this.logger.customLogEvent(this.endpointName + ":error",
                        SemurEngineEventType.ERROR,
                        {
                            errorCode: error instanceof SemurEngineError ? error.code : SemurEngineErrorCode.INTERNAL_ERROR,
                            message: error instanceof SemurEngineError ? error.message : (error as Error).message || "Internal Server Error",
                        });
                    throw error; // Rethrow the error to be handled by Firebase
                }
            },
        );
    }
}


/**
 * SemurEngineRequestParams is a utility class for defining request parameters.

 // opts: HttpsOptions, handler: (request: Request, response: express.Response) => void | Promise<void>
 // optionally list of allowedMethods
 // optionally respondBeforeFunction, if need to respond before calling functionCall
 // optionally respondOnError, if need to respond with error message in case of exception
 // optionally rethrow error, if need to rethrow error instead of responding with error message
 */
export class SemurEngineRequestParams {
    public allowedMethods: string[];
    public respondBeforeFunction: boolean;
    public respondOnError: boolean;
    public rethrowError: boolean;

    /**
     * Creates an instance of SemurEngineRequestParams.
     * @param allowedMethods
     * @param respondBeforeFunction
     * @param respondOnError
     * @param rethrowError
     */
    constructor(allowedMethods: string[] = [], respondBeforeFunction = false, respondOnError = true, rethrowError = false) {
        this.allowedMethods = allowedMethods;
        this.respondBeforeFunction = respondBeforeFunction;
        this.respondOnError = respondOnError;
        this.rethrowError = rethrowError;
    }
}

module.exports = {
    SemurEngineRequestParams: SemurEngineRequestParams,
    SemurEngineLogger: SemurEngineLogger,
    SemurEngineError: SemurEngineError,
    SemurEngineErrorBuilder: SemurEngineErrorBuilder,
    SemurEngineResponder: SemurEngineResponder,
    SemurEngineEndpoint: SemurEngineEndpoint,
    SemurEngineEventType: SemurEngineEventType,
};
