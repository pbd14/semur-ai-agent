import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/helpers/platform/platform_info.dart';
import 'package:semur/models.pb/user/user.pbserver.dart';
import 'package:semur/services/firebase_analytics_service.dart';

class AppUser {
  static ValueNotifier<SemurUser?> userNotifier = ValueNotifier(null);

  AppUser._();

  static set user(SemurUser? model) {
    userNotifier.value = model;
  }

  static bool isGuestMode() {
    return FirebaseAuth.instance.currentUser == null;
  }

  static SemurUser get user => userNotifier.value ?? SemurUser();

  static PermissionRoles get currentCallerRole =>
      AppUser.isGuestMode() ? PermissionRoles.guest : PermissionRoles.user;

  static UserStatus getInitialUserStatus() {
    if (kIsWeb) {
      return UserStatus.CREATED;
    } else {
      return PlatformInfo.isIOS ? UserStatus.UNVERIFIED : UserStatus.CREATED;
    }
  }

  static Future<void> loadFromFirebase({
    FirebaseAuthProviders? provider,
  }) async {
    try {
      if (FirebaseAuth.instance.currentUser?.uid == null ||
          !(await Application.accessors.userAccessor.exists(
            userId: FirebaseAuth.instance.currentUser?.uid ?? "",
            callerRole: AppUser.currentCallerRole,
          ))) {
        await Application.accessors.userAccessor.set(
          user: SemurUser(
            id: FirebaseAuth.instance.currentUser?.uid,
            email: FirebaseAuth.instance.currentUser?.email,
            birthDate: null,
            status: AppUser.getInitialUserStatus(),
          ),
          callerRole: AppUser.currentCallerRole,
        );
      }
      if (provider != null) {
        switch (provider) {
          case FirebaseAuthProviders.google ||
              FirebaseAuthProviders.password ||
              FirebaseAuthProviders.apple:
            await Application.accessors.userAccessor.updateCustomFields(
              userId: FirebaseAuth.instance.currentUser?.uid ?? "",
              updatedData: {
                "email": FirebaseAuth.instance.currentUser?.email,
                "firstName": FirebaseAuth.instance.currentUser?.displayName,
              },
              callerRole: AppUser.currentCallerRole,
            );
            break;
          default:
        }
      }
      AppUser.user = await Application.accessors.userAccessor.get(
        userId: FirebaseAuth.instance.currentUser?.uid ?? "",
        callerRole: AppUser.currentCallerRole,
      );

      Log.d(
        "Updated Firebase User at ${FirebaseAuth.instance.currentUser?.uid}",
      );
    } catch (e) {
      // FirebaseAnalytics log error event
      Application.firebaseAnalyticsService.logEvent(
        FirebaseAnalyticsEvent.errorUserLoad,
        parameters: {"error": e.toString()},
      );
      Log.e("AppUser loadFromFirebase error", e);
      rethrow;
    }
  }

  static Future<FirebaseAuthProviders> getAuthProvider() async {
    return firebaseAuthProviderFromString(
      (await FirebaseAuth.instance.currentUser!.getIdTokenResult())
          .signInProvider!,
    );
  }

  static Future<List<FirebaseAuthProviders>> getAllAuthProviders() async {
    return FirebaseAuth.instance.currentUser!.providerData
        .map((e) => firebaseAuthProviderFromString(e.providerId))
        .toList();
  }

  static void clear() {
    userNotifier.value = null;
    AppUser.user = null;
  }
}
