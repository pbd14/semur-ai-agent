# Runtime Configuration

This document lists the runtime configuration needed to run Semur locally or in Firebase.

## Backend Secrets

Firebase Functions reads secrets through `server/functions/src/runtime/runtime_config.ts`.

The reproducible local demo path does not require backend secrets. It uses the
no-secret `agent_email_assistant[-dev]-demoChat` callable and deterministic
fixtures under `server/functions/src/modules/agents/email_assistant/demo/`.

### Required

- `NANGO_SECRET_KEY_DEV`
  - Used for Nango session tokens, sync triggering, record listing, Gmail send actions, and webhook verification.
  - The `_DEV` suffix is part of the current project environment naming.
- `GOOGLE_GENAI_API_KEY`
  - Used by Genkit Google AI models for assistant and helper flows.

### Optional

- `TELEGRAM_BOT_TOKEN`
  - Needed only when Telegram integration is enabled.

## Firebase CLI Setup

```bash
cd server/functions
firebase functions:secrets:set NANGO_SECRET_KEY_DEV
firebase functions:secrets:set GOOGLE_GENAI_API_KEY
```

## Local Env Example

[server/functions/.env.example](../server/functions/.env.example) is a placeholder-only reference for local development and emulator defaults. Keep values empty in the tracked file. For hosted Functions, use Firebase secrets instead of `.env` files.

## Firestore Configuration

Firestore rules and indexes are tracked at:

- [server/firestore.rules](../server/firestore.rules)
- [server/firestore.indexes.json](../server/firestore.indexes.json)

The rules allow public read-only `app_data`, owner-only reads and writes under each user's document, owner-only Telegram integration records, restricted account-deletion archive creates, and deny all other client access. Firebase Admin SDK code in Functions bypasses these client rules.

## Flutter Firebase Config

The Flutter web client uses the checked-in Firebase configuration at [client/semur/lib/firebase_options.dart](../client/semur/lib/firebase_options.dart).

For local emulator-backed demos, run the client with:

```bash
flutter run -d chrome --dart-define=USE_FIREBASE_EMULATORS=true
```

This connects the web client to local Auth, Firestore, and Functions emulators
on `localhost` using the default ports `9099`, `8080`, and `5001`. Override the
host when needed:

```bash
flutter run -d chrome \
  --dart-define=USE_FIREBASE_EMULATORS=true \
  --dart-define=FIREBASE_EMULATOR_HOST=127.0.0.1
```

Current platform support:

- Web is configured for the class demo.
- Native Android, iOS, macOS, Linux, and Windows targets require fresh Firebase platform configuration before live deployment.

To configure native targets, run `flutterfire configure` inside `client/semur` and add the generated platform files through the intended deployment workflow.

## Credential Safety

Do not commit local OAuth client secrets, service account keys, `.env` files, or Firebase secret values. Keep only secret names and setup instructions in repository documentation.

Before public submission, rotate any Google OAuth client secret, Nango secret, Google AI key, and Telegram bot token that may have been exposed during development. Repository scans can prove current files do not contain secret values; they cannot prove provider-side rotation.

Live Gmail sending is confirmation-gated. The assistant prompt requires recipients, subject, and body to be shown to the user and a yes/no confirmation to be received before the Gmail send tool is used. The deterministic `/demo` and multi-agent drafting path produce review-only drafts.
