import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/adaptive_layout_manager.dart';
import 'package:semur/global/screens/loading_screen.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/global/widgets/default_app_bar.dart';
import 'package:semur/models.pb/nango/nango.pb.dart';
import 'package:semur/modules/integrations/bloc/all_integrations_bloc/all_integrations_bloc.dart';
import 'package:semur/modules/integrations/widgets/nango_integration_card.dart';
import 'package:semur/modules/integrations/widgets/nango_connections_table.dart';
import 'package:semur/services/notification_service.dart';

@RoutePage()
class AllIntegrationsScreen extends StatefulWidget {
  const AllIntegrationsScreen({super.key});

  @override
  State<AllIntegrationsScreen> createState() => _AllIntegrationsScreenState();
}

class _AllIntegrationsScreenState extends State<AllIntegrationsScreen> {
  final AllIntegrationsBloc bloc = AllIntegrationsBloc();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(const AllIntegrationsInitialize());
    });
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  Future<void> _refresh() async {
    bloc.add(const AllIntegrationsInitialize());
    Completer<void> completer = Completer<void>();
    completer.complete();
    return completer.future;
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
            if (state is AllIntegrationsLoading) {
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
                        Application.appLocalizations!.integrations,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.headlineMedium!,
                      ),
                    ),
                  ],
                ),
                if (state is AllIntegrationsInitial) ...[
                  // User connections
                  if (state.userConnections.isNotEmpty) ...[
                    SpecifiedNumberOfColumnsWrapper(
                      columns: 1,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Your Connections',
                            maxLines: 2,
                            style: Theme.of(context).textTheme.headlineSmall!,
                          ),
                        ),
                      ],
                    ),
                    SpecifiedNumberOfColumnsWrapper(
                      columns: 1,
                      children: [
                        NangoConnectionsTable(
                          connections: state.userConnections,
                          syncInfoMap: state.syncInfoMap,
                          onDelete: (connectionId) {
                            // TODO: Implement delete connection functionality
                            showNotification(
                              'Delete connection: $connectionId',
                              NotificationType.info,
                            );
                          },
                        ),
                      ],
                    ),
                  ] else ...[
                    SpecifiedNumberOfColumnsWrapper(
                      columns: 1,
                      children: [
                        Center(
                          child: Text(
                            Application.appLocalizations!.noUserConnections,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodyMedium!,
                          ),
                        ),
                      ],
                    ),
                  ],

                  SpecifiedNumberOfColumnsWrapper(
                    columns: 1,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          Application.appLocalizations!.addIntegration,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headlineSmall!,
                        ),
                      ),
                    ],
                  ),

                  for (NangoIntegration integration
                      in state.availableIntegrations) ...[
                    NangoIntegrationCard(
                      onConnect: _refresh,
                      integration: integration,
                      isDisabled: state.userConnections.any(
                        (conn) => conn.id == integration.id,
                      ),
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
    if (state is AllIntegrationsError) {
      showNotification(state.errorText, NotificationType.error);
    }
  }
}
