import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/services/firebase_analytics_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthLoading()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthInitialize) {
        emit(AuthLoading());
        // Listen for auth state changes
        FirebaseAuth.instance.authStateChanges().listen((event) {
          if (event == null) {
            Log.d("Auth State Changed: Signed Out");
            add(const AuthEmit(state: AuthStatusSignedOut()));
            add(AuthEmit(state: AuthInitial()));
          } else {
            Log.d("Auth State Changed: Signed In");
            add(const AuthEmit(state: AuthStatusSignedIn()));
          }
        });
      }

      if (event is AuthReset) {
        emit(AuthInitial());
      }

      // Email
      if (event is AuthEmailSignIn) {
        emit(AuthLoading());
        try {
          UserCredential res = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                email: event.email,
                password: event.password,
              );

          // WARNING: For some reason this check is needed
          // ignore: unnecessary_null_comparison
          if (res == null) {
            Log.e("Email Auth Sign in Error res == null");
            Application.firebaseAnalyticsService.logEvent(
              FirebaseAnalyticsEvent.errorAuthEmailSignIn,
              parameters: {"email": event.email, "error": "res == null"},
            );
            emit(
              AuthEmailSignInError(
                errorText: Application.appLocalizations!.authError,
              ),
            );
            return;
          }
          // Reload user data
          await FirebaseAuth.instance.currentUser!.reload();
          // Get user data from Firestore
          // FirebaseAnalytics log event
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.authEmailSignIn,
            parameters: {"email": event.email},
          );
          Log.d("Email Auth Signed In");
        } on FirebaseAuthException catch (e) {
          Log.e("Email Auth Error ${e.code}");
          // FirebaseAnalytics log error event
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.errorAuthEmailSignIn,
            parameters: {"email": event.email, "error": e.toString()},
          );

          // Handle specific error codes
          if (e.code == 'user-not-found') {
            emit(
              AuthEmailSignInError(
                errorText: Application.appLocalizations!.emailNoUserFound,
              ),
            );
          } else if (e.code == 'invalid-credential') {
            emit(
              AuthEmailSignInError(
                errorText: Application.appLocalizations!.wrongEmailOrPassword,
              ),
            );
          } else if (e.code == 'wrong-password') {
            Log.e("Email Auth Error ${e.code}", e);
            emit(
              AuthEmailSignInError(
                errorText: Application.appLocalizations!.wrongEmailOrPassword,
              ),
            );
          } else if (e.code == 'invalid-login-credentials') {
            Log.e("Email Auth Error ${e.code}", e);
            emit(
              AuthEmailSignInError(
                errorText: Application.appLocalizations!.wrongEmailOrPassword,
              ),
            );
          } else {
            Log.e("Email Auth Error ${e.code}", e);
            emit(
              AuthEmailSignInError(
                errorText: Application.appLocalizations!.authError,
              ),
            );
          }
        }
      }

      if (event is AuthEmailSignUp) {
        emit(AuthLoading());
        try {
          // Create user
          UserCredential res = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                email: event.email,
                password: event.password,
              );

          // WARNING: For some reason this check is needed
          // ignore: unnecessary_null_comparison
          if (res == null) {
            Log.e("Email Auth Sign Up Error res == null");
            // FirebaseAnalytics log error event
            Application.firebaseAnalyticsService.logEvent(
              FirebaseAnalyticsEvent.errorAuthEmailSignUp,
              parameters: {"email": event.email, "error": "res == null"},
            );
            emit(
              AuthEmailSignUpError(
                state: AuthEmailSignUpInitial(),
                errorText: Application.appLocalizations!.authError,
              ),
            );
            return;
          }
          // FirebaseAnalytics log event
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.authEmailSignUpSendVerification,
            parameters: {"email": event.email},
          );
          await FirebaseAuth.instance.currentUser?.sendEmailVerification();
          Log.d("Email Auth Sign Up");
        } on FirebaseAuthException catch (e) {
          // FirebaseAnalytics log error event
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.errorAuthEmailSignUp,
            parameters: {"email": event.email, "error": e.toString()},
          );
          Log.e("Email Auth Error ${e.code}");

          // Handle specific error codes
          if (e.code == 'email-already-exists' ||
              e.code == 'email-already-in-use') {
            emit(
              AuthEmailSignUpError(
                errorText: Application.appLocalizations!.emailAlreadyExists,
                state: AuthEmailSignUpInitial(),
              ),
            );
          } else if (e.code == 'invalid-email') {
            Log.e("Email Auth Error ${e.code}", e);
            emit(
              AuthEmailSignUpError(
                errorText: Application.appLocalizations!.invalidEmail,
                state: AuthEmailSignUpInitial(),
              ),
            );
          } else if (e.code == 'invalid-login-credentials') {
            Log.e("Email Auth Error ${e.code}", e);
            emit(
              AuthEmailSignUpError(
                errorText: Application.appLocalizations!.wrongEmailOrPassword,
                state: AuthEmailSignUpInitial(),
              ),
            );
          } else if (e.code == 'weak-password') {
            Log.e("Email Auth Error ${e.code}", e);
            emit(
              AuthEmailSignUpError(
                errorText: Application.appLocalizations!.weakPassword,
                state: AuthEmailSignUpInitial(),
              ),
            );
          } else {
            Log.e("Email Auth Error ${e.code}", e);
            emit(
              AuthEmailSignUpError(
                errorText: Application.appLocalizations!.authError,
                state: AuthEmailSignUpInitial(),
              ),
            );
          }
        }
      }

      // Google
      if (event is AuthGoogleSignIn) {
        emit(AuthLoading());
        try {
          // Trigger the authentication flow
          if (await GoogleSignIn().isSignedIn()) {
            await GoogleSignIn().signOut();
          }
          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

          // Obtain the auth details from the request
          final GoogleSignInAuthentication? googleAuth =
              await googleUser?.authentication;

          // Create a new credential
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );

          // Once signed in, return the UserCredential
          UserCredential res = await FirebaseAuth.instance.signInWithCredential(
            credential,
          );

          // ignore: unnecessary_null_comparison
          if (res == null) {
            Application.firebaseAnalyticsService.logEvent(
              FirebaseAnalyticsEvent.errorAuthGoogleSignIn,
              parameters: {"error": "res == null"},
            );
            Log.e("Google Auth error Null");
            emit(
              AuthGoogleError(
                errorText: Application.appLocalizations!.authError,
              ),
            );
            return;
          }

          // Load user data from Firestore
          try {
            await AppUser.loadFromFirebase(
              provider: FirebaseAuthProviders.google,
            );
            // FirebaseAnalytics log event
            Application.firebaseAnalyticsService.logEvent(
              FirebaseAnalyticsEvent.authGoogleSignIn,
              parameters: {"email": AppUser.user.email},
            );
          } catch (e) {
            Log.e("Google Auth Error", e);
            emit(
              AuthGoogleError(
                errorText: Application.appLocalizations!.authError,
              ),
            );
          }
        } catch (e) {
          // FirebaseAnalytics log error event
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.errorAuthGoogleSignIn,
            parameters: {"error": e.toString()},
          );
          Log.e("Google Error", e);
          emit(
            AuthGoogleError(errorText: Application.appLocalizations!.authError),
          );
        }
      }

      // Apple
      if (event is AuthAppleSignIn) {
        emit(AuthLoading());
        try {
          final appleProvider = AppleAuthProvider();
          UserCredential res;
          if (kIsWeb) {
            res = await FirebaseAuth.instance.signInWithPopup(appleProvider);
          } else {
            res = await FirebaseAuth.instance.signInWithProvider(appleProvider);
          }

          // ignore: unnecessary_null_comparison
          if (res == null) {
            Application.firebaseAnalyticsService.logEvent(
              FirebaseAnalyticsEvent.errorAuthAppleSignIn,
              parameters: {"error": "res == null"},
            );
            Log.e("Apple Auth error Null");
            emit(
              AuthAppleError(
                errorText: Application.appLocalizations!.authError,
              ),
            );
            return;
          }

          // Load user data from Firestore
          try {
            await AppUser.loadFromFirebase(
              provider: FirebaseAuthProviders.apple,
            );
            // FirebaseAnalytics log event
            Application.firebaseAnalyticsService.logEvent(
              FirebaseAnalyticsEvent.authAppleSignIn,
              parameters: {"email": AppUser.user.email},
            );
          } catch (e) {
            Log.e("Apple Auth Error", e);
            emit(
              AuthAppleError(
                errorText: Application.appLocalizations!.authError,
              ),
            );
          }
        } catch (e) {
          // FirebaseAnalytics log error event
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.errorAuthAppleSignIn,
            parameters: {"error": e.toString()},
          );
          Log.e("Apple Error", e);
          emit(
            AuthAppleError(errorText: Application.appLocalizations!.authError),
          );
        }
      }

      if (event is AuthDeleteAccount) {
        emit(AuthLoading());
        try {
          // TODO: Move to Accessors
          DocumentSnapshot deletedUser =
              await Application.firestore
                  .collection('users')
                  .doc(AppUser.user.id)
                  .get();
          await Application.firestore
              .collection('deletedUsers')
              .doc(
                "${deletedUser.id}_${Application.dateTime.now().millisecondsSinceEpoch}",
              )
              .set(deletedUser.data() as Map<String, dynamic>);
          await Application.accessors.userAccessor.delete(
            userId: AppUser.user.id,
            callerRole: AppUser.currentCallerRole,
          );

          // FirebaseAnalytics log event
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.authDeleteAccount,
            parameters: {"userId": AppUser.user.id},
          );
          add(AuthSignOut());
        } catch (e) {
          Log.e("Auth Delete Account Error", e);
          emit(AuthInitial());
        }
      }

      if (event is AuthSignOut) {
        try {
          Log.d("Auth Sign Out");
          if (Application.userSubscription != null) {
            await Application.userSubscription!.cancel();
          }
          if (Application.userNotificationsSubscription != null) {
            await Application.userNotificationsSubscription!.cancel();
          }
          await FirebaseAuth.instance.signOut();
          await Application.sharedPreferences!.clear();
          AppUser.clear();

          // FirebaseAnalytics log event
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.authSignOut,
          );
          Log.d("Auth Sign Out Finished");
        } catch (e) {
          Log.e("Auth Sign Out Error", e);
          emit(AuthInitial());
        }
      }

      if (event is AuthEmit) {
        emit(event.state);
      }
    });
  }
}
