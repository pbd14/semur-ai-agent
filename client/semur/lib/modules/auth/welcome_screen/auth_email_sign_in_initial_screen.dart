import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:semur/config/application.dart';
import 'package:semur/config/routing/router.dart';
import 'package:semur/global/adaptive_layout_manager.dart';
import 'package:semur/global/widgets/default_text_form_field.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/modules/auth/bloc/auth/auth_bloc.dart';
import 'package:semur/modules/auth/welcome_screen/widgets/app_policy_button.dart';
import 'package:semur/modules/auth/welcome_screen/widgets/auth_option_button.dart';
import 'package:semur/services/firebase_analytics_service.dart';

class AuthEmailSignInInitialScreen extends StatefulWidget {
  const AuthEmailSignInInitialScreen({super.key, required AuthBloc? bloc})
    : _bloc = bloc;

  final AuthBloc? _bloc;

  @override
  State<AuthEmailSignInInitialScreen> createState() =>
      _AuthEmailSignInInitialScreenState();
}

class _AuthEmailSignInInitialScreenState
    extends State<AuthEmailSignInInitialScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String password2 = "";

  @override
  void initState() {
    Application.firebaseAnalyticsService.logEvent(
      FirebaseAnalyticsEvent.openScreen,
      parameters: {"screen_name": "AuthEmailSignInInitialScreen"},
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
        Form(
          key: _formKey,
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.sizeOf(context).height - 80,
            ),
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
                    AuthOptionButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget._bloc!.add(
                            AuthEmailSignIn(email: email, password: password),
                          );
                        }
                      },
                      // Send
                      iconWidget: Icon(Icons.send, color: AppColors.whiteColor),
                      text: Application.appLocalizations!.send,
                      color: AppColors.secondaryColor,
                      textColor: AppColors.whiteColor,
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          context.router.push(const AuthChangePasswordRoute());
                        },
                        child: Text(
                          Application.appLocalizations!.forgotPassword,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                AuthOptionButton(
                  onPressed: () {
                    widget._bloc!.add(
                      AuthEmit(state: AuthEmailSignUpInitial()),
                    );
                  },
                  iconWidget: Icon(Icons.email, color: AppColors.whiteColor),
                  text: Application.appLocalizations!.createAccountWithEmail,
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
