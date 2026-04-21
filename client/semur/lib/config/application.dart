import 'dart:async';
import 'dart:convert';
import 'package:app_links/app_links.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:semur/config/config.dart';
import 'package:semur/config/shared_preferences_keys.dart';
import 'package:semur/global/accessors.dart';
import 'package:semur/global/custom_date_time.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/helpers/platform/network_status.dart';
import 'package:semur/helpers/platform/platform_info.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:semur/services/firebase_analytics_service.dart';
import 'package:semur/services/remote_config_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
import 'package:semur/l10n/app_localizations.dart';

class Application {
  static String? language; // Current language
  // Startup Landing Page

  // Dashboard Refresh Function
  static VoidCallback? refreshDashboard;

  // Version
  static String? minVersion;

  // Store
  static String? storeLink;

  // User
  static StreamSubscription? userSubscription;
  static StreamSubscription? userNotificationsSubscription;

  // AppLink
  static final AppLinks appLinks = AppLinks();

  // Accessors
  static final Accessors accessors = Accessors(firestore);

  // AppLocalizations
  static AppLocalizations? appLocalizations;

  static Future<void> setAppLocalizations(BuildContext context) async {
    appLocalizations = await AppLocalizations.delegate.load(
      Locale(language ?? 'en'),
    );
  }

  // Firebase Analytics
  static final FirebaseAnalyticsService firebaseAnalyticsService =
      FirebaseAnalyticsService(
        analytics: FirebaseAnalytics.instance,
        isDevMode: Config.devMode,
      );

  // Firebase Remote Config
  static final RemoteConfigService remoteConfigService = RemoteConfigService();

  static Future<bool> hasNetwork() async {
    return hasNetworkConnection();
  }

  // Timezone
  static late tz.Location timezone;
  static late CustomDateTime dateTime;

  static Future<void> setupTimezone() async {
    // TODO: Default value
    tz.initializeTimeZones();
    timezone = tz.getLocation('Asia/Tashkent');
    dateTime = CustomDateTime(location: timezone);
  }

  // Version
  static String version = "1.0.0";
  static String buildNumber = "1";

  static Future<void> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

  // Firebase Firestore
  static FirebaseFirestore get firestore {
    if (Config.devMode) {
      return FirebaseFirestore.instanceFor(
        app: Firebase.app(),
        databaseId: 'semur-dev',
      );
    }
    return FirebaseFirestore.instance;
  }

  Application._();

  // Shared Prefs
  static SharedPreferences? get sharedPreferences => _sharedPreferences;
  static SharedPreferences? _sharedPreferences;

  // UUID
  static Uuid uuid = const Uuid();

  // Value Notifier for notifications count
  static ValueNotifier<int> notificationsCountNotifier = ValueNotifier(0);

  static Future<void> setupSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setLanguageFromSharedPrefs() async {
    bool? issetKey = sharedPreferences?.containsKey(
      SharedPreferencesKeys.appLanguage,
    );
    if (issetKey!) {
      language = sharedPreferences?.getString(
        SharedPreferencesKeys.appLanguage,
      );
    }
  }

  // TODO: Move to RemoteConfigService
  static Future<void> getMinVersion() async {
    try {
      if (!Application.remoteConfigService.isActivated) {
        await Application.remoteConfigService.remoteConfig.activate();
      }
      await Application.remoteConfigService.remoteConfig.fetch();
      RemoteConfigValue appDataJson = Application.remoteConfigService.getValue(
        key: RemoteConfigKeys.app_links.name,
      );
      Map appData = jsonDecode(appDataJson.asString());

      if (PlatformInfo.isAndroid) {
        minVersion = appData["minVersionAndroid"];
        storeLink = appData["android"];
      } else if (PlatformInfo.isIOS) {
        minVersion = appData["minVersionIos"];
        storeLink = appData["iOS"];
      }
    } catch (e) {
      Log.e("Error getMinVersion ${e.toString()}");
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;
      if (PlatformInfo.isAndroid) {
        minVersion = currentVersion;
        storeLink = "";
      } else if (PlatformInfo.isIOS) {
        minVersion = currentVersion;
        storeLink = "";
      }
    }
  }

  static set notificationCount(int value) {
    notificationsCountNotifier.value = value;
  }
}

enum PermissionRoles { admin, businessUser, hostUser, user, guest }

enum FirebaseAuthProviders {
  password,
  google,
  facebook,
  twitter,
  github,
  apple,
  yahoo,
  hotmail,
  anonymous,
}

FirebaseAuthProviders firebaseAuthProviderFromString(String string) {
  switch (string.toLowerCase()) {
    case "password":
      return FirebaseAuthProviders.password;
    case "google.com" || "google":
      return FirebaseAuthProviders.google;
    case "facebook.com" || "facebook":
      return FirebaseAuthProviders.facebook;
    case "twitter.com" || "twitter":
      return FirebaseAuthProviders.twitter;
    case "github.com" || "github":
      return FirebaseAuthProviders.github;
    case "apple.com" || "apple":
      return FirebaseAuthProviders.apple;
    case "yahoo.com" || "yahoo":
      return FirebaseAuthProviders.yahoo;
    case "hotmail.com" || "hotmail":
      return FirebaseAuthProviders.hotmail;
    default:
      return FirebaseAuthProviders.anonymous;
  }
}

enum DaysOfWeek { mon, tue, wed, thu, fri, sat, sun }

extension MemberTimeOfDay on TimeOfDay {
  String get toStringFormat {
    return '${_twoDigits(hour)}:${_twoDigits(minute)}';
  }

  static String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  double get toDouble => hour + minute / 60.0;

  bool isBefore(TimeOfDay time) {
    return toDouble < time.toDouble;
  }

  bool isAfter(TimeOfDay time) {
    return toDouble > time.toDouble;
  }

  bool isAtSameMomentAs(TimeOfDay time) {
    return toDouble == time.toDouble;
  }
}
