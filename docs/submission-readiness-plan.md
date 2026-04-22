# Semur Submission Readiness Plan

Date assessed: 2026-04-20

## Verdict

Semur is not ready for final course submission yet.

The backend currently builds and lints, and the Flutter web app can produce a production build. However, the project does not yet clearly satisfy the course requirement for demonstrable multi-agent collaboration, the submitted GitHub repository would miss the Flutter client unless packaging is fixed, the test/analysis gates are not green, and the README does not yet include the required member contribution section.

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
- The root repository ignores `/client`, and `client/semur` is a nested Git repository. A root GitHub submission currently would not include the Flutter UI.
- `demo/web` only contains ignored build/dependency artifacts and no source files.
- The root README is untracked and contains machine-local absolute paths such as `/Users/behruz/Development/Semur/semur-code/...`.
- The client README is still the default Flutter starter README.
- There are no backend tests in the tracked server source tree.
- The only Flutter test is the default counter test and fails against the actual Semur app.
- The root working tree has many uncommitted changes, untracked files, and deleted tracked artifacts.
- A previously tracked OAuth secret file has been deleted locally, but that credential must still be rotated and removed from any public history before publishing.
- No Firestore rules or indexes are tracked under `server/`.

## Requirement Mapping

| Course requirement | Current status | Submission risk |
| --- | --- | --- |
| Agentic AI app solving a complex problem | Partially met. Semur targets executive email/calendar workflows. | Medium |
| Multiple agent collaboration | Not clearly met. Current code is mainly one assistant using tools. | High |
| Functional API or UI | Partially met. Backend builds, Flutter web builds, but live use depends on Firebase/Nango/Google secrets and OAuth setup. | High |
| Demonstrates role of multi-agent problem solving | Not yet met in UI/API. No visible delegation trace or specialist-agent output. | High |
| README with clear run instructions | Partially met. Root README exists locally but is untracked and uses local absolute paths. | High |
| Code comments | Partially met. Some comments exist, but architecture-level clarity is missing for grader review. | Medium |
| Specific coding contribution of each member | Missing. | High |
| GitHub source repository link | Not ready. Current root repo would omit the client and has dirty/untracked work. | High |

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

Root README should include:

- Project name and one-paragraph problem statement.
- Clear explanation of why executive email/calendar assistance needs multiple agents.
- Architecture section with orchestrator and specialist agents.
- Project layout.
- Prerequisites:
  - Node 22
  - Firebase CLI
  - Flutter SDK
  - Java/Chrome requirements if needed
- Setup instructions from fresh clone.
- Demo mode instructions that do not require private credentials.
- Optional live integration instructions for Nango, Gmail, Outlook, Google Calendar, and Google AI.
- Environment/secret list with descriptions, not secret values.
- Exact verification commands.
- Demo script with sample prompt and expected output.
- Limitations and known issues.
- Contribution section naming each student and what they built.

Use relative links instead of local absolute links. For example:

```md
[runtime config](docs/runtime-config.md)
[Flutter Firebase options](client/semur/lib/firebase_options.dart)
```

Contribution section template:

```md
## Team Contributions

- Student 1: Orchestrator flow, email specialist agent, backend tests, Firebase demo setup.
- Student 2: Calendar specialist agent, drafting agent, Flutter collaboration trace UI, README/demo documentation.
```

Replace the placeholders with the actual student names and real work performed.

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

Acceptance checks:

```bash
rg -n --hidden -g '!**/node_modules/**' -g '!**/build/**' -g '!**/.git/**' "client_secret|private_key|BEGIN PRIVATE KEY|NANGO_SECRET|GOOGLE_GENAI_API_KEY|password"
git ls-files | rg "oauth|secret|\\.genkit"
```

Expected outcome:

- No secret values are present in tracked files.
- Any secret names in docs are placeholders only.
- Previously exposed credentials are no longer valid.

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
