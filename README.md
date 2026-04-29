# Semur

Semur is a class project for an agentic AI executive assistant. The application focuses on executive email and calendar workflows: finding important messages, summarizing inbox context, checking schedule constraints, and helping draft professional responses.

The project is designed to demonstrate how multiple AI roles can collaborate on one business task. Semur separates the experience into an executive-facing chat UI, backend agent flows, integration tools, and shared data contracts so the system can coordinate email, calendar, and response-writing work.

## Project Goals

- Demonstrate an agentic AI application for a complex business workflow.
- Show how an executive assistant can combine email analysis, calendar context, and drafting support.
- Provide a runnable API and Flutter web interface for demonstration.
- Keep integration boundaries clear through Firebase Functions, Genkit, Nango, and shared protobuf models.

## Agent Collaboration Model

The chat API is exposed through `agent_email_assistant[-dev]-chat`, but Semur routes in-app chat requests through an explicit executive orchestrator. The orchestrator runs specialist agents sequentially so each step can persist safely to the chat session and so graders can see the collaboration trail.

- Executive Orchestrator: interprets the user's business request, calls specialists, and produces the final recommendation.
- Email Triage Agent: uses read-only Gmail or Outlook tools to find relevant messages, rank urgent items, and extract actions.
- Calendar Planning Agent: uses calendar tools to find conflicts and scheduling windows; it is marked skipped when no calendar connection is selected.
- Drafting Agent: prepares concise reply or follow-up drafts from the specialist reports. It has no send-email tools.

Each final Semur app response stores an `agentTrace` JSON artifact on the assistant chat message and the Flutter UI renders it as an "Agent Collaboration" timeline above related email artifacts.

Sample phase-two demo prompt:

```text
Review my inbox and calendar for tomorrow. Identify urgent emails, find scheduling conflicts, and draft responses for anything that needs action before noon.
```

## Demo Video

Watch the course demo video on YouTube: [Semur demo](https://youtu.be/YTf0QWPL8JI).

## Project Layout

- `client/semur`: Flutter web client for chat, integrations, and inbox views.
- `server/functions`: Firebase Functions backend with Genkit agent flows and Nango-backed tools.
- `server/firestore.rules` and `server/firestore.indexes.json`: Firestore security rules and index configuration for emulator and deploy workflows.
- `protos`: shared protobuf contracts used by the client and backend.
- `docs`: setup and runtime notes.
- `scripts`: repository-level helper scripts.

## Prerequisites

- Node.js 22 for Firebase Functions.
- npm for backend dependency installation.
- Firebase CLI for local emulators and deployment.
- Flutter SDK with Chrome support for the web client.
- Nango and Google AI credentials for live integration mode.

## Backend Setup

```bash
cd server/functions
npm install
```

For the reproducible course demo, start the local emulators:

```bash
cd server/functions
npm run serve:demo
```

In a second terminal, seed the emulator data:

```bash
cd server/functions
npm run seed:demo
```

The demo seed creates a local demo user, active demo Gmail and Google Calendar
connections, fixture email/calendar records, and minimal app configuration.
The deterministic demo endpoint does not require Nango, Gmail, Calendar, or
Google AI secrets.

For live integration mode, configure Firebase secrets:

```bash
cd server/functions
firebase functions:secrets:set NANGO_SECRET_KEY_DEV
firebase functions:secrets:set GOOGLE_GENAI_API_KEY
```

Runtime configuration details are documented in [docs/runtime-config.md](docs/runtime-config.md).

## Runtime And Secrets

- `NANGO_SECRET_KEY_DEV`: required for live Nango-backed Gmail, Outlook Mail, and Google Calendar integrations; not required for the deterministic `/demo` path.
- `GOOGLE_GENAI_API_KEY`: required for live AI-backed assistant responses outside the deterministic demo flow.
- `TELEGRAM_BOT_TOKEN`: optional; only needed when the Telegram integration and webhook setup are enabled.

`server/functions/.env.example` contains placeholder-only local values. Do not commit real OAuth client secrets, Firebase secret values, service account keys, Nango keys, or Google AI keys.

Firestore rules and indexes are tracked under `server/` and referenced by `server/firebase.json`. The rules allow public read-only app configuration, owner-only user data, owner-only Telegram integration records, and deny everything else by default.

For the full runtime configuration, emulator notes, and credential rotation checklist, see [docs/runtime-config.md](docs/runtime-config.md).

## Flutter Web Setup

```bash
cd client/semur
flutter pub get
flutter gen-l10n
flutter run -d chrome
```

For the local demo route backed by emulators:

```bash
cd client/semur
flutter run -d chrome --dart-define=USE_FIREBASE_EMULATORS=true
```

Open `/demo` in the launched web app and select `Run sample demo`. The expected
result is a deterministic executive response plus an "Agent Collaboration"
timeline showing Email Triage Agent, Calendar Planning Agent, and Drafting Agent.

For a production web build:

```bash
cd client/semur
flutter build web
```

## Verification Commands

Backend:

```bash
cd server/functions
npm run build
npm run lint
npm test
```

Flutter web:

```bash
cd client/semur
flutter test
flutter analyze
flutter build web
```

Security and configuration:

```bash
git ls-files | rg '(^|/)(\.env$|.*oauth.*\.json$|.*secret.*\.json$)|\.genkit'
SECRET_VALUE_PATTERN='client''_secret|private''_key|BEGIN'' PRIVATE KEY|NANGO_SECRET_KEY_DEV''=.+|GOOGLE_GENAI_API_KEY''=.+|TELEGRAM_BOT_TOKEN''=.+'
rg -n --hidden -g '!**/node_modules/**' -g '!**/build/**' -g '!**/.git/**' "$SECRET_VALUE_PATTERN"
```

## Limitations and Known Issues

- The graded demo path is web-first. Native Android, iOS, macOS, Linux, and Windows targets need fresh Firebase platform configuration before live deployment.
- The `/demo` route is fixture-backed and deterministic. It is designed for reproducible grading, not for showing live inbox or calendar state.
- Live Gmail, Outlook Mail, and Google Calendar integrations require external credentials, Firebase secrets, and Nango setup that are intentionally optional for the course demo path.
- The multi-agent Semur chat path produces review-only drafts. It does not auto-send email on the user's behalf.
- Live Gmail sending requires the assistant to show the recipients, subject, and body, then ask for explicit yes/no user confirmation before using the send-email tool.
- Previously exposed external credentials must be rotated by the project owner before public submission; repository checks can confirm absence from files, not provider-side revocation.

## Code Provenance

The application source in this repository was written for the Semur class project by the team members listed below. Generated protobuf files under `client/semur/lib/models.pb` and `server/functions/src/models.pb` come from the checked-in files under `protos/` and the repository generation scripts. Flutter, Firebase, Android, iOS, macOS, Linux, and Windows project files are standard platform scaffolding for this app. Font licenses are included under `client/semur/assets/fonts/`.

## Team Contributions

- Behruz Pulatov: executive orchestrator, backend email and calendar agent flows, backend tests, Firebase demo setup, and shared backend/runtime plumbing.
- Javokhir: Flutter web client, `/demo` route, agent-collaboration trace UI, grader-facing documentation, and runtime/demo UX.
