import 'package:flutter/material.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/config/shared_preferences_keys.dart';
import 'package:semur/global/log/log.dart';
import '../../main.dart';

Future<Locale> setLocale(String languageCode) async {
  await Application.sharedPreferences
      ?.setString(SharedPreferencesKeys.appLanguage, languageCode);
  await Application.setLanguageFromSharedPrefs();
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  Log.d("Getting app language");
  String languageCode = "ru";
  if (Application.sharedPreferences!
      .containsKey(SharedPreferencesKeys.appLanguage)) {
    languageCode = Application.sharedPreferences
            ?.getString(SharedPreferencesKeys.appLanguage) ??
        "ru";
  } else {
    await Application.sharedPreferences
        ?.setString(SharedPreferencesKeys.appLanguage, 'ru');
    languageCode = "ru";
  }
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return languageCode.isNotEmpty
      ? Locale(languageCode, '')
      : const Locale('ru', '');
}

void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  Log.d("Chaging language to $selectedLanguageCode");
  var locale = await setLocale(selectedLanguageCode);
  await Application.setAppLocalizations(context);
  MyApp.setLocale(context, locale);

  // Update firestore
  if (AppUser.user.hasId()) {
    try {
      AppUser.user.language = selectedLanguageCode.toLowerCase();
      await Application.firestore
          .collection("users")
          .doc(AppUser.user.id)
          .update({
        "language": selectedLanguageCode.toLowerCase(),
      });
    } catch (e) {
      Log.e("Error updating user language in firestore: $e");
    }
  }
}
