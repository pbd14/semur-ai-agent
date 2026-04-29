# Semur Submission Readiness Plan

Date assessed: 2026-04-20

## Verdict

Semur is not ready for final course submission yet.

The backend currently builds and lints, and the Flutter web app can produce a production build. However, the project still needs the final test/analysis story, security cleanup, and a polished grader-facing submission pass before it is ready for final course submission.

The project is in a recoverable state. The shortest path to submission is to turn the existing email/calendar assistant into an explicit multi-agent demo, make the runnable UI/API reproducible for graders, clean the repository, and update the documentation.

## Current Evidence

Commands run during this assessment:

| Area | Command | Result |
| --- | --- | --- |
| Backend build | `cd server/functions && npm run build` | Pass |
| Backend lint | `cd server/functions && npm run lint` | Pass |
| Flutter web build | `cd client/semur && flutter build web` | Pass |
| Flutter tests | `cd client/semur && flutter test` | Fail |
| Flutter analyze | `cd client/semur && flutter analyze` | Fail, 84 info-level issues |

Notable findings:

- The backend exports one main assistant surface: `agent_email_assistant` / `agent_email_assistant_dev`.
- The current assistant has Gmail, Outlook Mail, and Google Calendar tools, plus helper flows for chat naming and follow-up question generation.
- The current backend does not expose an explicit orchestrator that delegates work between separate specialist agents.
- The root repository now tracks `client/semur`, `README.md`, and `docs/` in the same submission repo, so the Flutter UI and grader-facing docs are included together.
- `demo/web` only contains ignored build/dependency artifacts and no source files.
- The root README and client README are tracked and now document the reproducible demo path with repository-relative links.
- Backend tests now exist in the tracked server source tree for the executive orchestrator and deterministic demo flow.
- Flutter widget tests now cover Semur-specific chat and demo surfaces instead of the default counter app.
- The root working tree has many uncommitted changes, untracked files, and deleted tracked artifacts.
- A previously tracked OAuth secret file has been deleted locally, but that credential must still be rotated and removed from any public history before publishing.
- Firestore rules and indexes are now tracked under `server/` for the Firebase deploy/emulator workflow.

## Requirement Mapping

| Course requirement | Current status | Submission risk |
| --- | --- | --- |
| Agentic AI app solving a complex problem | Partially met. Semur targets executive email/calendar workflows. | Medium |
| Multiple agent collaboration | Not clearly met. Current code is mainly one assistant using tools. | High |
| Functional API or UI | Partially met. Backend builds, Flutter web builds, but live use depends on Firebase/Nango/Google secrets and OAuth setup. | High |
| Demonstrates role of multi-agent problem solving | Not yet met in UI/API. No visible delegation trace or specialist-agent output. | High |
| README with clear run instructions | Partially met. Root README is tracked, uses relative links, and documents the demo flow, but the final grader-facing sections still need to stay aligned with the submission gates. | Medium |
| Code comments | Partially met. Some comments exist, but architecture-level clarity is missing for grader review. | Medium |
| Specific coding contribution of each member | Met in the README after the named team contribution section was added. | Low |
| GitHub source repository link | Partially met. The client source is tracked in the root repository, but the final submission still depends on a clean, accessible repo state. | Medium |

## Priority Plan

### 1. Fix Repository Packaging

Goal: make the GitHub repository contain the exact source code graders need.

Actions:

- Decide whether Semur will be submitted as one monorepo or as two linked repositories.
- Recommended: make it a monorepo for grading simplicity.
- If using a monorepo, stop ignoring `/client` in the root `.gitignore` and move or import `client/semur` into the root repository history.
- If keeping the nested client repo, add it as a real Git submodule and document the submodule clone command.
- Commit the root `README.md`, `docs/`, runtime helpers, Nango integration files, and all intended source changes.
- Commit deletions for generated `.genkit` traces and the removed OAuth secret file.
- Keep generated build outputs, `node_modules`, `.dart_tool`, and Flutter `build/` directories ignored.
- Remove or rebuild `demo/web`; do not submit a directory that only contains ignored output and dependencies.

Acceptance checks:

```bash
git status --short
git ls-files client/semur | head
git ls-files README.md docs/submission-readiness-plan.md
```

Expected outcome:

- `git status --short` is clean before submission.
- The source for the UI or chosen demo is tracked.
- The README and docs are tracked.

### 2. Implement an Explicit Multi-Agent Demonstration

Goal: satisfy the highest-risk course requirement.

Recommended architecture:

- Add an `executive_orchestrator` flow.
- Add or separate specialist agents:
  - `email_triage_agent`: searches inbox, ranks important messages, extracts actions.
  - `calendar_planning_agent`: searches calendar, identifies conflicts, proposes time windows.
  - `drafting_agent`: drafts replies or meeting follow-ups using email/calendar context.
  - Optional `decision_agent`: summarizes tradeoffs and produces the final executive recommendation.
