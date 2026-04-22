import {Genkit, z} from "genkit";
import {triggerNangoSync} from "../../../modules_integrations/nango/nango";
import {SemurEngineAiToolSDK} from "../../../semur_engine/semur_engine_ai";
import {ChatSession} from "../../../models.pb/chats/chat";
import {AgentTool} from "../../../models.pb/agents/agent";
import {
    ZodGoogleCalendarEvent,
    ZodGoogleCalendarEventsSearchSchema,
    ZodGoogleCalendarVectorSearchSchema,
} from "./google-calendar_tools_types";
import {firestore} from "firebase-admin";
import {defineFirestoreRetriever} from "@genkit-ai/firebase";
import {SemurEngineConfig} from "../../../config";
import {googleAI} from "@genkit-ai/googleai";
import {ZodSyncInformation} from "../../../modules_integrations/syncs/sync_types";
import {SyncHelper} from "../../../helpers/syncs/sync_helper";
import {SemurEngineEndpoint, SemurEngineErrorBuilder} from "../../../semur_engine/semur_engine";
import {NangoTriggerSyncRequest} from "../../../models.pb/semur-engine/nango-engine/nango_engine";
import {SyncMode} from "../../../models.pb/syncs/sync";
import Timestamp = firestore.Timestamp;
import {GeminiModelsConfig} from "../../agents/gemini_models_config";
import {logger} from "firebase-functions";
import {SyncFilter} from "../../../models.pb/semur-engine/syncs-engine/sync_engine";
import {
    UserSyncGoogleCalendarAccessor,
    UserSyncGoogleCalendarQueryKey,
} from "../../../accessors/users/syncs/user_sync_google_calendar_accessor";
import {privateSyncGoogleCalendarEventsFromNangoToFirestore} from "../../../modules_integrations/syncs/google-calendar_sync";
import {
    SyncGoogleCalendarEventsFromNangoToFirestoreRequest,
} from "../../../models.pb/semur-engine/syncs-engine/sync_engine_google-calendar";

export class GoogleCalendarTools {
    static initializeAllTools(
        ai: Genkit,
        nangoSecret: string,
        nangoIntegrationId: string,
        connectionId: string,
        session: ChatSession,
    ) {
        return [
            GoogleCalendarTools.googleCalendarSearchCommonFilters(
                ai,
                nangoSecret,
                nangoIntegrationId,
                connectionId,
                session,
            ).getTool(),
            GoogleCalendarTools.googleCalendarVectorSearch(
                ai,
                nangoSecret,
                nangoIntegrationId,
                connectionId,
                session,
            ).getTool(),
            GoogleCalendarTools.googleCalendarGetSyncInformation(
                ai,
                nangoSecret,
                nangoIntegrationId,
                connectionId,
                session,
            ).getTool(),
            GoogleCalendarTools.googleCalendarSync(
                ai,
                nangoSecret,
                nangoIntegrationId,
                connectionId,
                session,
            ).getTool(),
        ];
    }

