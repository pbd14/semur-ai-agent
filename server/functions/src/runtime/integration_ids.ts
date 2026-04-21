export const IntegrationIds = {
    googleMail: "google-mail",
    googleCalendar: "google-calendar",
    outlookMail: "outlook-mail",
} as const;

export type IntegrationId = typeof IntegrationIds[keyof typeof IntegrationIds];

export const SupportedDemoIntegrations: IntegrationId[] = [
    IntegrationIds.googleMail,
    IntegrationIds.googleCalendar,
    IntegrationIds.outlookMail,
];

export function isEmailIntegrationId(id: string): boolean {
    return id === IntegrationIds.googleMail || id === IntegrationIds.outlookMail;
}

export function isCalendarIntegrationId(id: string): boolean {
    return id === IntegrationIds.googleCalendar;
}

