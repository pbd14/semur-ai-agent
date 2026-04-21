part of 'auth_link_email_bloc.dart';

sealed class AuthLinkState extends Equatable {
  const AuthLinkState();

  @override
  List<Object> get props => [];
}

final class AuthLinkInitial extends AuthLinkState {}

final class AuthLinkLoading extends AuthLinkState {}

class AuthLinkEmailError extends AuthLinkState {
  final dynamic exception;

  const AuthLinkEmailError({
    this.exception,
  });

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'AuthLinkEmailError {$exception}';
}

class AuthLinkEmailSuccess extends AuthLinkState {
  const AuthLinkEmailSuccess();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'AuthLinkEmailSuccess';
}
