part of 'auth_change_password_bloc.dart';

sealed class AuthChangePasswordEvent extends Equatable {
  const AuthChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class AuthChangePasswordSendCode extends AuthChangePasswordEvent {
  final String email;

  const AuthChangePasswordSendCode({
    required this.email,
  });
}

class AuthChangePassword extends AuthChangePasswordEvent {
  final String code;
  final String newPassword;

  const AuthChangePassword({
    required this.code,
    required this.newPassword,
  });
}

class AuthChangePasswordEmit extends AuthChangePasswordEvent {
  final AuthChangePasswordState state;

  const AuthChangePasswordEmit({
    required this.state,
  });
}
