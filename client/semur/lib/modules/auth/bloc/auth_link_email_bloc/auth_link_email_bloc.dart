import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/global/log/log.dart';

part 'auth_link_email_event.dart';
part 'auth_link_email_state.dart';

class AuthLinkBloc extends Bloc<AuthLinkEvent, AuthLinkState> {
  AuthLinkBloc() : super(AuthLinkInitial()) {
    on<AuthLinkEvent>((event, emit) async {
      // Email
      if (event is AuthLinkEmailSignUp) {
        emit(AuthLinkLoading());
        try {
          if ( !AppUser.user.hasId() ||
              FirebaseAuth.instance.currentUser == null) {
            emit(AuthLinkEmailError(
              exception: Application.appLocalizations!.errorTryAgainLater,
            ));
            return;
          }

          AuthCredential credential = EmailAuthProvider.credential(
              email: event.email, password: event.password);

          UserCredential res = await FirebaseAuth.instance.currentUser!
              .linkWithCredential(credential);

          // ignore: unnecessary_null_comparison
          if (res == null) {
            emit(AuthLinkEmailError(
              exception: Application.appLocalizations!.errorTryAgainLater,
            ));
          } else {
            await FirebaseAuth.instance.currentUser?.sendEmailVerification();
            Log.d("Email AuthLink Sign Up 1");
            emit(const AuthLinkEmailSuccess());
          }
        } on FirebaseAuthException catch (e) {
          Log.e(
            "Email AuthLink Error ${e.code}",
          );
          if (e.code == 'email-already-exists' ||
              e.code == 'email-already-in-use' ||
              e.code == 'credential-already-in-use') {
            emit(AuthLinkEmailError(
              exception: Application.appLocalizations!.emailAlreadyExists,
            ));
          } else if (e.code == 'invalid-email' ||
              e.code == 'invalid-credential') {
            Log.e("Email AuthLink Error ${e.code}", e);
            emit(AuthLinkEmailError(
              exception: Application.appLocalizations!.invalidEmail,
            ));
          } else if (e.code == 'invalid-login-credentials') {
            Log.e("Email AuthLink Error ${e.code}", e);
            emit(AuthLinkEmailError(
              exception:
                  Application.appLocalizations!.wrongEmailOrPassword,
            ));
          } else if (e.code == 'weak-password') {
            Log.e("Email AuthLink Error ${e.code}", e);
            emit(AuthLinkEmailError(
              exception: Application.appLocalizations!.weakPassword,
            ));
          } else if (e.code == 'provider-already-linked') {
            Log.e("Email AuthLink Error ${e.code}", e);
            emit(AuthLinkEmailError(
              exception: Application.appLocalizations!.alreadyLinked,
            ));
          } else {
            Log.e("Email AuthLink Error ${e.code}", e);
            emit(AuthLinkEmailError(
              exception: Application.appLocalizations!.errorTryAgainLater,
            ));
          }
        }
      }

      if (event is AuthLinkEmit) {
        emit(event.state);
      }
    });
  }
}
