part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthInitialize extends AuthEvent {
  final BuildContext context;
  const AuthInitialize({
    required this.context,
  });
}

class AuthReset extends AuthEvent {
  const AuthReset();
}

class AuthEmit extends AuthEvent {
  final AuthState state;

  const AuthEmit({
    required this.state,
  });
}

// Sign In

// Email
class AuthEmailSignIn extends AuthEvent {
  final String email;
  final String password;

  const AuthEmailSignIn({
    required this.email,
    required this.password,
  });
}

class AuthEmailSignUp extends AuthEvent {
  final String email;
  final String password;

  const AuthEmailSignUp({
    required this.email,
    required this.password,
  });
}

// Phone Auth
class AuthPhoneSignInSendSms extends AuthEvent {
  final BuildContext context;
  final String phoneNo;

  const AuthPhoneSignInSendSms({
    required this.context,
    required this.phoneNo,
  });
}

class AuthPhoneSignInWithOTP extends AuthEvent {
  final BuildContext context;
  final String smsCode;
  final String verId;

  const AuthPhoneSignInWithOTP({
    required this.context,
    required this.smsCode,
    required this.verId,
  });
}

class AuthPhoneSignIn extends AuthEvent {
  final PhoneAuthCredential authCredential;
  final String verId;

  const AuthPhoneSignIn({
    required this.authCredential,
    this.verId = ' d',
  });
}

// Google
class AuthGoogleSignIn extends AuthEvent {
  const AuthGoogleSignIn();
}

// Apple
class AuthAppleSignIn extends AuthEvent {
  const AuthAppleSignIn();
}

class AuthDeleteAccount extends AuthEvent {
  const AuthDeleteAccount();
}

// Sign Out
class AuthSignOut extends AuthEvent {
  const AuthSignOut();
}
