import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/adaptive_layout_manager.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/global/screens/loading_screen.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/global/widgets/default_app_bar.dart';
import 'package:semur/global/widgets/default_modal_bottom_sheet.dart';
import 'package:semur/models.pb/external_apps/external_app.pb.dart';
import 'package:semur/models.pb/external_apps/telegram_bot_integration.pbserver.dart';
import 'package:semur/models.pb/google/protobuf/timestamp.pbserver.dart';
import 'package:semur/modules/external_apps/bloc/all_external_app_integrations_bloc/all_external_app_integrations_bloc.dart';
import 'package:semur/modules/external_apps/widgets/external_app_integration_card.dart';
import 'package:semur/modules/external_apps/widgets/add_external_app_integration_modal.dart';
import 'package:semur/services/notification_service.dart';

@RoutePage()
class AllExternalAppIntegrationsScreen extends StatefulWidget {
  final TelegramBotIntegration? newTelegramBotIntegration;
  const AllExternalAppIntegrationsScreen({
    super.key,
    this.newTelegramBotIntegration,
  });

  @override
  State<AllExternalAppIntegrationsScreen> createState() =>
      _AllExternalAppIntegrationsScreenState();
}

class _AllExternalAppIntegrationsScreenState
    extends State<AllExternalAppIntegrationsScreen> {
  final AllExternalAppIntegrationsBloc bloc = AllExternalAppIntegrationsBloc();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(const AllExternalAppIntegrationsInitialize());
      
      // If a new integration is provided, show confirmation modal
      if (widget.newTelegramBotIntegration != null) {
        _showAddIntegrationModal();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  Future<void> _refresh() async {
    bloc.add(const AllExternalAppIntegrationsInitialize());
    Completer<void> completer = Completer<void>();
    completer.complete();
    return completer.future;
  }

  void _showAddIntegrationModal() {
    if (widget.newTelegramBotIntegration == null) return;

    // Create ExternalAppIntegration from TelegramBotIntegration
    final integration = ExternalAppIntegration(
      id: Application.uuid.v4(),
      userId: AppUser.user.id,
      type: ExternalAppType.TELEGRAM_BOT,
      status: ExternalAppIntegrationStatus.ACTIVE,
      metadata: {
        'telegramBotIntegrationId': widget.newTelegramBotIntegration!.id,
        'username': widget.newTelegramBotIntegration!.username,
        'userFirstName': widget.newTelegramBotIntegration!.userFirstName,
        'userLastName': widget.newTelegramBotIntegration!.userLastName,
      },
      createdAt: Timestamp.fromDateTime(DateTime.now()),
      updatedAt: Timestamp.fromDateTime(DateTime.now()),
    );

    DefaultModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: AppColors.whiteColor,
      initialChildSize: 0.6,
      maxChildSize: 0.8,
    ).show(
      AddExternalAppIntegrationModal(
        integration: integration,
        telegramBotIntegration: widget.newTelegramBotIntegration,
        onConfirm: () {
          Navigator.pop(context);
          bloc.add(AddExternalAppIntegration(
            externalAppIntegration: integration,
            telegramBotIntegration: widget.newTelegramBotIntegration,
          ));
          showNotification(
            'Integration added successfully',
            NotificationType.success,
          );
        },
        onCancel: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void _deleteIntegration(String integrationId) {
    bloc.add(DeleteExternalAppIntegration(integrationId: integrationId));
    showNotification(
      'Integration deleted successfully',
      NotificationType.success,
    );
  }

  Map<ExternalAppType, List<ExternalAppIntegration>> _groupIntegrationsByType(
    List<ExternalAppIntegration> integrations,
  ) {
    final Map<ExternalAppType, List<ExternalAppIntegration>> grouped = {};
    for (final integration in integrations) {
      if (!grouped.containsKey(integration.type)) {
        grouped[integration.type] = [];
      }
      grouped[integration.type]!.add(integration);
    }
    return grouped;
  }

  String _getAppTypeDisplayName(ExternalAppType type) {
    switch (type) {
      case ExternalAppType.TELEGRAM_BOT:
        return 'Telegram Bot';
      default:
        return type.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DefaultAppBar(
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            child: IconButton(
              padding: EdgeInsets.zero,
              color: AppColors.primaryColor,
              icon: const Icon(
                CupertinoIcons.refresh_bold,
                // weight: 900,
                size: 30,
              ),
              onPressed: () {
                _refresh();
              },
            ),
          ),
        ],
      ),
      body: BlocListener(
        bloc: bloc,
        listener: blocListener,
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is AllExternalAppIntegrationsLoading) {
              return const LoadingScreen();
            }
            return AdaptiveLayoutManager(
              centerVertically: false,
              children: [
                SpecifiedNumberOfColumnsWrapper(
                  columns: 1,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "External Apps",
                        maxLines: 2,
                        style: Theme.of(context).textTheme.headlineMedium!,
                      ),
                    ),
                  ],
                ),
                if (state is AllExternalAppIntegrationsInitial) ...[
                  if (state.externalAppIntegrations.isNotEmpty) ...[
                    // Group integrations by type and display them
                    ...() {
                      final groupedIntegrations = _groupIntegrationsByType(state.externalAppIntegrations);
                      final List<Widget> widgets = [];
                      
                      for (final entry in groupedIntegrations.entries) {
                        final appType = entry.key;
                        final integrations = entry.value;
                        
                        // Add section header
                        widgets.add(
                          SpecifiedNumberOfColumnsWrapper(
                            columns: 1,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text(
                                  _getAppTypeDisplayName(appType),
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        );
                        
                        // Add integration cards
                        for (final integration in integrations) {
                          widgets.add(
                            SpecifiedNumberOfColumnsWrapper(
                              columns: 1,
                              children: [
                                ExternalAppIntegrationCard(
                                  integration: integration,
                                  onDelete: () => _deleteIntegration(integration.id),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                      
                      return widgets;
                    }(),
                  ] else ...[
                    SpecifiedNumberOfColumnsWrapper(
                      columns: 1,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              children: [
                                Text(
                                  'No External Apps',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'You haven\'t connected any external apps yet.',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: AppColors.secondaryColor,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  void blocListener(BuildContext context, state) {
    if (state is AllExternalAppIntegrationsError) {
      showNotification(state.errorText, NotificationType.error);
    }
  }
}