    static googleCalendarSearchCommonFilters(
        ai: Genkit,
        nangoSecret: string,
        nangoIntegrationId: string,
        connectionId: string,
        session: ChatSession,
    ) {
        return new SemurEngineAiToolSDK(
            ai,
            {
                name: "google_calendar_search_common_filters",
                description: "Search for calendar events based on date/time range of start and end of the event. ",
                inputSchema: ZodGoogleCalendarEventsSearchSchema,
                outputSchema: z.object({
                    events: z.array(ZodGoogleCalendarEvent).describe("A list of calendar events records matching the search criteria."),
                    totalCount: z.number(),
                }),
            },
            async (input) => {
                try {
                    if (input.id) {
                        // If ID is provided, fetch that specific event
                        const event = await UserSyncGoogleCalendarAccessor.get(
                            session.userId,
                            nangoIntegrationId,
                            input.id,
                        );
                        if (!event) {
                            return {
                                events: [],
                                totalCount: 0,
                            };
                        }
                        return {
                            events: [{
                                id: event.id,
                                kind: event.kind,
                                status: event.status,
                                htmlLink: event.htmlLink,
                                created: event.created?.toISOString() || (new Date()).toISOString(),
                                updated: event.updated?.toISOString() || (new Date()).toISOString(),
                                summary: event.summary,
                                description: event.description,
                                location: event.location,
                                creator: event.creator,
                                organizer: event.organizer,
                                start: event.start?.toISOString() || (new Date()).toISOString(),
                                end: event.end?.toISOString() || (new Date()).toISOString(),
                                endTimeUnspecified: event.endTimeUnspecified,
                                recurrence: event.recurrence,
                                recurringEventId: event.recurringEventId,
                                attendees: event.attendees,
                            }],
                            totalCount: 1,
                        };
                    }

                    let startFromTimestamp = undefined;
                    let startToTimestamp = undefined;
                    let endFromTimestamp = undefined;
                    let endToTimestamp = undefined;
                    if (input.startFrom) {
                        startFromTimestamp = Timestamp.fromDate(new Date(input.startFrom));
                    }

                    if (input.startTo) {
                        startToTimestamp = Timestamp.fromDate(new Date(input.startTo));
                    }

                    if (input.endFrom) {
                        endFromTimestamp = Timestamp.fromDate(new Date(input.endFrom));
                    }

                    if (input.endTo) {
                        endToTimestamp = Timestamp.fromDate(new Date(input.endTo));
                    }

                    const syncGoogleCalendarEvents = await UserSyncGoogleCalendarAccessor.query(
                        UserSyncGoogleCalendarQueryKey.CommonFilters,
                        {
                            userId: session.userId,
                            nangoIntegrationId: nangoIntegrationId,
                            startFrom: startFromTimestamp,
                            startTo: startToTimestamp,
                            endFrom: endFromTimestamp,
                            endTo: endToTimestamp,
                            limit: input.limit ? input.limit : 50,
                        },
                    );


                    const unfilteredEvents = syncGoogleCalendarEvents.map((event) => ({
                        id: event.id,
                        kind: event.kind,
                        status: event.status,
                        htmlLink: event.htmlLink,
                        created: event.created?.toISOString() || (new Date()).toISOString(),
                        updated: event.updated?.toISOString() || (new Date()).toISOString(),
                        summary: event.summary,
                        description: event.description,
                        location: event.location,
                        creator: event.creator,
                        organizer: event.organizer,
                        start: event.start?.toISOString() || (new Date()).toISOString(),
                        end: event.end?.toISOString() || (new Date()).toISOString(),
                        endTimeUnspecified: event.endTimeUnspecified,
                        recurrence: event.recurrence,
                        recurringEventId: event.recurringEventId,
                        attendees: event.attendees,
                    }));


                    // Remove calendar events if token limit exceeded
                    let tokenAvailability = GeminiModelsConfig.freeContextTokenLimit;
                    const events = [];
                    for (const event of unfilteredEvents) {
                        tokenAvailability -= GeminiModelsConfig.countTokens(JSON.stringify(event));
                        if (tokenAvailability <= 0) {
                            break;
                        }
                        events.push(event);
                    }

                    return {
                        events: events,
                        totalCount: events.length,
                    };
                } catch (error) {
                    logger.error("Error in googleCalendarSearchCommonFilters tool:", error);
                    throw SemurEngineErrorBuilder.internalError("Failed to search calendar events");
                }
            },
            session,
            AgentTool.GOOGLE_CALENDAR_SEARCH_COMMON_FILTERS,
            () => {
                return {
                    events: [],
                    totalCount: 0,
                };
            },
        );
    }


    static googleCalendarVectorSearch(
        ai: Genkit,
        nangoSecret: string,
        nangoIntegrationId: string,
        connectionId: string,
        session: ChatSession,
    ) {
        return new SemurEngineAiToolSDK(
            ai,
            {
                name: "google_calendar_vector_search",
                description: "Search for calendar events using semantic/vector search based on content " +
                    "(description, summary, creator and organizer of the event) similarity",
                inputSchema: ZodGoogleCalendarVectorSearchSchema,
                outputSchema: z.object({
                    events: z.array(ZodGoogleCalendarEvent).describe("A list of calendar events records matching the search criteria."),
                    totalCount: z.number(),
                }),
            },
            async (input) => {
                const firestore = SemurEngineConfig.db;
                const retriever = defineFirestoreRetriever(ai, {
                    name: "googleCalendarVectorSearch",
                    firestore,
                    collection: `users/${session.userId}/nango_connections/${nangoIntegrationId}/syncs`,
                    contentField: "fullContent", // Field containing document content
                    vectorField: "embedding", // Field containing vector embeddings
                    embedder: googleAI.embedder("gemini-embedding-001", {outputDimensionality: 768}), // Embedder to generate embeddings
                    distanceMeasure: "COSINE", // Default is 'COSINE'; other options: 'EUCLIDEAN', 'DOT_PRODUCT'
                });
                const docs = await ai.retrieve({
                    retriever: retriever,
                    query: input.query,
                    options: {
                        limit: input.limit,
                    },
                });

                const events = docs.map((doc) => {
                    const data = doc.metadata as Record<string, unknown>;
                    return {
                        id: data.id,
                        kind: data.kind,
                        status: data.status,
                        htmlLink: data.htmlLink,
                        created: new Date((data.created as {
                            _seconds: number,
                            _nanoseconds: number
                        })._seconds * 1000).toISOString(),
                        updated: new Date((data.updated as {
                            _seconds: number,
                            _nanoseconds: number
                        })._seconds * 1000).toISOString(),
                        summary: data.summary,
                        description: data.description,
                        location: data.location,
                        creator: data.creator,
                        organizer: data.organizer,
                        start: new Date((data.start as {
                            _seconds: number,
                            _nanoseconds: number
                        })._seconds * 1000).toISOString(),
                        end: new Date((data.end as {
                            _seconds: number,
                            _nanoseconds: number
                        })._seconds * 1000).toISOString(),
                        endTimeUnspecified: data.endTimeUnspecified,
                        recurrence: data.recurrence,
                        recurringEventId: data.recurringEventId,
                        attendees: data.attendees,
                    };
                });

                return {
                    events: events,
                    totalCount: events.length,
                };
            },
            session,
            AgentTool.GOOGLE_MAIL_VECTOR_SEARCH,
            () => {
                return {
                    events: [],
                    totalCount: 0,
                };
            },
        );
    }

