part of 'auth_change_password_bloc.dart';

sealed class AuthChangePasswordState extends Equatable {
  const AuthChangePasswordState();

  @override
  List<Object> get props => [];
}

final class AuthChangePasswordInitial extends AuthChangePasswordState {}

final class AuthChangePasswordLoading extends AuthChangePasswordState {}

class AuthChangePasswordError extends AuthChangePasswordState {
  final String errorText;

  const AuthChangePasswordError({
    required this.errorText,
  });
}

class AuthChangePasswordSendLinkSuccess extends AuthChangePasswordState {
  const AuthChangePasswordSendLinkSuccess();
}

class AuthChangePasswordConfirmError extends AuthChangePasswordState {
  final String errorText;

  const AuthChangePasswordConfirmError({
    required this.errorText,
  });
}

class AuthChangePasswordSuccess extends AuthChangePasswordState {
  const AuthChangePasswordSuccess();
}
