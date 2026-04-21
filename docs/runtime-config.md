# Runtime Configuration

This document lists the runtime configuration needed to run Semur locally or in Firebase.

## Backend Secrets

Firebase Functions reads secrets through `server/functions/src/runtime/runtime_config.ts`.

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

## Flutter Firebase Config

The Flutter web client uses the checked-in Firebase configuration at [client/semur/lib/firebase_options.dart](../client/semur/lib/firebase_options.dart).

Current platform support:

- Web is configured for the class demo.
- Native Android, iOS, macOS, Linux, and Windows targets require fresh Firebase platform configuration before live deployment.

To configure native targets, run `flutterfire configure` inside `client/semur` and add the generated platform files through the intended deployment workflow.

## Credential Safety

Do not commit local OAuth client secrets, service account keys, `.env` files, or Firebase secret values. Keep only secret names and setup instructions in repository documentation.
