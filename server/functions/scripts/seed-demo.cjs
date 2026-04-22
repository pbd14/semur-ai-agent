#!/usr/bin/env node

process.env.FIRESTORE_EMULATOR_HOST = process.env.FIRESTORE_EMULATOR_HOST || "127.0.0.1:8080";
process.env.FIREBASE_AUTH_EMULATOR_HOST = process.env.FIREBASE_AUTH_EMULATOR_HOST || "127.0.0.1:9099";

const admin = require("firebase-admin");
const {
    DEMO_USER_ID,
    demoCalendarEvents,
    demoEmails,
    demoSeedData,
} = require("../lib/modules/agents/email_assistant/demo/demo_fixtures");
const {IntegrationIds} = require("../lib/runtime/integration_ids");

const projectId = process.env.GCLOUD_PROJECT || process.env.FIREBASE_PROJECT_ID || "semur-ai";

admin.initializeApp({projectId});

const db = admin.firestore();

async function ensureDemoAuthUser() {
    try {
        await admin.auth().getUser(DEMO_USER_ID);
    } catch (error) {
        if (error.code !== "auth/user-not-found") {
            throw error;
        }
        await admin.auth().createUser({
            uid: DEMO_USER_ID,
            email: demoSeedData.user.email,
            emailVerified: true,
            password: "SemurDemo123!",
            displayName: "Demo Executive",
        });
    }
}

async function seedFirestore() {
    const batch = db.batch();
    const userRef = db.collection("users").doc(DEMO_USER_ID);

    batch.set(userRef, demoSeedData.user);
    batch.set(db.collection("app_data").doc("semur_vars"), demoSeedData.appData);

    for (const integration of demoSeedData.integrations) {
        batch.set(
            db.collection("app_data").doc("nango").collection("available_integrations").doc(integration.id),
            integration,
        );
    }

    for (const connection of demoSeedData.connections) {
        batch.set(
            db.collection("nango_connection_id_to_user_id_mapping").doc(connection.connectionId),
            {
                connectionId: connection.connectionId,
                integrationId: connection.id,
                userId: DEMO_USER_ID,
            },
        );
        batch.set(userRef.collection("nango_connections").doc(connection.id), connection);
        batch.set(
            userRef.collection("nango_connections").doc(connection.id).collection("syncs").doc("sync"),
            {
                ...demoSeedData.syncInfo,
                nangoIntegrationId: connection.id,
            },
        );
    }

    for (const email of demoEmails) {
        batch.set(
            userRef.collection("nango_connections").doc(IntegrationIds.googleMail).collection("syncs").doc(email.id),
            {
                id: email.id,
                sender: `${email.sender} <${email.senderEmail}>`,
                recipients: email.recipients,
                date: new Date(email.date),
                subject: email.subject,
                body: email.body,
                fullContent: email.body,
                attachments: [],
                threadId: email.threadId,
            },
        );
    }

    for (const event of demoCalendarEvents) {
        batch.set(
            userRef.collection("nango_connections").doc(IntegrationIds.googleCalendar).collection("syncs").doc(event.id),
            {
                id: event.id,
                kind: "calendar#event",
                status: "confirmed",
                htmlLink: "https://calendar.google.com/",
                created: new Date("2026-04-22T12:00:00.000Z"),
                updated: new Date("2026-04-22T12:00:00.000Z"),
                summary: event.summary,
                description: event.description,
                fullContent: `${event.summary}\n${event.description}`,
                start: new Date(event.start),
                end: new Date(event.end),
                attendees: event.attendees.map((email) => ({email, responseStatus: "accepted"})),
            },
        );
    }

    await batch.commit();
}

async function main() {
    await ensureDemoAuthUser();
    await seedFirestore();
    console.log(`Seeded Semur demo data for ${DEMO_USER_ID} in project ${projectId}.`);
    console.log("Demo email: demo@semur.example");
    console.log("Demo password: SemurDemo123!");
}

main().catch((error) => {
    console.error("Failed to seed Semur demo data.", error);
    process.exitCode = 1;
});