- The orchestrator should call specialist agents in sequence or parallel, then combine their outputs into one final response.
- Persist an `agentTrace` or similar artifact in the chat session showing which agents ran, why they were selected, what they returned, and how the final answer used their results.
- Surface that trace in the UI as a visible "Agent Collaboration" section or timeline.

Example demo prompt:

```text
Review my inbox and calendar for tomorrow. Identify urgent emails, find scheduling conflicts, and draft responses for anything that needs action before noon.
```

Expected visible behavior:

- Orchestrator receives the request.
- Email agent reviews email data.
- Calendar agent reviews event data.
- Drafting agent prepares suggested replies.
- Final response explains the combined recommendation.
- UI/API response includes a machine-readable or visible trace of agent collaboration.

Acceptance checks:

- A grader can run one prompt and see at least two specialist agents contribute.
- The README explains the agents and their collaboration roles.
- The code has clear module boundaries for orchestrator and specialists.

### 3. Add a Reproducible Demo Mode

Goal: make the app demonstrable without requiring the grader to connect a real Gmail account.

Actions:

- Add seeded demo data for emails and calendar events.
- Add a local emulator seed script, for example `npm run seed:demo`.
- Add a demo user and demo connection IDs that work with the emulator.
- Add a mock/demo integration mode so the multi-agent flow can use fixture data when Nango secrets are unavailable.
- Document one happy-path demo from fresh clone to visible result.

Recommended demo paths:

- Minimal API demo: callable function or HTTP endpoint that runs the orchestrator against fixtures.
- UI demo: Flutter web route that signs into or selects a demo user and opens a preloaded executive assistant chat.

Acceptance checks:

```bash
cd server/functions
npm run build
npm run lint
npm run seed:demo
npm run serve:demo
```

Then from the client:

```bash
cd client/semur
flutter run -d chrome
```

Expected outcome:

- The demo can run locally with documented setup.
- External secrets are optional for the course demo path.

Implementation update on 2026-04-22:

- Added deterministic backend demo fixtures and a no-secret `demoChat` callable under the email assistant module.
- Added `npm run seed:demo` to seed emulator Auth/Firestore with a demo user, demo Gmail/Calendar connections, fixture emails, fixture calendar events, and app data.
- Added a standalone Flutter `/demo` route that calls the demo endpoint and renders the existing "Agent Collaboration" trace without sign-in or integration selection.
- Added `--dart-define=USE_FIREBASE_EMULATORS=true` client support for local Auth, Firestore, and Functions emulators.
- Updated the root README and runtime config docs with the fresh-clone demo commands and expected visible result.

### 4. Fix Test And Analysis Gates

Goal: avoid submitting a project with visibly broken quality checks.

Backend actions:

- Add a test script to `server/functions/package.json`.
- Add tests for orchestrator routing decisions.
- Mock specialist agents and verify aggregation behavior.
- Add tests for no-connection and demo-fixture cases.
- Add tests for "ask confirmation before sending email" behavior if send tools remain available.

Flutter actions:

- Replace `client/semur/test/widget_test.dart`; the current counter test is not relevant and fails.
- Add a smoke test that renders the Semur app shell or the demo chat screen.
- Decide whether `flutter analyze` must be zero-issue or whether the project will run with adjusted lint severity. For submission, zero analyzer issues is preferable.
- Fix high-signal analyzer items first:
  - Missing direct dependencies such as `flutter_web_plugins`, `fixnum`, and `web`.
  - `use_build_context_synchronously`.
  - Production `print` calls.
  - Unnecessary imports.
  - Deprecated `withOpacity` usage.

Acceptance checks:

```bash
cd server/functions
npm run build
npm run lint
npm test

cd client/semur
flutter test
flutter analyze
flutter build web
```

Expected outcome:

- All documented checks pass.
- Any intentionally skipped checks are explained in README with a reason.

### 5. Rewrite README For Grading

Goal: make the repository understandable and runnable by a fresh grader.

Status on 2026-04-28:

- [README.md](../README.md) already covers the project overview, multi-agent architecture, project layout, backend setup, reproducible demo flow, relative links, and the sample grader demo prompt.
- The README verification commands remain aligned with the current backend scripts: `npm run build`, `npm run lint`, and `npm test`.

Implementation update on 2026-04-28:

- The root README now documents the reproducible demo path with `npm run serve:demo`, `npm run seed:demo`, and `flutter run -d chrome --dart-define=USE_FIREBASE_EMULATORS=true`.
- The root README explains the `/demo` flow and points graders to the visible "Agent Collaboration" timeline that renders the orchestrator `agentTrace` output in the Flutter UI.
- The root README now includes a compact runtime/secrets section for `NANGO_SECRET_KEY_DEV`, `GOOGLE_GENAI_API_KEY`, and optional `TELEGRAM_BOT_TOKEN`, with a link to [docs/runtime-config.md](./runtime-config.md).
- The root README now includes a "Limitations and Known Issues" section covering the web-first demo scope, fixture-backed `/demo`, live integration prerequisites, and review-only drafts.
- The root README now names team ownership explicitly:
  - Behruz Pulatov: executive orchestrator, backend email and calendar agent flows, backend tests, Firebase demo setup.
  - Javokhir: Flutter web client, `/demo` route, agent-collaboration trace UI, grader-facing documentation, and runtime/demo UX.

