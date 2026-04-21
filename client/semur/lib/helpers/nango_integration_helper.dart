import 'package:semur/config/application.dart';

class NangoIntegrationHelper {
  static String getIntegrationImage(String integrationId) {
    switch (integrationId) {
      case 'google-mail':
        return 'assets/icons/gmail.png';
      case 'google-calendar':
        return 'assets/icons/google-calendar.png';
      case 'outlook-mail':
        return 'assets/icons/outlook.png';
      default:
        return 'assets/icons/Logo512.png';
    }
  }

  static String getIntegrationDescription(String integrationId) {
    switch (integrationId) {
      case 'google-mail':
        return Application.appLocalizations!.integrationGmailDescription;
      case 'google-calendar':
        return Application
            .appLocalizations!
            .integrationGoogleCalendarDescription;
      case 'outlook-mail':
        return Application.appLocalizations!.integrationGmailDescription;
      default:
        return 'Default Integration';
    }
  }

  static String getConnectionProviderName(String provider) {
    switch (provider) {
      case 'google-mail':
        return 'Gmail';
      case 'google-calendar':
        return 'Google Calendar';
      case 'outlook-mail':
        return 'Outlook Mail';
      default:
        return provider
            .split('-')
            .map(
              (word) =>
                  word.isNotEmpty
                      ? word[0].toUpperCase() + word.substring(1)
                      : '',
            )
            .join(' ');
    }
  }
}
