part of 'all_integrations_bloc.dart';

sealed class AllIntegrationsState extends Equatable {
  const AllIntegrationsState();

  @override
  List<Object> get props => [];
}

class AllIntegrationsInitial extends AllIntegrationsState {
  final List<NangoConnectionPublic> userConnections;
  final Map<String, SyncInformation?> syncInfoMap;
  final List<NangoIntegration> availableIntegrations;

  const AllIntegrationsInitial({
    required this.userConnections,
    required this.syncInfoMap,
    required this.availableIntegrations,
  });
}

final class AllIntegrationsLoading extends AllIntegrationsState {}

class AllIntegrationsError extends AllIntegrationsState {
  final String errorText;

  const AllIntegrationsError({required this.errorText});
}
