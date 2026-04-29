import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:semur/accessors/users/user_external_apps_accessor.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/models.pb/external_apps/external_app.pbserver.dart';
import 'package:semur/models.pb/external_apps/telegram_bot_integration.pb.dart';
import 'package:semur/services/firebase_analytics_service.dart';

part 'all_external_app_integrations_event.dart';
part 'all_external_app_integrations_state.dart';

class AllExternalAppIntegrationsBloc
    extends
        Bloc<AllExternalAppIntegrationsEvent, AllExternalAppIntegrationsState> {
  AllExternalAppIntegrationsBloc()
    : super(AllExternalAppIntegrationsLoading()) {
    on<AllExternalAppIntegrationsEvent>((event, emit) async {
      if (event is AllExternalAppIntegrationsInitialize) {
        emit(AllExternalAppIntegrationsLoading());
        try {
          List<ExternalAppIntegration> externalAppIntegrations =
              await Application.accessors.userExternalAppsAccessor.getQuery(
                callerRole: AppUser.currentCallerRole,
                queryKey: UserExternalAppsAccessorQueryKey.all,
                arguments: {"userId": AppUser.user.id},
              );
          emit(
            AllExternalAppIntegrationsInitial(
              externalAppIntegrations: externalAppIntegrations,
            ),
          );
        } catch (e) {
          // FirebaseAnalytics log error event
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.errorBloc,
            parameters: {
              "bloc": "AllExternalAppIntegrationsBloc",
              "event": event.runtimeType.toString(),
              "error": e.toString(),
            },
          );
          Log.e("Error load all Integrations", e);
          emit(
            AllExternalAppIntegrationsError(
              errorText: Application.appLocalizations!.errorTryAgainLater,
            ),
          );
        }
      }

      if (event is AddExternalAppIntegration) {
        emit(AllExternalAppIntegrationsLoading());
        try {
          // TODO: Make this a transaction (atomic)
          await Application.accessors.userExternalAppsAccessor.set(
            app: event.externalAppIntegration,
            callerRole: AppUser.currentCallerRole,
          );
          switch (event.externalAppIntegration.type) {
            case ExternalAppType.TELEGRAM_BOT:
              event.telegramBotIntegration?.userId = AppUser.user.id;
              await Application.accessors.externalAppTelegramBotAccessor.set(
                integration: event.telegramBotIntegration!,
                callerRole: AppUser.currentCallerRole,
              );
              break;
          }

          // Re-fetch data after successful add
          List<ExternalAppIntegration> externalAppIntegrations =
              await Application.accessors.userExternalAppsAccessor.getQuery(
                callerRole: AppUser.currentCallerRole,
                queryKey: UserExternalAppsAccessorQueryKey.all,
                arguments: {"userId": AppUser.user.id},
              );
          emit(
            AllExternalAppIntegrationsInitial(
              externalAppIntegrations: externalAppIntegrations,
            ),
          );
        } catch (e) {
          // FirebaseAnalytics log error event
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.errorBloc,
            parameters: {
              "bloc": "AllExternalAppIntegrationsBloc",
              "event": event.runtimeType.toString(),
              "error": e.toString(),
            },
          );
          Log.e("Error add Integrations", e);
          emit(
            AllExternalAppIntegrationsError(
              errorText: Application.appLocalizations!.errorTryAgainLater,
            ),
          );
        }
      }

      if (event is DeleteExternalAppIntegration) {
        emit(AllExternalAppIntegrationsLoading());
        try {
          ExternalAppIntegration externalAppIntegration = await Application
              .accessors
              .userExternalAppsAccessor
              .get(
                userId: AppUser.user.id,
                appId: event.integrationId,
                callerRole: AppUser.currentCallerRole,
              );

          // TODO: Make this a transaction (atomic)
          await Application.accessors.userExternalAppsAccessor.delete(
            userId: AppUser.user.id,
            appId: event.integrationId,
            callerRole: AppUser.currentCallerRole,
          );
          switch (externalAppIntegration.type) {
            case ExternalAppType.TELEGRAM_BOT:
              await Application.accessors.externalAppTelegramBotAccessor.delete(
                integrationId:
                    externalAppIntegration
                        .metadata["telegramBotIntegrationId"] ??
                    "N/A",
                callerRole: AppUser.currentCallerRole,
              );
              break;
          }

          // Re-fetch data after successful delete
          List<ExternalAppIntegration> externalAppIntegrations =
              await Application.accessors.userExternalAppsAccessor.getQuery(
                callerRole: AppUser.currentCallerRole,
                queryKey: UserExternalAppsAccessorQueryKey.all,
                arguments: {"userId": AppUser.user.id},
              );
          emit(
            AllExternalAppIntegrationsInitial(
              externalAppIntegrations: externalAppIntegrations,
            ),
          );
        } catch (e) {
          // FirebaseAnalytics log error event
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.errorBloc,
            parameters: {
              "bloc": "AllExternalAppIntegrationsBloc",
              "event": event.runtimeType.toString(),
              "error": e.toString(),
            },
          );
          Log.e("Error delete Integrations", e);
          emit(
            AllExternalAppIntegrationsError(
              errorText: Application.appLocalizations!.errorTryAgainLater,
            ),
          );
        }
      }
    });
  }
}
