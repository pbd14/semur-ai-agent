import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:semur/config/application.dart';
import 'package:semur/services/firebase_analytics_service.dart';

part 'auth_change_password_event.dart';
part 'auth_change_password_state.dart';

class AuthChangePasswordBloc
    extends Bloc<AuthChangePasswordEvent, AuthChangePasswordState> {
  AuthChangePasswordBloc() : super(AuthChangePasswordInitial()) {
    on<AuthChangePasswordEvent>((event, emit) async {
      if (event is AuthChangePasswordSendCode) {
        emit(AuthChangePasswordLoading());
        try {
          // Check if email is correct
          if (FirebaseAuth.instance.currentUser != null) {
            if (FirebaseAuth.instance.currentUser!.email != event.email) {
              emit(
                AuthChangePasswordError(
                  errorText: Application.appLocalizations!.wrongEmail,
                ),
              );
              return;
            }
          }

          // Send password reset email
          await FirebaseAuth.instance.sendPasswordResetEmail(
            email: event.email,
          );
          emit(const AuthChangePasswordSendLinkSuccess());
        } on FirebaseAuthException catch (e) {
          // FirebaseAnalytics
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.errorAuthEmailChangePassword,
            parameters: {"error": e.toString()},
          );

          // Handle specific FirebaseAuthException errors
          if (e.code == 'invalid-email') {
            emit(
              AuthChangePasswordError(
                errorText: Application.appLocalizations!.wrongEmail,
              ),
            );
          } else if (e.code == 'user-not-found') {
            emit(
              AuthChangePasswordError(
                errorText: Application.appLocalizations!.userNotFound,
              ),
            );
          } else {
            emit(
              AuthChangePasswordError(
                errorText: Application.appLocalizations!.error,
              ),
            );
          }
        } catch (e) {
          // FirebaseAnalytics
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.errorAuthEmailChangePassword,
            parameters: {"error": e.toString()},
          );

          emit(
            AuthChangePasswordError(
              errorText: Application.appLocalizations!.error,
            ),
          );
        }
      }

      if (event is AuthChangePassword) {
        emit(AuthChangePasswordLoading());
        try {
          // Confirm password reset
          await FirebaseAuth.instance.confirmPasswordReset(
            code: event.code,
            newPassword: event.newPassword,
          );
          emit(const AuthChangePasswordSuccess());
        } on FirebaseAuthException catch (e) {
          // FirebaseAnalytics
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.errorAuthEmailChangePassword,
            parameters: {"error": e.toString()},
          );

          // Handle specific FirebaseAuthException errors
          if (e.code == 'expired-action-code') {
            emit(
              AuthChangePasswordError(
                errorText: Application.appLocalizations!.expiredActionCode,
              ),
            );
          } else if (e.code == 'invalid-action-code') {
            emit(
              AuthChangePasswordConfirmError(
                errorText: Application.appLocalizations!.invalidActionCode,
              ),
            );
          } else if (e.code == 'weak-password') {
            emit(
              AuthChangePasswordConfirmError(
                errorText: Application.appLocalizations!.weakPassword,
              ),
            );
          } else {
            emit(
              AuthChangePasswordConfirmError(
                errorText: Application.appLocalizations!.error,
              ),
            );
          }
        }
      }
    });
  }
}
