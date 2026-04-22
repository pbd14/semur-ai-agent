import {onCallGenkit} from "firebase-functions/https";
import {SemurEngineEndpointsSecrets} from "../../../semur_engine/semur_engine_types";
import {SemurEngineConfig} from "../../../config";
import {chatFlow, generateEmailResponseFlow} from "./email_assistant_ai";
import {SemurEngineEndpoint} from "../../../semur_engine/semur_engine";
import {runDemoEmailAssistant} from "./demo/demo_orchestrator";

const moduleName = SemurEngineConfig.isDev ? "agent_email_assistant-dev" : "agent_email_assistant";

export const chat = onCallGenkit(
    {
        secrets: SemurEngineEndpointsSecrets[`${moduleName}-chat`],
        timeoutSeconds: 600, // 10 minutes
    },
    chatFlow,
);

export const generateEmailResponse = onCallGenkit(
    {
        secrets: SemurEngineEndpointsSecrets[`${moduleName}-generateEmailResponse`],
        timeoutSeconds: 600, // 10 minutes
    },
    generateEmailResponseFlow,
);

export const demoChat = new SemurEngineEndpoint(`${moduleName}-demoChat`).onCall(
    {
        enforceAppCheck: false,
        maxInstances: 10,
        timeoutSeconds: 60,
        memory: "256MiB",
    },
    async (request) => runDemoEmailAssistant({
        userMessage: request.data?.userMessage,
        sessionId: request.data?.sessionId,
    }),
);
