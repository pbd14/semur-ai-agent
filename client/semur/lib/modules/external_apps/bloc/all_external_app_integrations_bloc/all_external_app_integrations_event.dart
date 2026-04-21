part of 'all_external_app_integrations_bloc.dart';

sealed class AllExternalAppIntegrationsEvent extends Equatable {
  const AllExternalAppIntegrationsEvent();

  @override
  List<Object> get props => [];
}

class AllExternalAppIntegrationsInitialize
    extends AllExternalAppIntegrationsEvent {
  const AllExternalAppIntegrationsInitialize();
}

class AddExternalAppIntegration extends AllExternalAppIntegrationsEvent {
  final ExternalAppIntegration externalAppIntegration;
  final TelegramBotIntegration? telegramBotIntegration;
  const AddExternalAppIntegration({
    required this.externalAppIntegration,
    this.telegramBotIntegration,
  });
}

class DeleteExternalAppIntegration extends AllExternalAppIntegrationsEvent {
  final String integrationId;
  const DeleteExternalAppIntegration({required this.integrationId});
}
