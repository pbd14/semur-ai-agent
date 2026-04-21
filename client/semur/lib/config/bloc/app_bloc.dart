import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:semur/accessors/app_data_accessor.dart';
import 'package:semur/accessors/users/user_accessor.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/config/shared_preferences_keys.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/l10n/locale_constant.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:semur/models.pb/user/user.pb.dart';
import 'package:semur/models.pb/user/user.pbenum.dart';
import 'package:semur/services/firebase_analytics_service.dart';
import 'package:semur/services/notification_service.dart';
import 'package:semur/transformers/users/user_firebase_transformer.dart';
import 'package:version/version.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial()) {
    on<AppEvent>((event, emit) async {
      if (event is AppInitialize) {
        emit(AppLoading());

        // Check if internet is available
        if (!kIsWeb) {
          if (!(await Application.hasNetwork())) {
            emit(const AppError(errorText: "No internet connection"));
            return;
          }
        }

        // Initialize remote config
        try {
          await Application.remoteConfigService.init();
        } catch (e) {
          // FirebaseAnalytics log error event
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.errorRemoteConfigInit,
            parameters: {"error": e.toString()},
          );
          Log.e("Error initializing remote config", e);
        }

        // Check App min version
        try {
          if (!kIsWeb) {
            await Application.getMinVersion();

            PackageInfo packageInfo = await PackageInfo.fromPlatform();
            String currentVersion = packageInfo.version;

            if (Version.parse(currentVersion) <
                Version.parse(Application.minVersion!)) {
              add(
                AppEmit(
                  state: AppNeedsUpdate(updateLink: Application.storeLink!),
                ),
              );
              return;
            }
          }

          SemurVarsModel semurVars = await Application
              .accessors
              .appDataAccessor
              .get(callerRole: AppUser.currentCallerRole);

          // Check Web App status
          if (kIsWeb) {
            if (!semurVars.isWebActive) {
              Log.w("Firebase App status is not active");
              add(const AppEmit(state: AppNotActive()));
              return;
            }

            // WARNING: This should be in Accessor
            Application.firestore
                .collection(AppDataAccessor.firebaseCollectionName)
                .doc(AppDataAccessor.firebaseSemurVarsDocumentId)
                .snapshots()
                .listen((vars) async {
                  if (!vars.get('isWebActive')) {
                    Log.w("Firebase App status is not active");
                    add(const AppEmit(state: AppNotActive()));
                    return;
                  }
                });
          } else {
            // // Check Mobile App status
            // ValueNotifier<RemoteConfigValue> isAppActive;
            // if (Platform.isAndroid) {
            //   isAppActive = await Application.remoteConfigService
            //       .getValueNotifier(
            //         key: RemoteConfigSemurGroupKeys.isAndroidActiveSemur.name,
            //       );
            // } else if (Platform.isIOS) {
            //   isAppActive = await Application.remoteConfigService
            //       .getValueNotifier(
            //         key: RemoteConfigSemurGroupKeys.isIosActiveSemur.name,
            //       );
            // } else {
            //   isAppActive = await Application.remoteConfigService
            //       .getValueNotifier(
            //         key: RemoteConfigSemurGroupKeys.isWebActiveSemur.name,
            //       );
            // }
            // // TODO: Fix. This is incosistent, so consider moving to Firestore
            // if (!isAppActive.value.asBool() && !kDebugMode && !Platform.isIOS) {
            //   Log.w("Firebase App status is not active");
            //   add(const AppEmit(state: AppNotActive()));
            //   return;
            // }

            // // TODO: Fix. This is incosistent, so consider moving to Firestore
            // isAppActive.addListener(() {
            //   if (!isAppActive.value.asBool() &&
            //       /!kDebugMode &&
            //       /!Platform.isIOS) {
            //     Log.w("Firebase App status is not active");
            //     add(const AppEmit(state: AppNotActive()));
            //     return;
            //   }
            // });
          }

          // Check Guest Mode
          if (AppUser.isGuestMode()) {
            // FirebaseAnalytics log event
            Application.firebaseAnalyticsService.logEvent(
              FirebaseAnalyticsEvent.openInGuestMode,
            );
            emit(const AppGuestMode());
            return;
          }

          // Load User from Firebase
          try {
            await AppUser.loadFromFirebase();
          } catch (e) {
            emit(
              AppError(
                errorText: Application.appLocalizations!.errorTryAgainLater,
              ),
            );
          }

          // Listen for User Document changes
          // WARNING: This should be in Accessor
          Application.userSubscription = Application.firestore
              .collection(UserAccessor.firebaseCollectionName)
              .doc(AppUser.user.id)
              .snapshots()
              .listen((userSnapshot) async {
                SemurUser user = UserFirebaseTransformer.fromFirebase(userSnapshot);
                if (user.status == UserStatus.CREATED) {
                  add(const AppEmit(state: AppUserCreated()));
                } else if ([
                  UserStatus.VERIFIED,
                  UserStatus.UNVERIFIED,
                ].contains(user.status)) {
                  // Check user email verification
                  bool emailVerificationRequired = false;
                  try {
                    emailVerificationRequired =
                        semurVars.emailVerificationRequired;
                  } catch (e) {
                    emailVerificationRequired = false;
                  }
                  if (emailVerificationRequired &&
                      (await AppUser.getAuthProvider()) ==
                          FirebaseAuthProviders.password) {
                    await FirebaseAuth.instance.currentUser!.reload();
                    if (!FirebaseAuth.instance.currentUser!.emailVerified) {
                      await FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                      add(AppEmit(state: AppEmail()));
                      return;
                    }
                  }

                  // Sync language with backend
                  if (AppUser.user.hasId() &&
                      (!AppUser.user.hasLanguage() ||
                          AppUser.user.language != Application.language)) {
                    changeLanguage(event.context, Application.language ?? "en");
                  }

                  // Initialize Notification Service
                  await NotificationService().init();

                  // Check Privacy Document
                  bool isPrivacyDocumentAccepted = true;
                  try {
                    int privacyPolicyVersion =
                        Application.sharedPreferences!.getInt(
                          SharedPreferencesKeys.privacyPolicyVersion,
                        ) ??
                        0;
                    if (semurVars.privacyPolicyVersion >
                        privacyPolicyVersion) {
                      isPrivacyDocumentAccepted = false;
                    }
                  } catch (e) {
                    isPrivacyDocumentAccepted = true;
                  }

                  add(
                    AppEmit(
                      state: AppSuccess(
                        isPrivacyDocumentAccepted: isPrivacyDocumentAccepted,
                      ),
                    ),
                  );
                } else if (user.status == UserStatus.BLOCKED) {
                  // FirebaseAnalytics log event
                  Application.firebaseAnalyticsService.logEvent(
                    FirebaseAnalyticsEvent.userBlocked,
                  );
                  add(const AppEmit(state: AppUserBlocked()));
                } else {
                  // FirebaseAnalytics log event
                  Application.firebaseAnalyticsService.logEvent(
                    FirebaseAnalyticsEvent.errorUserUnknown,
                    parameters: {
                      "error":
                          "Unknown error with user status: ${user.status}",
                    },
                  );
                  add(
                    AppEmit(
                      state: AppError(
                        errorText:
                            Application.appLocalizations!.errorTryAgainLater,
                      ),
                    ),
                  );
                }
              });
        } catch (e) {
          // FirebaseAnalytics log error event
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.errorUserStatusCheck,
            parameters: {"error": e.toString()},
          );
          Log.e("Error checking App and User status from Firebase", e);
          emit(
            AppError(errorText: "${Application.appLocalizations!.error}. $e"),
          );
        }
      }

      if (event is AppVerifyEmail) {
        emit(AppLoading());
        try {
          // Reload user data
          await FirebaseAuth.instance.currentUser!.reload();

          // Check if email is verified
          if (FirebaseAuth.instance.currentUser!.emailVerified) {
            try {
              await AppUser.loadFromFirebase();
              add(AppInitialize(context: event.context));
            } catch (e) {
              Log.e("Email Verify Error");
              emit(
                AppEmailError(
                  errorText: Application.appLocalizations!.errorTryAgainLater,
                ),
              );
            }
          } else {
            emit(
              AppEmailError(
                errorText: Application.appLocalizations!.emailNotVerified,
              ),
            );
          }
        } catch (e) {
          // FirebaseAnalytics log error event
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.errorAuthEmailVerify,
            parameters: {"error": e.toString()},
          );
          Log.e("Email Auth Error", e);
          emit(
            AppEmailError(
              errorText: Application.appLocalizations!.errorTryAgainLater,
            ),
          );
        }
      }

      if (event is AppEmit) {
        emit(event.state);
      }
    });
  }
}
