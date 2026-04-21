# Semur

Semur is a class project for an agentic AI executive assistant. The application focuses on executive email and calendar workflows: finding important messages, summarizing inbox context, checking schedule constraints, and helping draft professional responses.

The project is designed to demonstrate how multiple AI roles can collaborate on one business task. Semur separates the experience into an executive-facing chat UI, backend agent flows, integration tools, and shared data contracts so the system can coordinate email, calendar, and response-writing work.

## Project Goals

- Demonstrate an agentic AI application for a complex business workflow.
- Show how an executive assistant can combine email analysis, calendar context, and drafting support.
- Provide a runnable API and Flutter web interface for demonstration.
- Keep integration boundaries clear through Firebase Functions, Genkit, Nango, and shared protobuf models.

## Agent Collaboration Model

Semur is organized around these AI collaboration roles:

- Executive Orchestrator: interprets the user's business request and decides which specialist capabilities are needed.
- Email Specialist: searches and summarizes Gmail or Outlook messages, identifies urgent items, and extracts action items.
- Calendar Specialist: checks calendar context and scheduling constraints.
- Drafting Assistant: prepares concise professional replies and follow-up messages from the combined context.

The implementation includes the core email assistant flow, chat helper flows, email/calendar tools, and integration plumbing needed for the class demonstration.

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
firebase functions:secrets:set NANGO_SECRET_KEY_DEV
firebase functions:secrets:set GOOGLE_GENAI_API_KEY
npm run serve:demo
```

Runtime configuration details are documented in [docs/runtime-config.md](docs/runtime-config.md).

## Flutter Web Setup

```bash
cd client/semur
flutter pub get
flutter gen-l10n
flutter run -d chrome
```

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
```

Flutter web:

```bash
cd client/semur
flutter build web
```

## Team Contributions

- Backend and AI agent engineering: Firebase Functions, Genkit flows, email/calendar tools, Nango integration, and shared protobuf contracts.
- Client and product experience: Flutter web app, chat interface, integration screens, inbox UI, runtime documentation, and demo setup.
