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

## Project Layout

- `client/semur`: Flutter web client for chat, integrations, and inbox views.
- `server/functions`: Firebase Functions backend with Genkit agent flows and Nango-backed tools.
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
flutter build web
```

## Team Contributions

- Backend and AI agent engineering: Firebase Functions, Genkit flows, email/calendar tools, Nango integration, and shared protobuf contracts.
- Client and product experience: Flutter web app, chat interface, integration screens, inbox UI, runtime documentation, and demo setup.
