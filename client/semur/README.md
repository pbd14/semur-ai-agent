# Semur Flutter Client

This Flutter app provides the web interface for the Semur executive assistant class project. It includes chat, integration management, and inbox views used to demonstrate AI-assisted email and calendar workflows.

## Run Locally

```bash
flutter pub get
flutter gen-l10n
flutter run -d chrome
```

## Build For Web

```bash
flutter build web
```

## Main Areas

- `lib/modules/chat`: assistant chat interface and message artifacts.
- `lib/modules/integrations`: provider connection screens.
- `lib/modules/dashboard`: inbox and workspace views.
- `lib/semur_engine`: client-side Firebase Functions wrappers.
