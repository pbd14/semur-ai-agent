import type {CallableOptions} from "firebase-functions/v2/https";

// Give critical integration callables enough CPU and memory to start
// predictably without increasing the minimum bill.
export const criticalNangoCallableOptions = {
    // Keep this aligned with the current us-central1 regional CPU quota.
    maxInstances: 10,
    timeoutSeconds: 60,
    memory: "256MiB",
    cpu: 1,
    concurrency: 40,
} satisfies CallableOptions;
