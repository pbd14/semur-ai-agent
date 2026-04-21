import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RemoteConfigService {
  final remoteConfig = FirebaseRemoteConfig.instance;
  bool isActivated = false;
  Map<String, ValueNotifier<RemoteConfigValue>> valueNotifiers = {};

  Future<void> init() async {
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );

      isActivated = await remoteConfig.fetchAndActivate();
      if (!kIsWeb) {
        await setSubscription();
      }
    } catch (e) {
      throw Exception("Error while fetching remote config ${e.toString()}");
    }
  }

  Future<void> setSubscription() async {
    remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();
      for (String key in event.updatedKeys) {
        if (valueNotifiers.containsKey(key) && valueNotifiers[key] != null) {
          valueNotifiers[key]!.value = remoteConfig.getValue(key);
        } else {
          valueNotifiers[key] = ValueNotifier(remoteConfig.getValue(key));
        }
      }
    });
  }

  String getString({required String key}) {
    try {
      return remoteConfig.getString(key);
    } catch (e) {
      throw Exception("Error while getting remote config ${e.toString()}");
    }
  }

  int getInt({required String key}) {
    try {
      return remoteConfig.getInt(key);
    } catch (e) {
      throw Exception("Error while getting remote config ${e.toString()}");
    }
  }

  bool getBool({required String key}) {
    try {
      return remoteConfig.getBool(key);
    } catch (e) {
      throw Exception("Error while getting remote config ${e.toString()}");
    }
  }

  double getDouble({required String key}) {
    try {
      return remoteConfig.getDouble(key);
    } catch (e) {
      throw Exception("Error while getting remote config ${e.toString()}");
    }
  }

  RemoteConfigValue getValue({required String key}) {
    try {
      return remoteConfig.getValue(key);
    } catch (e) {
      throw Exception("Error while getting remote config ${e.toString()}");
    }
  }

  Future<ValueNotifier<RemoteConfigValue>> getValueNotifier({
    required String key,
  }) async {
    try {
      if (!isActivated) {
        isActivated = await remoteConfig.fetchAndActivate();
      }
      if (kIsWeb) {
        await remoteConfig.fetchAndActivate();
        return ValueNotifier(remoteConfig.getValue(key));
      }
      if (!valueNotifiers.containsKey(key) || valueNotifiers[key] == null) {
        valueNotifiers[key] = ValueNotifier(remoteConfig.getValue(key));
      }
      return valueNotifiers[key]!;
    } catch (e) {
      throw Exception(
        "Error while getting value notifier ${e.toString()} with key $key",
      );
    }
  }
}

enum RemoteConfigKeys {
  // ignore: constant_identifier_names
  app_links,
  isAndroidActiveSemur,
  isIosActiveSemur,
  isWebActiveSemur,
}
