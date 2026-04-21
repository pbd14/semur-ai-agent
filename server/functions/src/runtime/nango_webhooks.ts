import {createHash, createHmac, timingSafeEqual} from "crypto";
import {Request} from "express";
import {getNangoSecret} from "./runtime_config";

function getHeaderValue(header: string | string[] | undefined): string | undefined {
    if (!header) {
        return undefined;
    }
    return Array.isArray(header) ? header[0] : header;
}

function safeCompare(expected: string, actual: string): boolean {
    const expectedBuffer = Buffer.from(expected, "utf8");
    const actualBuffer = Buffer.from(actual, "utf8");

    if (expectedBuffer.length !== actualBuffer.length) {
        return false;
    }

    return timingSafeEqual(expectedBuffer, actualBuffer);
}

function getSerializedPayload(request: Request): string {
    const requestWithRawBody = request as Request & { rawBody?: Buffer };
    if (requestWithRawBody.rawBody && requestWithRawBody.rawBody.length > 0) {
        return requestWithRawBody.rawBody.toString("utf8");
    }
    return JSON.stringify(request.body ?? {});
}

function buildCompatibilitySignature(secret: string, payload: string): string {
    return createHash("sha256").update(`${secret}${payload}`).digest("hex");
}

function buildHmacSignature(secret: string, payload: string): string {
    return createHmac("sha256", secret).update(payload).digest("hex");
}

export function verifyNangoWebhookRequest(request: Request): boolean {
    const secret = getNangoSecret();
    const payload = getSerializedPayload(request);

    const hmacHeader = getHeaderValue(request.headers["x-nango-hmac-sha256"]);
    if (hmacHeader) {
        return safeCompare(buildHmacSignature(secret, payload), hmacHeader);
    }

    const compatibilityHeader = getHeaderValue(request.headers["x-nango-signature"]);
    if (compatibilityHeader) {
        return safeCompare(buildCompatibilitySignature(secret, payload), compatibilityHeader);
    }

    return false;
}