Remaining work before phase 5 is fully closed:

- Verify `flutter analyze` from a machine with Flutter available on `PATH` and keep the README verification block aligned with the final submission gate.
- Confirm the contribution wording still matches the final division of work if responsibilities change before submission.

Acceptance checks:

```bash
rg -n '^## ' README.md
rg -n 'flutter analyze|Behruz Pulatov|Javokhir|NANGO_SECRET_KEY_DEV|GOOGLE_GENAI_API_KEY|TELEGRAM_BOT_TOKEN|Limitations|Known Issues' README.md
rg -n 'Student 1|Student 2|placeholder|root README is untracked|miss the Flutter client|no backend tests|default counter test' README.md docs/submission-readiness-plan.md
```

Expected outcome:

- The root README is a grader-facing entrypoint instead of a local-development placeholder.
- The README documents both the no-secret demo path and the live-integration secret names without exposing secret values.
- The README names each team member's contribution explicitly.

### 6. Clean Security And Configuration

Goal: avoid publishing credentials or local-only setup.

Actions:

- Rotate the previously tracked Google OAuth credential.
- Rotate any Nango or Google AI secrets that may have been exposed during development.
- Confirm no secret files are tracked.
- Add `.env.example` or documented Firebase secret commands with placeholder values only.
- Remove `.genkit` traces from Git history if the repository will be public and those traces contain private data.
- Add Firestore rules and indexes if the app depends on Firestore collections.
- Document that live email sending requires user confirmation.

Implementation update on 2026-04-29:

- Added tracked Firestore rules and indexes under `server/` and wired them through `server/firebase.json`.
- Added placeholder-only `server/functions/.env.example` for local emulator/runtime names without committed secret values.
- Removed the client-side password-reset lookup that queried `users` by email, so Firestore rules do not need a public email-count path.
- Documented the security scan commands, Firestore config, placeholder env guidance, and live Gmail send-confirmation requirement in the grader-facing docs.
- Repo-side Phase 6 cleanup is complete, but provider-side rotation of any previously exposed Google OAuth, Nango, Google AI, or Telegram credential remains a manual owner task before public submission.

Acceptance checks:

```bash
git ls-files | rg '(^|/)(\.env$|.*oauth.*\.json$|.*secret.*\.json$)|\.genkit'
SECRET_VALUE_PATTERN='client''_secret|private''_key|BEGIN'' PRIVATE KEY|NANGO_SECRET_KEY_DEV''=.+|GOOGLE_GENAI_API_KEY''=.+|TELEGRAM_BOT_TOKEN''=.+'
rg -n --hidden -g '!**/node_modules/**' -g '!**/build/**' -g '!**/.git/**' "$SECRET_VALUE_PATTERN"
```

Expected outcome:

- No secret values are present in tracked files.
- Any secret names in docs are placeholders only.
- Previously exposed credentials are rotated and no longer valid before public submission.

### 7. Add A Simple CI Workflow

Goal: show the GitHub repository tracks working progress and prevent last-minute regressions.

Actions:

- Add GitHub Actions workflow for backend build/lint/test.
- Add Flutter test/analyze/build workflow if the client is included in the root repo.
- Keep workflow commands aligned with README.

Acceptance checks:

- Pull request or main branch shows green checks.
- README badges are optional, not required.

### 8. Final Submission Checklist

Before submitting the GitHub link to Canvas:

- Multi-agent orchestrator implemented.
- At least two specialist agents visibly collaborate in the demo.
- Demo mode works from fresh clone.
- Backend build/lint/test pass.
- Flutter test/analyze/build pass, or documented exceptions are intentional and defensible.
- README uses relative paths and contains clear setup instructions.
- README contains actual team member contribution details.
- Client source is included in the submitted repository or linked as a submodule/repository.
- Working tree is clean.
- Sensitive files and generated traces are removed from tracking.
- Previously exposed credentials are rotated.
- GitHub repository is public or otherwise accessible to the grader.
- Canvas submission contains the repository link, not source files.

## Suggested Work Order

1. Repository packaging and README cleanup.
2. Multi-agent orchestrator and specialist-agent implementation.
3. Demo fixture mode and UI/API trace display.
4. Tests and analyzer fixes.
5. Security cleanup and credential rotation.
6. CI and final GitHub submission.

This order reduces grading risk first: the biggest blockers are the missing explicit multi-agent demonstration, incomplete submission packaging, and insufficient grader-facing documentation.
