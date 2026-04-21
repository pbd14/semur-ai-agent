part of 'app_bloc.dart';

sealed class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

final class AppInitial extends AppState {}

final class AppLoading extends AppState {}

// Email

final class AppEmail extends AppState {}

class AppEmailError extends AppState {
  final String errorText;

  const AppEmailError({
    required this.errorText,
  });
}

class AppError extends AppState {
  final String errorText;

  const AppError({
    required this.errorText,
  });
}

class AppSuccess extends AppState {
  final bool isPrivacyDocumentAccepted;
  const AppSuccess({
    required this.isPrivacyDocumentAccepted,
  });
}

class AppGuestMode extends AppState {
  const AppGuestMode();
}

class AppNotActive extends AppState {
  const AppNotActive();
}

class AppNeedsUpdate extends AppState {
  final String updateLink;
  const AppNeedsUpdate({
    required this.updateLink,
  });
}

class AppUserCreated extends AppState {
  const AppUserCreated();
}

class AppUserBlocked extends AppState {
  const AppUserBlocked();
}
