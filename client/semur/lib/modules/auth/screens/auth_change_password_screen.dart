import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/adaptive_layout_manager.dart';
import 'package:semur/global/screens/loading_screen.dart';
import 'package:semur/global/widgets/default_text_form_field.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/services/firebase_analytics_service.dart';
import 'package:semur/services/notification_service.dart';
import 'package:semur/global/widgets/default_app_bar.dart';
import 'package:semur/global/widgets/custom_dialog.dart';
import 'package:semur/modules/auth/bloc/auth_change_password_bloc/auth_change_password_bloc.dart';
import 'package:semur/modules/auth/welcome_screen/widgets/auth_option_button.dart';

@RoutePage()
class AuthChangePasswordScreen extends StatefulWidget {
  const AuthChangePasswordScreen({
    super.key,
  });

  @override
  State<AuthChangePasswordScreen> createState() =>
      _AuthChangePasswordScreenState();
}

class _AuthChangePasswordScreenState extends State<AuthChangePasswordScreen> {
  final Widget loadingScreen = const LoadingScreen();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthChangePasswordBloc bloc = AuthChangePasswordBloc();
  String email = "";
  String code = "";
  String password = "";
  String password2 = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Application.firebaseAnalyticsService.logEvent(
        FirebaseAnalyticsEvent.openScreen,
        parameters: {
          "screen_name": "AuthChangePasswordScreen",
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const DefaultAppBar(),
      body: AdaptiveLayoutManager(
        config: AdaptiveLayoutConfig.allOneColumn().copyWith(
          maxContentWidth: 600,
        ),
        children: [
          BlocListener(
            bloc: bloc,
            listener: blocListener,
            child: BlocBuilder(
              bloc: bloc,
              builder: (BuildContext context, AuthChangePasswordState state) {
                if (state is AuthChangePasswordLoading) {
                  return const LoadingScreen();
                }
                // if (state is AuthChangePasswordSendLinkSuccess) {
                //   return Center(
                //     child: Container(
                //       constraints: BoxConstraints(
                //         maxWidth: kIsWeb ? 600 : double.infinity,
                //         minHeight: size.height - 80,
                //       ),
                //       child: Form(
                //         key: _formKey2,
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               // Application.appLocalizations!.signUp,
                //               "Change password",
                //               maxLines: 3,
                //               overflow: TextOverflow.ellipsis,
                //               style: Theme.of(context)
                //                   .textTheme
                //                   .headlineMedium!
                //                   .copyWith(fontSize: 48),
                //             ),
                //             const SizedBox(
                //               height: 50,
                //             ),
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 TextFormField(
                //                   style:
                //                       Theme.of(context).textTheme.bodyLarge,
                //                   cursorColor: AppColors.secondaryColor,
                //                   validator: (val) => val!.isEmpty
                //                       ?
                //                       // Application.appLocalizations!.code
                //                       // TODO: Text
                //                       "Code"
                //                       : null,
                //                   keyboardType: TextInputType.text,
                //                   onChanged: (val) {
                //                     setState(() {
                //                       code = val;
                //                     });
                //                   },
                //                   decoration: const InputDecoration()
                //                       .applyDefaults(Theme.of(context)
                //                           .inputDecorationTheme)
                //                       .copyWith(
                //                         hintText:
                //                             // Application.appLocalizations!.email,
                //                             // TODO: Text
                //                             "Code",
                //                         labelText:
                //                             // Application.appLocalizations!.email,
                //                             // TODO: Text
                //                             "Code",
                //                         hintStyle: TextStyle(
                //                           color: AppColors.primaryColor
                //                               .withValues(alpha:0.7),
                //                         ),
                //                         labelStyle: TextStyle(
                //                           color: AppColors.primaryColor,
                //                         ),
                //                       ),
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 TextFormField(
                //                   obscureText: true,
                //                   enableSuggestions: false,
                //                   autocorrect: false,
                //                   style:
                //                       Theme.of(context).textTheme.bodyLarge,
                //                   cursorColor: AppColors.secondaryColor,
                //                   validator: (val) => val!.length >= 5
                //                       ? null
                //                       : '${Application.appLocalizations!.minCharacters} 5',
                //                   keyboardType: TextInputType.visiblePassword,
                //                   onChanged: (val) {
                //                     setState(() {
                //                       password = val;
                //                     });
                //                   },
                //                   decoration: const InputDecoration()
                //                       .applyDefaults(Theme.of(context)
                //                           .inputDecorationTheme)
                //                       .copyWith(
                //                         hintText:
                //                             Application.appLocalizations!
                //                                 .password,
                //                         labelText:
                //                             Application.appLocalizations!
                //                                 .password,
                //                         hintStyle: TextStyle(
                //                           color: AppColors.primaryColor
                //                               .withValues(alpha:0.7),
                //                         ),
                //                         labelStyle: TextStyle(
                //                           color: AppColors.primaryColor,
                //                         ),
                //                       ),
                //                 ),
                //                 const SizedBox(
                //                   height: 15,
                //                 ),
                //                 TextFormField(
                //                   obscureText: true,
                //                   enableSuggestions: false,
                //                   autocorrect: false,
                //                   style:
                //                       Theme.of(context).textTheme.bodyLarge,
                //                   cursorColor: AppColors.secondaryColor,
                //                   validator: (val) => val!.length >= 5
                //                       ? null
                //                       : '${Application.appLocalizations!.minCharacters} 5',
                //                   keyboardType: TextInputType.visiblePassword,
                //                   onChanged: (val) {
                //                     setState(() {
                //                       password2 = val;
                //                     });
                //                   },
                //                   decoration: const InputDecoration()
                //                       .applyDefaults(Theme.of(context)
                //                           .inputDecorationTheme)
                //                       .copyWith(
                //                         hintText:
                //                             // Application.appLocalizations!.password,
                //                             "Repeat password",
                //                         labelText:
                //                             // Application.appLocalizations!.password,
                //                             "Repeat password",
                //                         hintStyle: TextStyle(
                //                           color: AppColors.primaryColor
                //                               .withValues(alpha:0.7),
                //                         ),
                //                         labelStyle: TextStyle(
                //                           color: AppColors.primaryColor,
                //                         ),
                //                       ),
                //                 ),
                //                 const SizedBox(
                //                   height: 15,
                //                 ),
                //                 Center(
                //                   child: RoundedButton(
                //                     color: AppColors.secondaryColor,
                //                     textColor: AppColors.primaryColor,
                //                     text: Application.appLocalizations!.send,
                //                     press: () {
                //                       if (password != password2) {
                //                         showNotification(
                //                             "Passwords do not match",
                //                             "Passwords do not match",
                //                             NotificationType.error,);
                //                       }
                //                       if (_formKey2.currentState!
                //                               .validate() &&
                //                           (password == password2)) {
                //                         bloc.add(AuthChangePassword(
                //                           code: code,
                //                           newPassword: password,
                //                         ));
                //                       }
                //                     },
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   );
                // }
                // Change Password Initial
                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Application.appLocalizations!.changePassword,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineLarge!,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultTextFormField(
                            validator: (val) => val!.isEmpty
                                ? Application.appLocalizations!.email
                                : null,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                            hintText: Application.appLocalizations!.email,
                            labelText: Application.appLocalizations!.email,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AuthOptionButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                bloc.add(AuthChangePasswordSendCode(
                                  email: email,
                                ));
                              }
                            },
                            iconWidget: Icon(
                              Icons.send,
                              color: AppColors.primaryColor,
                            ),
                            text: Application.appLocalizations!.send,
                            color: AppColors.secondaryColor,
                            textColor: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void blocListener(BuildContext context, AuthChangePasswordState state) {
    if (state is AuthChangePasswordSuccess) {
      showNotification(
        Application.appLocalizations!.success,
        NotificationType.success,
      );
      context.router.maybePop();
    }
    if (state is AuthChangePasswordSendLinkSuccess) {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: Application.appLocalizations!.emailSent,
            text: Application.appLocalizations!.emailSentText,
            showNo: false,
            onSubmitted: () {
              Navigator.of(context).pop(true);
              showNotification(
                Application.appLocalizations!.emailSentText2,
                NotificationType.success,
              );
              context.router.maybePop();
            },
          );
        },
      );
    }
    if (state is AuthChangePasswordConfirmError) {
      showNotification(
        state.errorText,
        NotificationType.error,
      );
      bloc.add(const AuthChangePasswordEmit(
          state: AuthChangePasswordSendLinkSuccess()));
    }
    if (state is AuthChangePasswordError) {
      showNotification(
        state.errorText,
        NotificationType.error,
      );
    }
  }
}
