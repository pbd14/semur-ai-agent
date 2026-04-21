part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

// Sign In

// Email
final class AuthEmailSignInInitial extends AuthState {}

final class AuthEmailSignUpInitial extends AuthState {}

class AuthEmailSignInError extends AuthState {
  final String errorText;

  const AuthEmailSignInError({
    required this.errorText,
  });
}

// class AuthEmailSignInSuccess extends AuthState {
//   const AuthEmailSignInSuccess();

//   @override
//   List<Object> get props => [];

//   @override
//   String toString() => 'AuthEmailSignInSuccess';
// }

class AuthEmailSignUpError extends AuthState {
  final String errorText;
  final AuthState state;

  const AuthEmailSignUpError({
    required this.errorText,
    required this.state,
  });
}

// class AuthEmailSignUpSuccess extends AuthState {
//   const AuthEmailSignUpSuccess();

//   @override
//   List<Object> get props => [];

//   @override
//   String toString() => 'AuthEmailSignInSuccess';
// }

// Phone Auth
final class AuthPhoneInitial extends AuthState {}

class AuthPhoneSignInVerified extends AuthState {
  final PhoneAuthCredential authCredential;
  const AuthPhoneSignInVerified({
    required this.authCredential,
  });
}

class AuthPhoneSignInSmsSent extends AuthState {
  final String verId;
  const AuthPhoneSignInSmsSent({
    required this.verId,
  });
}

class AuthPhoneSignInTimeout extends AuthState {
  final String verId;
  const AuthPhoneSignInTimeout({
    required this.verId,
  });
}

class AuthPhoneSignInError extends AuthState {
  final dynamic exception;

  const AuthPhoneSignInError({
    this.exception,
  });
}

class AuthPhoneSignInSmsError extends AuthState {
  final dynamic exception;
  final String verId;

  const AuthPhoneSignInSmsError({
    this.exception,
    required this.verId,
  });
}

// class AuthPhoneSignInSuccess extends AuthState {
//   const AuthPhoneSignInSuccess();

//   @override
//   List<Object> get props => [];

//   @override
//   String toString() => 'AuthPhoneSignInSuccess';
// }

// Google

class AuthGoogleError extends AuthState {
  final String errorText;

  const AuthGoogleError({
    required this.errorText,
  });
}

// class AuthGoogleSuccess extends AuthState {
//   const AuthGoogleSuccess();

//   @override
//   List<Object> get props => [];

//   @override
//   String toString() => 'AuthGoogleSuccess';
// }

// Apple

class AuthAppleError extends AuthState {
  final String errorText;

  const AuthAppleError({
    required this.errorText,
  });
}

// class AuthAppleSuccess extends AuthState {
//   const AuthAppleSuccess();

//   @override
//   List<Object> get props => [];

//   @override
//   String toString() => 'AuthAppleSuccess';
// }

// Sign Out

// Status
class AuthStatusSignedOut extends AuthState {
  const AuthStatusSignedOut();
}

class AuthStatusSignedIn extends AuthState {
  const AuthStatusSignedIn();
}