    static googleCalendarGetSyncInformation(
        ai: Genkit,
        nangoSecret: string,
        nangoIntegrationId: string,
        connectionId: string,
        session: ChatSession,
    ) {
        return new SemurEngineAiToolSDK(
            ai,
            {
                name: "google_calendar_get_sync_information",
                description: "Get information about the Google Calendar sync status, including last sync time and sync status.",
                outputSchema: ZodSyncInformation,
            },
            async (input) => {
                const syncInformation = await UserSyncGoogleCalendarAccessor.getSyncInfo(
                    session.userId,
                    nangoIntegrationId,
                );
                return {
                    integrationId: syncInformation.nangoIntegrationId,
                    updatedAt: syncInformation.updatedAt ? syncInformation.updatedAt.toISOString() : new Date(0).toISOString(),
                    status: SyncHelper.convertSyncStatusToString(syncInformation.status),
                    errorMessage: syncInformation.errorMessage,
                };
            },
            session,
            AgentTool.GOOGLE_CALENDAR_GET_SYNC_INFORMATION,
            () => {
                return {
                    // TODO: Magic value
                    integrationId: nangoIntegrationId,
                    updatedAt: new Date().toISOString(),
                    errorMessage: "unknown error",
                };
            },
        );
    }

    static googleCalendarSync(
        ai: Genkit,
        nangoSecret: string,
        nangoIntegrationId: string,
        connectionId: string,
        session: ChatSession,
    ) {
        return new SemurEngineAiToolSDK(
            ai,
            {
                name: "google_calendar_sync",
                description: "Trigger a sync for Google Calendar. " +
                    "This will start the synchronization process to fetch the latest calendar events from the connected Google Calendar account. " +
                    "To check the status of the process use google_calendar_get_sync_information tool",
                outputSchema: ZodSyncInformation.describe("Information about the sync status after running the sync."),
            },
            async (input) => {
                const syncGoogleCalendarEventsFromNangoToFirestoreRequest: SyncGoogleCalendarEventsFromNangoToFirestoreRequest = {
                    userId: session.userId,
                    integrationId: nangoIntegrationId,
                    limit: 100,
                    filter: [
                        SyncFilter.ADDED,
                        SyncFilter.UPDATED,
                        SyncFilter.DELETED,
                    ],
                };

                await privateSyncGoogleCalendarEventsFromNangoToFirestore(
                    syncGoogleCalendarEventsFromNangoToFirestoreRequest,
                    new SemurEngineEndpoint("google_calendar_sync_tool"),
                );

                const nangoTriggerSyncRequest: NangoTriggerSyncRequest = {
                    providerConfigKey: nangoIntegrationId,
                    syncs: [],
                    connectionId: connectionId,
                    syncMode: SyncMode.INCREMENTAL,
                    userId: session.userId,
                };
                await triggerNangoSync(nangoTriggerSyncRequest);

                const syncInformation = await UserSyncGoogleCalendarAccessor.getSyncInfo(
                    session.userId,
                    nangoIntegrationId,
                );
                return {
                    integrationId: syncInformation.nangoIntegrationId,
                    updatedAt: syncInformation.updatedAt ? syncInformation.updatedAt.toISOString() : new Date(0).toISOString(),
                    status: SyncHelper.convertSyncStatusToString(syncInformation.status),
                    errorMessage: syncInformation.errorMessage,
                };
            },
            session,
            AgentTool.GOOGLE_CALENDAR_SYNC,
            () => {
                return {
                    // TODO: Magic value
                    integrationId: nangoIntegrationId,
                    updatedAt: new Date().toISOString(),
                    errorMessage: "error",
                };
            },
        );
    }
}
