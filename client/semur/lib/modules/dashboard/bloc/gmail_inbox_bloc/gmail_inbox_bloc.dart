import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:semur/accessors/users/syncs/user_sync_google_mail_accessor.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/models.pb/syncs/sync_google-mail.pb.dart';
import 'package:semur/services/firebase_analytics_service.dart';

part 'gmail_inbox_event.dart';
part 'gmail_inbox_state.dart';

class GmailInboxBloc extends Bloc<GmailInboxEvent, GmailInboxState> {
  GmailInboxBloc() : super(GmailInboxLoading()) {
    on<GmailInboxEvent>((event, emit) async {
      if (event is GmailInboxInitialize) {
        emit(GmailInboxLoading());
        try {
          final (emails, lastDocument) = await Application
              .accessors
              .userSyncGoogleMailAccessor
              .getQueryWithLastDocumentSnapshot(
                callerRole: AppUser.currentCallerRole,
                queryKey:
                    UserSyncGoogleMailAccessorQueryKey.latestWithLastDocument,
                arguments: {
                  "userId": AppUser.user.id,
                  // TODO: Magic value
                  "nangoIntegrationId": "google-mail",
                  "lastDocument": event.lastDocument,
                },
              );

          emit(GmailInboxInitial(emails: emails, lastDocument: lastDocument));
        } catch (e) {
          // FirebaseAnalytics log error event
          Application.firebaseAnalyticsService.logEvent(
            FirebaseAnalyticsEvent.errorBloc,
            parameters: {
              "bloc": "GmailInboxBloc",
              "event": event.runtimeType.toString(),
              "error": e.toString(),
            },
          );
          Log.e("Error load all Integrations", e);
          emit(
            GmailInboxError(
              errorText: Application.appLocalizations!.errorTryAgainLater,
            ),
          );
        }
      }
    });
  }
}
