import {z} from "genkit";

// Related to SyncInformation proto
export const ZodSyncInformation = z.object({
    integrationId: z.string().describe("The identifier for the associated integration."),
    updatedAt: z.string().describe("The timestamp when the sync information was last updated, in ISO 8601 format."),
    status: z.enum(["PENDING", "IN_PROGRESS", "COMPLETED", "FAILED", "PARTIALLY_COMPLETED"]).optional()
        .describe("The current status of the sync operation."),
    errorMessage: z.string().optional().describe("An error message if the sync operation failed."),
});
