// import {onRequest} from "firebase-functions/v2/https";
// import * as logger from "firebase-functions/logger";

// firebase emulators:start --only functions
// firebase deploy --only functions
// firebase functions:secrets:set

// TODO: Check appCheck
// https://firebase.google.com/docs/app-check/cloud-functions

// .env config
// require("dotenv").config();

import {initializeApp} from 'firebase-admin/app'

initializeApp();

import {SemurEngineConfig} from "./config";
import {setGlobalOptions} from "firebase-functions";

setGlobalOptions({maxInstances: 10});

SemurEngineConfig.db.settings({ignoreUndefinedProperties: true})

const registerLazyExport = (name: string, loader: () => unknown) => {
    Object.defineProperty(exports, name, {
        configurable: true,
        enumerable: true,
        get: loader,
    });
};

if (SemurEngineConfig.isDev) {
    // Agents
    // Email Assistant
    registerLazyExport(
        "agent_email_assistant_dev",
        () => require("./modules/agents/email_assistant/email_assistant"),
    );

    // Nango
    registerLazyExport(
        "nango_dev",
        () => require("./modules_integrations/nango"),
    );
    registerLazyExport(
        "nango_google_mail_dev",
        () => require("./modules_integrations/nango/google-mail"),
    );

    // Syncs
    registerLazyExport(
        "sync_google_mail_dev",
        () => require("./modules_integrations/syncs/google-mail_sync"),
    );
    registerLazyExport(
        "sync_google_calendar_dev",
        () => require("./modules_integrations/syncs/google-calendar_sync"),
    );
    registerLazyExport(
        "sync_outlook_mail_dev",
        () => require("./modules_integrations/syncs/outlook-mail_sync"),
    );
} else {
    // Agents
    // Email Assistant
    registerLazyExport(
        "agent_email_assistant",
        () => require("./modules/agents/email_assistant/email_assistant"),
    );

    // Nango
    registerLazyExport(
        "nango",
        () => require("./modules_integrations/nango"),
    );
    registerLazyExport(
        "nango_google_mail",
        () => require("./modules_integrations/nango/google-mail"),
    );

    // Syncs
    registerLazyExport(
        "sync_google_mail",
        () => require("./modules_integrations/syncs/google-mail_sync"),
    );
    registerLazyExport(
        "sync_google_calendar",
        () => require("./modules_integrations/syncs/google-calendar_sync"),
    );
    registerLazyExport(
        "sync_outlook_mail",
        () => require("./modules_integrations/syncs/outlook-mail_sync"),
    );
}
