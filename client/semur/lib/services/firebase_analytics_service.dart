import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsService {
  final FirebaseAnalytics analytics;
  final bool isDevMode;

  FirebaseAnalyticsService({required this.analytics, required this.isDevMode});

  Future<void> logEvent(
    FirebaseAnalyticsEvent event, {
    Map<String, Object>? parameters,
  }) async {
    if (isDevMode) {
      print('Logging event: ${getFirebaseAnalyticsEventName(event)}');
      print('Event parameters: $parameters');
      return;
    }

    try {
      await FirebaseAnalytics.instance.logEvent(
        name: getFirebaseAnalyticsEventName(event),
        parameters: parameters,
      );
    } catch (e) {
      print('Error logging event: $e');
    }
  }
}

String getFirebaseAnalyticsEventName(FirebaseAnalyticsEvent event) {
  switch (event) {
    case FirebaseAnalyticsEvent.openScreen:
      return 'open_screen';
    case FirebaseAnalyticsEvent.openInGuestMode:
      return 'open_in_guest_mode';
    case FirebaseAnalyticsEvent.userBlocked:
      return 'user_blocked';

    case FirebaseAnalyticsEvent.authEmailSignIn:
      return 'auth_email_sign_in';
    case FirebaseAnalyticsEvent.authEmailSignUpSendVerification:
      return 'auth_email_sign_up_send_verification';
    case FirebaseAnalyticsEvent.authGoogleSignIn:
      return 'auth_google_sign_in';
    case FirebaseAnalyticsEvent.authAppleSignIn:
      return 'auth_apple_sign_in';
    case FirebaseAnalyticsEvent.authDeleteAccount:
      return 'auth_delete_account';
    case FirebaseAnalyticsEvent.authSignOut:
      return 'auth_sign_out';

    // Errors
    case FirebaseAnalyticsEvent.errorAuthEmailSignIn:
      return 'error_auth_email_sign_in';
    case FirebaseAnalyticsEvent.errorAuthEmailSignUp:
      return 'error_auth_email_sign_up';
    case FirebaseAnalyticsEvent.errorAuthEmailVerify:
      return 'error_auth_email_verify';
    case FirebaseAnalyticsEvent.errorAuthEmailChangePassword:
      return 'error_auth_email_change_password';
    case FirebaseAnalyticsEvent.errorAuthGoogleSignIn:
      return 'error_auth_google_sign_in';
    case FirebaseAnalyticsEvent.errorAuthAppleSignIn:
      return 'error_auth_apple_sign_in';
    case FirebaseAnalyticsEvent.errorRemoteConfigInit:
      return 'error_remote_config_init';
    case FirebaseAnalyticsEvent.errorUserLoad:
      return 'error_user_load';
    case FirebaseAnalyticsEvent.errorUserUnknown:
      return 'error_user_unknown';
    case FirebaseAnalyticsEvent.errorUserStatusCheck:
      return 'error_user_status_check';
    case FirebaseAnalyticsEvent.errorUserEdit:
      return 'error_user_edit';
    case FirebaseAnalyticsEvent.errorBloc:
      return 'error_bloc';
  }
}

enum FirebaseAnalyticsEvent {
  openScreen,
  openInGuestMode,
  userBlocked,

  // Auth
  authEmailSignIn,
  authEmailSignUpSendVerification,
  authGoogleSignIn,
  authAppleSignIn,
  authDeleteAccount,
  authSignOut,

  // Errors
  errorAuthEmailSignIn,
  errorAuthEmailSignUp,
  errorAuthEmailVerify,
  errorAuthEmailChangePassword,
  errorAuthGoogleSignIn,
  errorAuthAppleSignIn,
  errorRemoteConfigInit,
  errorUserLoad,
  errorUserUnknown,
  errorUserStatusCheck,
  errorUserEdit,
  errorBloc,
}
