import 'package:flutter/material.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/adaptive_layout_manager.dart';
import 'package:semur/global/widgets/default_text_form_field.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/services/firebase_analytics_service.dart';
import 'package:semur/services/notification_service.dart';
import 'package:semur/modules/auth/bloc/auth/auth_bloc.dart';
import 'package:semur/modules/auth/welcome_screen/widgets/app_policy_button.dart';
import 'package:semur/modules/auth/welcome_screen/widgets/auth_option_button.dart';

class AuthEmailSignUpInitialScreen extends StatefulWidget {
  const AuthEmailSignUpInitialScreen({super.key, required AuthBloc? bloc})
    : _bloc = bloc;

  final AuthBloc? _bloc;

  @override
  State<AuthEmailSignUpInitialScreen> createState() =>
      _AuthEmailSignUpInitialScreenState();
}

class _AuthEmailSignUpInitialScreenState
    extends State<AuthEmailSignUpInitialScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String password2 = "";

  @override
  void initState() {
    Application.firebaseAnalyticsService.logEvent(
      FirebaseAnalyticsEvent.openScreen,
      parameters: {"screen_name": "AuthEmailSignUpInitialScreen"},
    );
    super.initState();
  }

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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Application.appLocalizations!.welcome,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  style: Theme.of(context).textTheme.headlineLarge!,
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextFormField(
                      validator:
                          (val) =>
                              val!.isEmpty
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
                    const SizedBox(height: 10),
                    DefaultTextFormField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      validator:
                          (val) =>
                              val!.length >= 5
                                  ? null
                                  : '${Application.appLocalizations!.minCharacters} 5',
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      hintText: Application.appLocalizations!.password,
                      labelText: Application.appLocalizations!.password,
                    ),
                    const SizedBox(height: 15),
                    DefaultTextFormField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      validator:
                          (val) =>
                              val!.length >= 5
                                  ? null
                                  : '${Application.appLocalizations!.minCharacters} 5',
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (val) {
                        setState(() {
                          password2 = val;
                        });
                      },
                      hintText: Application.appLocalizations!.repeatPassword,
                      labelText: Application.appLocalizations!.repeatPassword,
                    ),
                    const SizedBox(height: 15),
                    AuthOptionButton(
                      onPressed: () {
                        if (password != password2) {
                          showNotification(
                            Application.appLocalizations!.passwordsDoNotMatch,
                            NotificationType.error,
                          );
                        }
                        if (_formKey.currentState!.validate() &&
                            (password == password2)) {
                          widget._bloc!.add(
                            AuthEmailSignUp(email: email, password: password),
                          );
                        }
                      },
                      // Send
                      iconWidget: Icon(
                        Icons.send,
                        color: AppColors.whiteColor,
                      ),
                      text: Application.appLocalizations!.send,
                      color: AppColors.secondaryColor,
                      textColor: AppColors.whiteColor,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                AuthOptionButton(
                  onPressed: () {
                    widget._bloc!.add(
                      AuthEmit(state: AuthEmailSignInInitial()),
                    );
                  },
                  iconWidget: Icon(
                    Icons.email,
                    color: AppColors.whiteColor,
                  ),
                  text: "${Application.appLocalizations!.signInWith} Email",
                  color: AppColors.primaryColor,
                  textColor: AppColors.whiteColor,
                ),
                const SizedBox(height: 10),
                AuthOptionButton(
                  onPressed: () {
                    widget._bloc!.add(AuthEmit(state: AuthInitial()));
                  },
                  // Send
                  iconWidget: Icon(
                    Icons.arrow_back,
                    color: AppColors.lightPrimaryColor,
                  ),
                  text: Application.appLocalizations!.back,
                  color: AppColors.primaryColor,
                  textColor: AppColors.lightPrimaryColor,
                ),
                const SizedBox(height: 10),
                AppPolicyButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
