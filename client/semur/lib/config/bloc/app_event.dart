part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppInitialize extends AppEvent {
  final BuildContext context;
  const AppInitialize({
    required this.context,
  });
}

class AppVerifyEmail extends AppEvent {
  final BuildContext context;
  const AppVerifyEmail({
    required this.context,
  });
}

class AppEmit extends AppEvent {
  final AppState state;

  const AppEmit({
    required this.state,
  });
}
