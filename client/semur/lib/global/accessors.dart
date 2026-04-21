import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semur/accessors/app_data_accessor.dart';
import 'package:semur/accessors/external_apps/external_app_telegram_bot_accessor.dart';
import 'package:semur/accessors/users/user_accessor.dart';
import 'package:semur/accessors/users/user_chat_accessor.dart';
import 'package:semur/accessors/users/syncs/user_sync_google_mail_accessor.dart';
import 'package:semur/accessors/users/user_external_apps_accessor.dart';

class Accessors {
  final FirebaseFirestore firestore;

  Accessors(this.firestore);

  AppDataAccessor get appDataAccessor => AppDataAccessor(firestore: firestore);

  // External Apps
  ExternalAppTelegramBotAccessor get externalAppTelegramBotAccessor =>
      ExternalAppTelegramBotAccessor(firestore: firestore);

  // Users
  UserAccessor get userAccessor => UserAccessor(firestore: firestore);
  UserChatAccessor get userChatAccessor =>
      UserChatAccessor(firestore: firestore);
  UserExternalAppsAccessor get userExternalAppsAccessor =>
      UserExternalAppsAccessor(firestore: firestore);
  UserSyncGoogleMailAccessor get userSyncGoogleMailAccessor =>
      UserSyncGoogleMailAccessor(firestore: firestore);
}
