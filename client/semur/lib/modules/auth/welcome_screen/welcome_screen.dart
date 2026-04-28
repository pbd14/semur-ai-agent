import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:semur/config/application.dart';
import 'package:semur/config/routing/router.dart';
import 'package:semur/global/screens/loading_screen.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/helpers/formatters/custom_masked_text_controller.dart';
import 'package:semur/services/firebase_analytics_service.dart';
import 'package:semur/services/notification_service.dart';
import 'package:semur/global/widgets/custom_dialog.dart';
import 'package:semur/global/widgets/default_rounded_button.dart';
import 'package:semur/modules/auth/bloc/auth/auth_bloc.dart';
import 'package:semur/modules/auth/welcome_screen/auth_email_sign_in_initial_screen.dart';
import 'package:semur/modules/auth/welcome_screen/auth_email_sign_up_initial_screen.dart';
import 'package:semur/modules/auth/welcome_screen/auth_initial_screen.dart';
import 'package:semur/modules/user/widgets/settings_language_card.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class WelcomeScreen extends StatefulWidget {
  final PageRouteInfo? appLinkRoute;

  const WelcomeScreen({
    super.key,
    this.appLinkRoute,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController phoneController = CustomMaskedTextController(
    text: '',
    mask: '([0][0][0]) [0][0] [0][0][0] [0][0] [0][0]',
  );
  final CustomMaskedTextController _smsCodeController =
      CustomMaskedTextController(
    text: '',
    mask: '[0] [0] [0] [0] [0] [0]',
  );

  AuthBloc? _bloc;
  String phoneNo = "";
  String smsCode = "";

  // Timer
  bool noTimeout = false;
  int _timeout = 60;
  StreamSubscription? sub;
  Timer? _timer;

  PageRouteInfo? appLinkRoute;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Application.firebaseAnalyticsService.logEvent(
        FirebaseAnalyticsEvent.openScreen,
        parameters: {
          "screen_name": "WelcomeScreen",
        },
      );
      appLinkRoute = widget.appLinkRoute;
      _bloc = BlocProvider.of<AuthBloc>(context);
      _bloc!.add(AuthInitialize(
        context: context,
      ));
    });
    super.initState();
  }

  // If page is updated by router
  @override
  void didUpdateWidget(WelcomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.appLinkRoute != null &&
        (oldWidget.appLinkRoute == null ||
            widget.appLinkRoute?.routeName !=
                oldWidget.appLinkRoute?.routeName)) {
      setState(() {
        appLinkRoute = widget.appLinkRoute;
      });

      // If already signed in, navigate to the new route
      if (_bloc != null && _bloc!.state is AuthStatusSignedIn) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.router.navigate(MainRoute(appLinkRoute: appLinkRoute));
        });
      }
    }
  }

  @override
  void dispose() {
    // _bloc!.close();
    sub?.cancel();
    phoneController.dispose();
    _smsCodeController.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  void startTimer() {
    _timeout = 60;

    const oneSec = Duration(seconds: 1);

    callback(timer) => {
          setState(() {
            if (_timeout < 1) {
              if (_timer != null) {
                _timer!.cancel();
              }
            } else {
              _timeout = _timeout - 1;
            }
          })
        };

    _timer = Timer.periodic(oneSec, callback);
  }

  void blocListener(BuildContext context, AuthState state) {
    if (state is AuthStatusSignedOut) {
      context.router.navigate(WelcomeRoute());
    }
    if (state is AuthStatusSignedIn) {
      _smsCodeController.clear();
      noTimeout = true;
      context.router.navigate(MainRoute(
        appLinkRoute: appLinkRoute,
      ));
      appLinkRoute = null;
    }

    // Phone Auth
    if (state is AuthPhoneSignInError) {
      _smsCodeController.clear();
      showNotification(state.exception, NotificationType.error);
    }
    if (state is AuthPhoneSignInSmsError) {
      _smsCodeController.clear();
      showNotification(
        Application.appLocalizations!.authWrongCode,
        NotificationType.error,
      );
    }
    if (state is AuthPhoneSignInTimeout) {
      _smsCodeController.clear();
      if (!noTimeout) {
        showNotification(
          Application.appLocalizations!.authTimeout,
          NotificationType.error,
        );
      }
    }
    if (state is AuthPhoneSignInVerified) {
      _smsCodeController.clear();
      showNotification(
        Application.appLocalizations!.authAuthorized,
        NotificationType.success,
      );
      _bloc!.add(AuthPhoneSignIn(authCredential: state.authCredential));
    }
    if (state is AuthPhoneSignInSmsSent) {
      startTimer();
      noTimeout = true;
    }

    // Email Auth
    if (state is AuthEmailSignInError) {
      showNotification(
        state.errorText,
        NotificationType.error,
      );
      _bloc!.add(AuthEmit(state: AuthEmailSignInInitial()));
    }
    if (state is AuthEmailSignUpError) {
      showNotification(
        state.errorText,
        NotificationType.error,
      );
      _bloc!.add(AuthEmit(state: state.state));
    }

    // Google
    if (state is AuthGoogleError) {
      showNotification(
        state.errorText,
        NotificationType.error,
      );
      _bloc!.add(AuthEmit(state: AuthInitial()));
    }

    // Apple
    if (state is AuthAppleError) {
      showNotification(
        state.errorText,
        NotificationType.error,
      );
      _bloc!.add(AuthEmit(state: AuthInitial()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: BlocListener(
              bloc: _bloc,
              listener: blocListener,
              child: BlocBuilder(
                bloc: _bloc,
                builder: (BuildContext context, AuthState state) {
                  if (state is AuthLoading) {
                    return const LoadingScreen();
                  }

                  // Init
                  if (state is AuthInitial) {
                    return AuthInitialScreen(
                      bloc: _bloc,
                      appLinkRoute: appLinkRoute,
                      setAppLinkRoute: (route) {
                        safeSetState(() {
                          appLinkRoute = route;
                        });
                      },
                    );
                  }

                  // Phone Auth
                  if (state is AuthPhoneSignInSmsError) {
                    return Container(
                      constraints: BoxConstraints(
                        maxWidth: kIsWeb ? 600 : double.infinity,
                        minHeight: size.height - 80,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Application.appLocalizations!.smsCode,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: 48),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  Application
                                      .appLocalizations!.authEnterSmsCode,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                validator: (val) => val!.length < 11
                                    ? '${Application.appLocalizations!.minCharacters} 6'
                                    : null,
                                controller: _smsCodeController,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                cursorColor: AppColors.primaryColor,
                                style: TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor),
                                autofocus: true,
                                decoration: const InputDecoration()
                                    .applyDefaults(
                                        Theme.of(context).inputDecorationTheme),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              _smsTimer(),
                              const SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: DefaultRoundedButton(
                                  color: AppColors.primaryColor,
                                  textColor: AppColors.secondaryColor,
                                  text: Application.appLocalizations!.send,
                                  press: () {
                                    if (_formKey.currentState!.validate()) {
                                      _bloc!.add(AuthPhoneSignInWithOTP(
                                        context: context,
                                        smsCode: _smsCodeController.text
                                            .replaceAll(RegExp(r'[^0-9]'), ''),
                                        verId: state.verId,
                                      ));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () async {
                              await launchUrl(Uri.https(
                                  'semur.ai', '/docs/privacy-policy.html'));
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Text(Application.appLocalizations!.terms,
                                  textScaler: const TextScaler.linear(1),
                                  style: Theme.of(context).textTheme.bodySmall),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is AuthPhoneSignInSmsSent) {
                    return Container(
                      constraints: BoxConstraints(
                        minHeight: size.height - 80,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Application.appLocalizations!.smsCode,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: 48),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  Application
                                      .appLocalizations!.authEnterSmsCode,
                                  style: Theme.of(context).textTheme.bodyLarge),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                validator: (val) => val!.length < 11
                                    ? '${Application.appLocalizations!.minCharacters} 6'
                                    : null,
                                controller: _smsCodeController,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                cursorColor: AppColors.primaryColor,
                                style: TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor),
                                autofocus: true,
                                decoration: const InputDecoration()
                                    .applyDefaults(
                                        Theme.of(context).inputDecorationTheme),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              _smsTimer(),
                              const SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: DefaultRoundedButton(
                                  color: AppColors.primaryColor,
                                  textColor: AppColors.secondaryColor,
                                  text: Application.appLocalizations!.send,
                                  press: () {
                                    if (_formKey.currentState!.validate()) {
                                      _bloc!.add(AuthPhoneSignInWithOTP(
                                        context: context,
                                        smsCode: _smsCodeController.text
                                            .replaceAll(RegExp(r'[^0-9]'), ''),
                                        verId: state.verId,
                                      ));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () async {
                              await launchUrl(Uri.https(
                                  'semur.ai', '/docs/privacy-policy.html'));
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Text(Application.appLocalizations!.terms,
                                  textScaler: const TextScaler.linear(1),
                                  style: Theme.of(context).textTheme.bodySmall),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is AuthPhoneInitial) {
                    return Center(
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: kIsWeb ? 600 : double.infinity,
                          minHeight: size.height - 80,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: kIsWeb ? 600 * 0.7 : size.width,
                              ),
                              child: Text(
                                Application.appLocalizations!.welcome,
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(fontSize: 48),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Application.appLocalizations!.enterPhoneNo,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: phoneController,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                  cursorColor: AppColors.secondaryColor,
                                  validator: (val) => val!.isEmpty
                                      ? Application
                                          .appLocalizations!.enterPhoneNo
                                      : null,
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) {
                                    setState(() {
                                      phoneNo = val;
                                    });
                                  },
                                  decoration: const InputDecoration()
                                      .applyDefaults(Theme.of(context)
                                          .inputDecorationTheme)
                                      .copyWith(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Text(
                                            '+',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ),
                                        // hintText: "Телефон",
                                      ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Center(
                                  child: DefaultRoundedButton(
                                    color: AppColors.secondaryColor,
                                    textColor: AppColors.primaryColor,
                                    text: Application.appLocalizations!.send,
                                    press: () {
                                      if (_formKey.currentState!.validate()) {
                                        _bloc!.add(AuthPhoneSignInSendSms(
                                            context: context,
                                            phoneNo: phoneNo));
                                        // showDialog(
                                        //   barrierDismissible: false,
                                        //   context: context,
                                        //   builder: (BuildContext context) {
                                        //     return CustomDialog(
                                        //       title: AppLocalizations.of(
                                        //               context)!
                                        //           .sure,
                                        //       text: '+$phoneNo?',
                                        //       onSubmitted: () {
                                        //         _bloc!.add(
                                        //             AuthPhoneSignInSendSms(
                                        //                 phoneNo: phoneNo));
                                        //         Navigator.of(context)
                                        //             .pop(false);
                                        //       },
                                        //     );
                                        //   },
                                        // );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  _bloc!.add(AuthEmit(state: AuthInitial()));
                                },
                                child: Container(
                                    // width: pw == 0 ? size.width * width : pw,
                                    height: 45,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(25),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.back,
                                          color: AppColors.lightPrimaryColor,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          Application.appLocalizations!.back,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color:
                                                    AppColors.lightPrimaryColor,
                                                fontWeight: FontWeight.w700,
                                                // fontSize: 24,
                                              ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const SettingsLanguageCard(),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: () async {
                                await launchUrl(Uri.https(
                                    'semur.ai', '/docs/privacy-policy.html'));
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Text(
                                  Application.appLocalizations!.terms,
                                  textScaler: const TextScaler.linear(1),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (state is AuthStatusSignedIn) {
                    return Container(
                      constraints: BoxConstraints(
                        minHeight: size.height - 80,
                      ),
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/Logo512.png",
                            width: 64,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: DefaultRoundedButton(
                              color: AppColors.primaryColor,
                              textColor: AppColors.secondaryColor,
                              text: Application.appLocalizations!.continueText,
                              press: () {
                                _bloc!.add(AuthInitialize(
                                  context: context,
                                ));
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // Email Auth
                  // Email Auth Sign Up
                  if (state is AuthEmailSignUpInitial) {
                    return AuthEmailSignUpInitialScreen(
                      bloc: _bloc,
                    );
                  }
                  // Email Auth Sign In
                  if (state is AuthEmailSignInInitial) {
                    return AuthEmailSignInInitialScreen(
                      bloc: _bloc,
                    );
                  }

                  return const LoadingScreen();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void safeSetState(void Function() updateFunction) {
    if (mounted) {
      setState(() {
        updateFunction();
      });
    } else {
      updateFunction();
    }
  }

  Widget _smsTimer({
    isSending = false,
  }) {
    if (isSending) {
      return Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: SpinKitWave(
            color: AppColors.secondaryColor,
            size: 50.0,
          ),
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
                      '00:${_timeout < 10 ? '0$_timeout' : _timeout.toString()}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          )),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialog(
                          title: Application.appLocalizations!.authChangePhone,
                          text:
                              '${Application.appLocalizations!.authSmsSentTo} +$phoneNo ',
                          onSubmitted: () {
                            noTimeout = true;
                            _bloc!.add(const AuthReset());
                            Navigator.of(context).pop(false);
                          },
                        );
                      },
                    );
                  },
                  child: Text(Application.appLocalizations!.authChangePhone,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.primaryColor)),
                ),
              ],
            ),
          )
        : Center(
            child: TextButton(
              onPressed: () {
                _bloc!.add(AuthPhoneSignInSendSms(
                  context: context,
                  phoneNo: phoneNo,
                ));
              },
              child: Text(Application.appLocalizations!.sendAgain,
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
          );
  }
}
