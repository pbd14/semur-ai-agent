import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:semur/config/application.dart';
import 'package:semur/config/routing/router.dart';
import 'package:semur/global/adaptive_layout_manager.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/helpers/platform/platform_info.dart';
import 'package:semur/modules/auth/bloc/auth/auth_bloc.dart';
import 'package:semur/modules/auth/welcome_screen/widgets/app_policy_button.dart';
import 'package:semur/modules/auth/welcome_screen/widgets/auth_option_button.dart';
import 'package:semur/modules/user/widgets/settings_language_card.dart';

class AuthInitialScreen extends StatelessWidget {
  const AuthInitialScreen({
    super.key,
    required AuthBloc? bloc,
    required this.appLinkRoute,
    required this.setAppLinkRoute,
  }) : _bloc = bloc;

  final AuthBloc? _bloc;
  final PageRouteInfo? appLinkRoute;
  final Function(PageRouteInfo?) setAppLinkRoute;

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayoutManager(
      config: AdaptiveLayoutConfig.allOneColumn().copyWith(
        maxContentWidth: 600,
      ),
      children: [
        Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.sizeOf(context).height - 80,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Image.asset("assets/icons/Logo512.png", width: 100),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      Application.appLocalizations!.welcome,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: Theme.of(context).textTheme.headlineLarge!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODO: Phone Auth
                  // Center(
                  //   child: CupertinoButton(
                  //     padding: EdgeInsets.zero,
                  //     onPressed: () {
                  //       _bloc!.add(AuthEmit(
                  //           state: AuthPhoneInitial()));
                  //     },
                  //     child: Container(
                  //         // width: pw == 0 ? size.width * width : pw,
                  //         height: 45,
                  //         padding: const EdgeInsets.all(10),
                  //         decoration: BoxDecoration(
                  //           color: AppColors.primaryColor,
                  //           borderRadius:
                  //               BorderRadius.circular(25),
                  //           shape: BoxShape.rectangle,
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment:
                  //               MainAxisAlignment.center,
                  //           children: [
                  //             Icon(
                  //               Icons.phone,
                  //               color: AppColors
                  //                   .lightPrimaryColor,
                  //             ),
                  //             const SizedBox(
                  //               width: 10,
                  //             ),
                  //             Text(
                  //               Application.appLocalizations!
                  //                   .phone,
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .bodyLarge!
                  //                   .copyWith(
                  //                     color: AppColors
                  //                         .lightPrimaryColor,
                  //                     fontWeight:
                  //                         FontWeight.w700,
                  //                     // fontSize: 24,
                  //                   ),
                  //             ),
                  //           ],
                  //         )),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Google
                  if (!kIsWeb) ...[
                    AuthOptionButton(
                      onPressed: () {
                        _bloc!.add(const AuthGoogleSignIn());
                      },
                      iconWidget: Image.asset(
                        "assets/icons/gmail.png",
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                      text:
                          "${Application.appLocalizations!.signInWith} Google",
                      color: const Color.fromARGB(255, 49, 49, 49),
                      textColor: AppColors.lightPrimaryColor,
                    ),
                    const SizedBox(height: 10),
                  ],
                  // Apple
                  if (!kIsWeb && PlatformInfo.isIOS) ...[
                    AuthOptionButton(
                      onPressed: () {
                        _bloc!.add(const AuthAppleSignIn());
                      },
                      iconWidget: const Icon(
                        Icons.phone_iphone,
                        size: 24,
                        color: Colors.white,
                      ),
                      text: "${Application.appLocalizations!.signInWith} Apple",
                      color: Colors.black,
                      textColor: Colors.white,
                    ),
                    const SizedBox(height: 10),
                  ],
                  const SizedBox(height: 30),

                  // Email
                  AuthOptionButton(
                    onPressed: () {
                      _bloc!.add(AuthEmit(state: AuthEmailSignInInitial()));
                    },
                    iconWidget: Icon(Icons.email, color: AppColors.whiteColor),
                    text: "${Application.appLocalizations!.signInWith} Email",
                    color: AppColors.primaryColor,
                    textColor: AppColors.whiteColor,
                  ),
                  const SizedBox(height: 10),
                  AuthOptionButton(
                    onPressed: () {
                      _bloc!.add(AuthEmit(state: AuthEmailSignUpInitial()));
                    },
                    iconWidget: Icon(Icons.email, color: AppColors.whiteColor),
                    text: Application.appLocalizations!.createAccountWithEmail,
                    color: AppColors.secondaryColor,
                    textColor: AppColors.whiteColor,
                  ),
                  const SizedBox(height: 10),

                  // Guest
                  AuthOptionButton(
                    onPressed: () async {
                      context.router.push(
                        MainRoute(appLinkRoute: appLinkRoute),
                      );
                      setAppLinkRoute(null);
                    },
                    iconWidget: Icon(
                      CupertinoIcons.person,
                      color: AppColors.primaryColor,
                    ),
                    text: Application.appLocalizations!.continueAsGuest,
                    color: AppColors.lightSecondaryColor,
                    textColor: AppColors.primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const SettingsLanguageCard(),
              const SizedBox(height: 10),
              AppPolicyButton(),
            ],
          ),
        ),
      ],
    );
  }
}
