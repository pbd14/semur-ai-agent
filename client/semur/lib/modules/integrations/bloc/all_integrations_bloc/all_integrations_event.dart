part of 'all_integrations_bloc.dart';

sealed class AllIntegrationsEvent extends Equatable {
  const AllIntegrationsEvent();

  @override
  List<Object> get props => [];
}

class AllIntegrationsInitialize extends AllIntegrationsEvent {
  const AllIntegrationsInitialize();
}

class DeleteConnection extends AllIntegrationsEvent {
  final NangoConnection nangoConnection;
  const DeleteConnection({required this.nangoConnection});
}
