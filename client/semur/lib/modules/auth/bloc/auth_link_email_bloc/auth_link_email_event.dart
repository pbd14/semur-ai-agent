part of 'auth_link_email_bloc.dart';

sealed class AuthLinkEvent extends Equatable {
  const AuthLinkEvent();

  @override
  List<Object> get props => [];
}

class AuthLinkEmit extends AuthLinkEvent {
  final BuildContext context;
  final AuthLinkState state;

  const AuthLinkEmit({
    required this.context,
    required this.state,
  });

  @override
  String toString() => 'AuthLinkEmit {$state}';

  @override
  List<Object> get props => [state];
}

class AuthLinkEmailSignUp extends AuthLinkEvent {
  final BuildContext context;
  final String email;
  final String password;

  const AuthLinkEmailSignUp({
    required this.context,
    required this.email,
    required this.password,
  });

  @override
  String toString() => 'AuthLinkEmailSignUp {$email}';

  @override
  List<Object> get props => [email, password];
}

class AuthLinkDelete extends AuthLinkEvent {
  const AuthLinkDelete();

  @override
  String toString() => 'AuthLinkDelete';

  @override
  List<Object> get props => [];
}
