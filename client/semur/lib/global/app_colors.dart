import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:semur/config/application.dart';
import 'package:semur/config/shared_preferences_keys.dart';

// Theme keys
enum AppTheme { classic }

class AppColors {
  AppColors._();

  static List<AppTheme> themes = AppTheme.values;

  static ValueNotifier<AppTheme> themeNotifier = ValueNotifier(
    AppTheme.classic,
  );

  static AppTheme get theme => themeNotifier.value;

  static Future<void> init() async {
    if (Application.sharedPreferences!.containsKey(
      SharedPreferencesKeys.theme,
    )) {
      themeNotifier.value =
          themes[int.parse(
            Application.sharedPreferences?.getString(
                  SharedPreferencesKeys.theme,
                ) ??
                "0",
          )];
    } else {
      await Application.sharedPreferences?.setString(
        SharedPreferencesKeys.theme,
        '0',
      );
    }
    setColors();
  }

  static Future<void> setTheme(int themeId) async {
    themeNotifier.value = themes[themeId];
    await Application.sharedPreferences?.setString(
      SharedPreferencesKeys.theme,
      themeId.toString(),
    );
    setColors();
  }

  static void setColors() {
    if (themeNotifier.value == AppTheme.classic) {
      lightPrimaryColor = const Color.fromARGB(255, 136, 167, 238);
      primaryColor = const Color.fromRGBO(30, 24, 59, 1.0); // #0a2463
      lightSecondaryColor = const Color.fromRGBO(191, 173, 213, 1.0);
      secondaryColor = const Color.fromARGB(255, 127, 75, 191);
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Color.fromRGBO(240, 252, 255, 1.0),
          systemNavigationBarDividerColor: Colors.transparent,
        ),
      );
    } else {
      lightPrimaryColor = const Color.fromARGB(255, 136, 167, 238);
      primaryColor = const Color.fromRGBO(30, 24, 59, 1.0); // #0a2463
      lightSecondaryColor = const Color.fromRGBO(191, 173, 213, 1.0);
      secondaryColor = const Color.fromARGB(255, 127, 75, 191);
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Color.fromRGBO(240, 252, 255, 1.0),
          systemNavigationBarDividerColor: Colors.transparent,
        ),
      );
    }
  }

  static Color lightPrimaryColor = const Color.fromARGB(255, 136, 167, 238);
  static Color primaryColor = const Color.fromRGBO(30, 24, 59, 1.0); // #0a2463
  static Color lightSecondaryColor = const Color.fromRGBO(191, 173, 213, 1.0);
  static Color secondaryColor = const Color.fromARGB(255, 127, 75, 191);

  static Color semurLightPrimaryColor = const Color.fromRGBO(
    245,
    245,
    220,
    1.0,
  );
  static Color semurPrimaryColor = const Color.fromRGBO(0, 66, 37, 1.0);
  static Color semurLightSecondaryColor = const Color.fromRGBO(
    255,
    208,
    157,
    1.0,
  );
  static Color semurSecondaryColor = const Color.fromRGBO(255, 176, 0, 1.0);

  static Color ozodLightPrimaryColor = const Color.fromRGBO(111, 234, 138, 1.0);
  static Color ozodPrimaryColor = const Color.fromRGBO(60, 132, 77, 1.0);
  static Color ozodDarkPrimaryColor = const Color.fromRGBO(23, 50, 34, 1.0);
  static Color ozodSecondaryColor = const Color.fromRGBO(242, 202, 102, 1.0);

  static Color whiteColor = const Color.fromARGB(255, 242, 246, 247); // #f0fcff
  static Color darkWhiteColor = const Color.fromARGB(
    255,
    236,
    240,
    241,
  ); // #D3D3D3
  static Color lightGrayColor = const Color.fromARGB(
    255,
    221,
    224,
    225,
  ); // #D3D3D3
  static Color darkColor = const Color.fromRGBO(30, 39, 46, 1.0); // #1E272E
  static const lightDarkColor = Color.fromRGBO(105, 105, 105, 1.0);
  static const darkDarkColor = Color.fromRGBO(13, 13, 13, 1.0);
  static const greenColor = Color.fromARGB(255, 0, 171, 126);

  static const ozodIdColor1 = Color.fromARGB(255, 26, 221, 208);
  static const ozodIdColor2 = Color.fromARGB(255, 19, 39, 80);

  // static const LinearGradient mainGradient = LinearGradient(
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  //   colors: [
  //     Color(0xffFF4B4B),
  //     Color(0xffD3353E),
  //   ],
  // );
  // static List<BoxShadow> mainShadow = <BoxShadow>[
  //   BoxShadow(
  //     color: Colors.black.withValues(alpha:0.15),
  //     blurRadius: 4.0,
  //     offset: Offset(0, 4),
  //   ),
  // ];
}
