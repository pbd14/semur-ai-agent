part of 'all_external_app_integrations_bloc.dart';

sealed class AllExternalAppIntegrationsState extends Equatable {
  const AllExternalAppIntegrationsState();

  @override
  List<Object> get props => [];
}

class AllExternalAppIntegrationsInitial
    extends AllExternalAppIntegrationsState {
  final List<ExternalAppIntegration> externalAppIntegrations;

  const AllExternalAppIntegrationsInitial({
    required this.externalAppIntegrations,
  });
}

final class AllExternalAppIntegrationsLoading
    extends AllExternalAppIntegrationsState {}

class AllExternalAppIntegrationsError extends AllExternalAppIntegrationsState {
  final String errorText;

  const AllExternalAppIntegrationsError({required this.errorText});
}
