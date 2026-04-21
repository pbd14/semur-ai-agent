import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:semur/config/application.dart';
import 'package:semur/config/bloc/app_bloc.dart';
import 'package:semur/config/routing/router.dart';
import 'package:semur/global/adaptive_layout_manager.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/global/screens/loading_screen.dart';
import 'package:semur/global/screens/sww_screen.dart';
import 'package:semur/config/shared_preferences_keys.dart';
import 'package:semur/global/widgets/default_modal_bottom_sheet.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/modules/dashboard/screens/home_screen.dart';
import 'package:semur/services/notification_service.dart';
import 'package:semur/global/widgets/default_rounded_button.dart';
import 'package:semur/modules/auth/bloc/auth/auth_bloc.dart';
import 'package:semur/modules/user/widgets/user_accept_policy_card.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  final PageRouteInfo? appLinkRoute;

  const MainScreen({super.key, this.appLinkRoute});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageRouteInfo? appLinkRoute;
  AppBloc? bloc;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.appLinkRoute != null) {
        appLinkRoute = widget.appLinkRoute;
      }
      bloc = BlocProvider.of<AppBloc>(context);
      bloc!.add(AppInitialize(context: context));
    });
    super.initState();
  }

  // Timer
  bool noTimeout = false;
  int _timeout = 120;
  StreamSubscription? sub;
  Timer? _timer;

  void startTimer() {
    _timeout = 120;

    const oneSec = Duration(seconds: 1);

    callback(timer) => {
      if (mounted)
        {
          setState(() {
            if (_timeout < 1) {
              if (_timer != null) {
                _timer!.cancel();
              }
            } else {
              _timeout = _timeout - 1;
            }
          }),
        }
      else
        {
          if (_timeout < 1)
            {
              if (_timer != null) {_timer!.cancel()},
            }
          else
            {_timeout = _timeout - 1},
        },
    };

    _timer = Timer.periodic(oneSec, callback);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: false,
      child: BlocListener(
        bloc: bloc,
        listener: blocListener,
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is AppError) {
              return SomethingWentWrongScreen(error: state.errorText);
            }
            if (state is AppNotActive) {
              return AppNotActiveWidget();
            }
            if (state is AppNeedsUpdate) {
              return AppNeedsUpdateWidget(updateLink: state.updateLink);
            }
            if (state is AppEmail || state is AppEmailError) {
              return Scaffold(
                backgroundColor: AppColors.lightPrimaryColor,
                body: AdaptiveLayoutManager(
                  config: AdaptiveLayoutConfig.allOneColumn().copyWith(
                    maxContentWidth: 600,
                  ),
                  children: [
                    Text(
                      "${Application.appLocalizations!.verifyEmail} (${FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.email : ''})",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineSmall!,
                    ),
                    Text(
                      Application.appLocalizations!.verifyEmailText,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!,
                    ),
                    _sendAgainTimer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: DefaultRoundedButton(
                            color: AppColors.secondaryColor,
                            textColor: AppColors.primaryColor,
                            text: Application.appLocalizations!.check,
                            press: () {
                              bloc!.add(AppVerifyEmail(context: context));
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: DefaultRoundedButton(
                            color: AppColors.primaryColor,
                            textColor: AppColors.secondaryColor,
                            text: Application.appLocalizations!.returnBack,
                            press: () async {
                              BlocProvider.of<AuthBloc>(
                                context,
                              ).add(AuthSignOut());
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            if (state is AppSuccess) {
              return const HomeScreen();
            }
            return const LoadingScreen();
          },
        ),
      ),
    );
  }

  void blocListener(BuildContext context, state) async {
    Log.w("Bloc state changed: $state");
    if (state is AppError) {
      showNotification(state.errorText, NotificationType.error);
    }
    if (state is AppEmailError) {
      startTimer();
      showNotification(state.errorText, NotificationType.error);
    }
    if (state is AppEmail) {
      startTimer();
    }

    if (state is AppUserCreated) {
      context.router.push(EditUserRoute(isSetup: true));
    }
    if (state is AppUserBlocked) {
      // context.router.push(UserBlockedRoute());
    }
    if (state is AppSuccess) {
      if (appLinkRoute != null) {
        context.router.navigate(appLinkRoute!);
        appLinkRoute = null;
      }
      if (!state.isPrivacyDocumentAccepted) {
        DefaultModalBottomSheet(
          context: context,
          isDismissible: false,
          enableDrag: false,
          canPop: false,
        ).show(
          StatefulBuilder(
            builder: (BuildContext context, setStateLocal) {
              return UserAcceptPolicyCard(
                onError: () {
                  Navigator.of(context).pop();
                },
                onPressed: (int policyVersion) {
                  Navigator.of(context).pop();
                  Application.sharedPreferences!.setInt(
                    SharedPreferencesKeys.privacyPolicyVersion,
                    policyVersion,
                  );
                },
              );
            },
          ),
        );
      }
    }
    if (state is AppGuestMode) {
      List<String> allowedRoutes = [];
      if (appLinkRoute != null &&
          allowedRoutes.contains(appLinkRoute!.routeName)) {
        context.router.navigate(appLinkRoute!);
        appLinkRoute = null;
      }
    }
  }

  Widget _sendAgainTimer({isSending = false}) {
    if (isSending) {
      return Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: SpinKitWave(color: AppColors.secondaryColor, size: 50.0),
        ),
      );
    }
    return _timeout > 0
        ? Center(
          child: Column(
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  '${_timeout < 10 ? '0$_timeout' : _timeout.toString()} sec.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () async {},
                  child: Text(
                    Application.appLocalizations!.sendAgain,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        )
        : Center(
          child: TextButton(
            onPressed: () async {
              startTimer();
              try {
                await FirebaseAuth.instance.currentUser!
                    .sendEmailVerification();
              } catch (e) {
                showNotification(
                  Application.appLocalizations!.errorTryAgainLater,
                  NotificationType.error,
                );
              }
            },
            child: Text(
              Application.appLocalizations!.sendAgain,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        );
  }
}

class AppNeedsUpdateWidget extends StatelessWidget {
  final String updateLink;
  const AppNeedsUpdateWidget({super.key, required this.updateLink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimaryColor,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icons/Logo512.png", width: 100),
              const SizedBox(height: 20),
              Text(
                Application.appLocalizations!.updateApp,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: DefaultRoundedButton(
                  color: AppColors.primaryColor,
                  textColor: AppColors.secondaryColor,
                  text: Application.appLocalizations!.updateApp,
                  press: () async {
                    await launchUrl(Uri.parse(updateLink));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppNotActiveWidget extends StatelessWidget {
  const AppNotActiveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimaryColor,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icons/Logo512.png", width: 120),
              const SizedBox(height: 20),
              Text(
                Application.appLocalizations!.appUnavailableText,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
