import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:semur/config/application.dart';
import 'package:semur/config/config.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/models.pb/nango/nango.pbserver.dart';
import 'package:semur/models.pb/syncs/sync.pbserver.dart';
import 'package:semur/semur_engine/nango/nango_engine.dart';
import 'package:semur/services/firebase_analytics_service.dart';

part 'all_integrations_event.dart';
part 'all_integrations_state.dart';

class AllIntegrationsBloc
    extends Bloc<AllIntegrationsEvent, AllIntegrationsState> {
  AllIntegrationsBloc() : super(AllIntegrationsLoading()) {
    on<AllIntegrationsEvent>((event, emit) async {
      if (event is AllIntegrationsInitialize) {
        emit(AllIntegrationsLoading());
        try {
          List<NangoConnectionPublic> userConnections = [];
          Map<String, SyncInformation?> syncInfoMap = {};
          try {
            NangoUserConnectionsResponseWrapper responseWrapper =
                await NangoEngine.userConnections(
                  isDev: Config.devMode,
                  requestModel: NangoUserConnectionsRequestWrapper(
                    userId: AppUser.user.id,
                  ),
                );
            if (responseWrapper.isSuccess()) {
              userConnections = responseWrapper.response.connections;
            }

            for (NangoConnectionPublic connection in userConnections) {
              try {
                SyncInformation syncInformation = await Application
                    .accessors
                    .userSyncGoogleMailAccessor
                    .getSyncInfo(
                      userId: connection.userId,
                      nangoIntegrationId: connection.id,
                      callerRole: AppUser.currentCallerRole,
                    );
                syncInfoMap[connection.id] = syncInformation;
              } catch (e) {
                syncInfoMap[connection.id] = null;
                Log.w(
                  "Error getting sync info for connection ${connection.id}: ${e.toString()}",
                );
              }
            }
          } catch (e) {
            Log.e("Error getting user connections: ${e.toString()}");
          }
          List<NangoIntegration> availableIntegrations = await Application
              .accessors
              .appDataAccessor
              .getNangoIntegrations(callerRole: AppUser.currentCallerRole);

          Log.d("Firebase loaded all Integrations");
          emit(
            AllIntegrationsInitial(
              userConnections: userConnections,
              syncInfoMap: syncInfoMap,
              availableIntegrations: availableIntegrations,
            ),
          );
        } catch (e) {
          // FirebaseAnalytics log error event
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.errorBloc,
            parameters: {
              "bloc": "AllIntegrationsBloc",
              "event": event.runtimeType.toString(),
              "error": e.toString(),
            },
          );
          Log.e("Error load all Integrations", e);
          emit(
            AllIntegrationsError(
              errorText: Application.appLocalizations!.errorTryAgainLater,
            ),
          );
        }
      }

      if (event is DeleteConnection) {
        emit(AllIntegrationsLoading());
        try {
          Log.d("Firebase delete Integrations");
          add(const AllIntegrationsInitialize());
        } catch (e) {
          // FirebaseAnalytics log error event
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.errorBloc,
            parameters: {
              "bloc": "AllIntegrationsBloc",
              "event": event.runtimeType.toString(),
              "error": e.toString(),
            },
          );
          Log.e("Error delete Integrations", e);
          emit(
            AllIntegrationsError(
              errorText: Application.appLocalizations!.errorTryAgainLater,
            ),
          );
        }
      }
    });
  }
}
