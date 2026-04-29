import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:semur/config/application.dart';
import 'package:semur/config/bloc/app_bloc.dart';
import 'package:semur/config/config.dart';
import 'package:semur/config/routing/router.dart';
import 'package:semur/config/shared_preferences_keys.dart';
import 'package:semur/firebase_options.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/global/log/log.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:semur/l10n/app_localizations.dart';
import 'package:semur/global/screens/loading_screen.dart';
import 'package:semur/models.pb/external_apps/telegram_bot_integration.pbserver.dart';
import 'package:semur/models.pb/google/protobuf/timestamp.pb.dart' as pb;
import 'package:semur/modules/auth/bloc/auth/auth_bloc.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Log.i("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  Log.initialize();

  WidgetsFlutterBinding.ensureInitialized();
  // This will make splash appear longer
  // FlutterNativeSplash.preserve(widgetsBinding: binding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (Config.useFirebaseEmulators) {
    FirebaseFirestore.instance.useFirestoreEmulator(
      Config.firebaseEmulatorHost,
      8080,
    );
    FirebaseFunctions.instance.useFunctionsEmulator(
      Config.firebaseEmulatorHost,
      5001,
    );
    await FirebaseAuth.instance.useAuthEmulator(
      Config.firebaseEmulatorHost,
      9099,
    );
  }

  // App Check
  // if (!kDebugMode) {
  //   await FirebaseAppCheck.instance.activate(
  //     webProvider: ReCaptchaEnterpriseProvider(
  //         '6Ld9wpspAAAAAODVblVQTLIBIzmJKEhwDdQRoe3m'),
  //     androidProvider: AndroidProvider.playIntegrity,
  //     appleProvider: AppleProvider.appAttest,
  //   );
  // } else {
  //   Log.d("App Check Debug Mode");
  //   await FirebaseAppCheck.instance.activate(
  //     webProvider: ReCaptchaEnterpriseProvider(
  //         '6Ld9wpspAAAAAODVblVQTLIBIzmJKEhwDdQRoe3m'),
  //     androidProvider: AndroidProvider.debug,
  //     appleProvider: AppleProvider.debug,
  //   );
  // }

  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color.fromRGBO(240, 252, 255, 1.0),
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // URL for web
  Config.setUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<MyAppState>();
    state?.setLocale(newLocale);
  }

  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Key key = UniqueKey();
  bool _initialized = false;
  final _appRouter = AppRouter();
  final authBloc = AuthBloc();
  final appBloc = AppBloc();

  void setLocale(Locale locale) {
    setState(() {});
  }

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  // void _handleNotificationMessage(RemoteMessage message) {
  //   if (message.data.containsKey("id")) {
  //     String notificationId = message.data["id"];
  //     handleAppLink(
  //       Uri.parse(
  //         "https://app.semur.ai/user/notifications/$notificationId",
  //       ),
  //     );
  //   } else {
  //     handleAppLink(Uri.parse("https://app.semur.ai/"));
  //   }
  // }

  Future<void> startApplication() async {
    Log.d("Starting Application");
    try {
      await Application.getVersion();
      await Application.setupSharedPreferences();
      await Application.setupTimezone();
      await Application.setLanguageFromSharedPrefs();
      await Application.setAppLocalizations();
      // await Config.init();
      // RegulaService.initConfig = regula.InitConfig(await rootBundle.load("assets/regula.license"));

      await AppColors.init();
      // TODO: Default CSC
      await Application.sharedPreferences!.setString(
        SharedPreferencesKeys.userCountry,
        "Uzbekistan",
      );
      await Application.sharedPreferences!.setString(
        SharedPreferencesKeys.userState,
        "Tashkent",
      );
      await Application.sharedPreferences!.setString(
        SharedPreferencesKeys.userCity,
        "Tashkent",
      );

      // Set up the URI link stream listener
      Application.appLinks.uriLinkStream.listen((uri) {
        handleAppLink(uri);
      });

      // Also check for initial link
      // final initialUri = await Application.appLinks.getInitialLink();
      // if (initialUri != null) {
      //   handleAppLink(initialUri);
      // }

      // // Get any messages which caused the application to open from
      // // a terminated state.
      // RemoteMessage? initialMessage =
      //     await FirebaseMessaging.instance.getInitialMessage();

      // // If the message also contains a data property with a "type" of "chat",
      // // navigate to a chat screen
      // if (initialMessage != null) {
      //   _handleNotificationMessage(initialMessage);
      // }

      // // Also handle any interaction when the app is in the background via a
      // // Stream listener
      // FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationMessage);

      // This will remove the splash screen
      // FlutterNativeSplash.remove();
    } catch (e) {
      Log.e("Error in startApplication: $e");
    }
  }

  // Extract URI handling logic to a separate method
  void handleAppLink(Uri uri) {
    Log.d("APP LINK ${uri.path}");
    // Remove # if present at the beginning of the path
    if (uri.path.startsWith('#')) {
      uri = Uri.parse(uri.path.substring(1));
    }

    // Expecting /external/telegram/connect?&chatId=${chatId}&username=${ctx.from?.username || ""}&userFirstName=${ctx.from?.first_name || ""}&userLastName=${ctx.from?.last_name || ""}
    if (uri.path.startsWith("/external/telegram/connect") &&
        uri.pathSegments.length == 3) {
      // Pop Until Root if the app is already open
      if (_appRouter.pageCount > 0) {
        _appRouter.popUntilRoot();
      }

      try {
        final queryParams = uri.queryParameters;
        final chatId = queryParams['chatId'];
        final username = queryParams['username'];
        final userFirstName = queryParams['userFirstName'];
        final userLastName = queryParams['userLastName'];
        final TelegramBotIntegration newTelegramBotIntegration =
            TelegramBotIntegration(
              id: chatId,
              username: username ?? "",
              userId: AppUser.user.id,
              userFirstName: userFirstName ?? "",
              userLastName: userLastName ?? "",
              integrationStatus:
                  TelegramBotIntegrationStatus.TELEGRAM_BOT_ACTIVE,
              createdAt: pb.Timestamp.fromDateTime(DateTime.now()),
            );
        _appRouter.navigate(
          WelcomeRoute(
            appLinkRoute: AllExternalAppIntegrationsRoute(
              newTelegramBotIntegration: newTelegramBotIntegration,
            ),
          ),
        );
      } catch (e) {
        Log.e("App Link External App Error ${e.toString()}");
        _appRouter.navigate(
          WelcomeRoute(appLinkRoute: AllExternalAppIntegrationsRoute()),
        );
      }
    } else {
      if (FirebaseAuth.instance.currentUser != null &&
          AppUser.user.id.isNotEmpty) {
        try {
          _appRouter.navigateNamed(uri.path);
        } catch (e) {
          Log.e("APP LINK ERROR ${uri.path}", e);
          _appRouter.push(WelcomeRoute());
        }
      } else {
        _appRouter.push(WelcomeRoute());
      }
    }
  }

  @override
  void initState() {
    startApplication().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _initialized = true;
      });
    });

    // Add this lifecycle listener
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    if (!_initialized) {
      return OverlaySupport(
        child: MaterialApp(
          debugShowCheckedModeBanner: Config.devMode,
          title: 'Semur',
          home: Scaffold(
            body: Center(
              child: Container(
                constraints: BoxConstraints(minHeight: size.height - 80),
                child: const LoadingScreen(),
              ),
            ),
          ),
        ),
      );
    }
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<AuthBloc>(create: (BuildContext context) => authBloc),
        BlocProvider<AppBloc>(create: (BuildContext context) => appBloc),
      ],
      child: OverlaySupport(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: Config.devMode,
          title: 'Semur',
          locale: Locale(Application.language ?? "en"),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('ru'), // Russian
            // Locale('uz'), // Uzbek
          ],
          theme: ThemeData(
            useMaterial3: false,
            primaryColor: AppColors.secondaryColor,
            fontFamily: "Default",
            scaffoldBackgroundColor: AppColors.whiteColor,
            inputDecorationTheme: InputDecorationTheme(
              filled: false,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 15.0,
              ),
              hintStyle: TextStyle(
                color: AppColors.primaryColor.withValues(alpha: 0.7),
                fontWeight: FontWeight.w400,
              ),
              prefixStyle: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
              ),
              errorStyle: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
                // fontSize: 18.0,
              ),
              counterStyle: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 0.0,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            textTheme: TextTheme(
              displayLarge: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 57,
                fontWeight: FontWeight.w700,
              ),
              displayMedium: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 45,
                fontWeight: FontWeight.w600,
              ),
              displaySmall: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 36,
                fontWeight: FontWeight.w600,
              ),
              headlineLarge: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
              headlineMedium: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
              headlineSmall: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.darkColor,
              ),
              titleLarge: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.darkColor,
              ),
              titleMedium: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.darkColor,
              ),
              titleSmall: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.darkColor,
              ),
              bodyLarge: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.darkColor,
              ),
              bodyMedium: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.darkColor,
              ),
              bodySmall: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.darkColor,
              ),
              labelLarge: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.darkColor,
              ),
              labelMedium: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.darkColor,
              ),
              labelSmall: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColors.darkColor,
              ),
            ),
            cardTheme: CardThemeData(
              color: AppColors.lightPrimaryColor,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: AppColors.lightPrimaryColor,
              titleTextStyle: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              contentTextStyle: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              iconColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            bottomAppBarTheme: const BottomAppBarThemeData(
              color: Colors.transparent,
            ),
          ),
          routerConfig: _appRouter.config(
            includePrefixMatches: true,
            // deepLinkBuilder: (deepLink) {
            //   Log.w("DEEP LINK ${deepLink.uri}");
            //   if (deepLink.path
            //       .startsWith('/bookings/payment/status/:bookingId')) {
            //     return deepLink;
            //   } else if (deepLink.path.startsWith('/#/user/edit')) {
            //     return deepLink;
            //   } else {
            //     return DeepLink.defaultPath;
            //   }
            // },
          ),
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
        ),
      ),
    );
  }
}
