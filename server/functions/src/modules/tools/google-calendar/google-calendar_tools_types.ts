import {z} from "genkit";

// Related to SyncGoogleCalendarEvent proto
export const ZodGoogleCalendarEvent = z.object({
    id: z.string().describe("The unique identifier of the calendar event."),
    kind: z.string().describe("The kind of resource this is."),
    // etag: z.string().describe("ETag of the resource."),
    status: z.string().describe("The status of the event."),
    htmlLink: z.string().url().describe("A link to the event in the Google Calendar web UI."),
    created: z.string().describe("The creation time of the event in ISO format."),
    updated: z.string().describe("The last modification time of the event in ISO format."),
    summary: z.string().describe("The title or summary of the event."),
    description: z.string().optional().describe("A detailed description of the event."),
    location: z.string().optional().describe("The location of the event."),
    creator: z.object({
        email: z.string().email().optional().describe("The email address of the event creator."),
        displayName: z.string().optional().describe("The display name of the event creator."),
        self: z.boolean().optional().describe("Whether the creator corresponds to the calendar owner."),
    }).optional().describe("Information about the event creator."),
    organizer: z.object({
        email: z.string().email().optional().describe("The email address of the event organizer."),
        displayName: z.string().optional().describe("The display name of the event organizer."),
        self: z.boolean().optional().describe("Whether the organizer corresponds to the calendar owner."),
    }).optional().describe("Information about the event organizer."),
    start: z.string().describe("The start time of the event in ISO format."),
    end: z.string().describe("The end time of the event in ISO format."),
    endTimeUnspecified: z.boolean().optional().describe("Whether the end time is unspecified."),
    recurrence: z.array(z.string()).optional().describe("Recurrence rules for the event, if any."),
    recurringEventId: z.string().optional().describe("The ID of the recurring event series, if applicable."),
    attendees: z.array(z.object({
        email: z.string().email().describe("The email address of the attendee."),
        displayName: z.string().optional().describe("The display name of the attendee."),
        organizer: z.boolean().optional().describe("Whether the attendee is the organizer."),
        self: z.boolean().optional().describe("Whether the attendee corresponds to the calendar owner."),
        responseStatus: z.string().describe("The response status of the attendee (e.g., accepted, declined)."),
        optional: z.boolean().optional().describe("Whether the attendee is marked as optional."),
    })).optional().describe("List of attendees for the event."),
    // attendeesOmitted: z.boolean().optional().describe("Whether the attendee list is omitted."),
    // hangoutLink: z.string().url().optional().describe("A link to the Google Meet hangout for the event, if any."),
}).describe("Schema representing a Google Calendar Event.");

export const ZodGoogleCalendarEventsSearchSchema = z.object({
    id: z.string().optional().describe("Event ID to match exactly. If this is provided, other filters are ignored"),
    startFrom: z.string().optional().describe("Filter to find events with start time after given startFrom " +
        "in ISO format (e.g., \"2025-09-15T05:41:14.000Z\")"),
    startTo: z.string().optional().describe("Filter to find events with start time before given startTo " +
        "in ISO format (e.g., \"2025-09-15T05:41:14.000Z\")"),
    endFrom: z.string().optional().describe("Filter to find events with end time after given endFrom " +
        "in ISO format (e.g., \"2025-09-15T05:41:14.000Z\")"),
    endTo: z.string().optional().describe("Filer to find events with end time before given endTo in ISO format (e.g., \"2025-09-15T05:41:14.000Z\")"),
    limit: z.number().max(50).optional().default(50).describe("Maximum number of results to return (default: 50, max: 50)"),
}).describe("Schema for searching Google Calendar events. All fields are optional.");


export const ZodGoogleCalendarVectorSearchSchema = z.object({
    query: z.string().describe("Natural language search query to find relevant calendar events"),
    limit: z.number().optional().default(50).describe("Maximum number of events to return (default: 50)"),
});
