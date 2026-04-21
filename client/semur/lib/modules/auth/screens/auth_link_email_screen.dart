import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semur/config/application.dart';
import 'package:semur/config/routing/router.dart';
import 'package:semur/global/screens/loading_screen.dart';
import 'package:semur/global/adaptive_layout_manager.dart';
import 'package:semur/global/widgets/default_text_form_field.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/services/firebase_analytics_service.dart';
import 'package:semur/services/notification_service.dart';
import 'package:semur/global/widgets/default_app_bar.dart';
import 'package:semur/modules/auth/bloc/auth_link_email_bloc/auth_link_email_bloc.dart';
import 'package:semur/modules/auth/welcome_screen/widgets/auth_option_button.dart';

@RoutePage()
class AuthLinkEmailScreen extends StatefulWidget {
  const AuthLinkEmailScreen({
    super.key,
  });

  @override
  State<AuthLinkEmailScreen> createState() => _AuthLinkEmailScreenState();
}

class _AuthLinkEmailScreenState extends State<AuthLinkEmailScreen> {
  Widget loadingScreen = const LoadingScreen();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String password2 = "";

  AuthLinkBloc bloc = AuthLinkBloc();

  @override
  void initState() {
    Application.firebaseAnalyticsService.logEvent(
      FirebaseAnalyticsEvent.openScreen,
      parameters: {
        "screen_name": "AuthLinkEmailScreen",
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
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
              builder: (BuildContext context, AuthLinkState state) {
                if (state is AuthLinkLoading) {
                  return const LoadingScreen();
                }
                // Email AuthLink
                if (state is AuthLinkInitial) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Application.appLocalizations!.linkEmail,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: Theme.of(context).textTheme.headlineLarge!,
                        ),
                        const SizedBox(
                          height: 20,
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
                              height: 10,
                            ),
                            DefaultTextFormField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: (val) => val!.length >= 5
                                  ? null
                                  : '${Application.appLocalizations!.minCharacters} 5',
                              keyboardType: TextInputType.visiblePassword,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                              hintText:
                                  Application.appLocalizations!.password,
                              labelText:
                                  Application.appLocalizations!.password,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            DefaultTextFormField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: (val) => val!.length >= 5
                                  ? null
                                  : '${Application.appLocalizations!.minCharacters} 5',
                              keyboardType: TextInputType.visiblePassword,
                              onChanged: (val) {
                                setState(() {
                                  password2 = val;
                                });
                              },
                              hintText: Application
                                  .appLocalizations!.repeatPassword,
                              labelText: Application
                                  .appLocalizations!.repeatPassword,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            AuthOptionButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    (password == password2)) {
                                  bloc.add(AuthLinkEmailSignUp(
                                    context: context,
                                    email: email,
                                    password: password,
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
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                }
                return Container(
                  constraints: BoxConstraints(
                    minHeight: size.height - 80,
                  ),
                  child: loadingScreen,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void blocListener(BuildContext context, AuthLinkState state) {
    // Email Auth
    if (state is AuthLinkEmailSuccess) {
      showNotification(
        Application.appLocalizations!.emailLinked,
        NotificationType.success,
      );
      context.router.navigate(MainRoute());
    }
    if (state is AuthLinkEmailError) {
      showNotification(
        state.exception,
        NotificationType.error,
      );
      bloc.add(AuthLinkEmit(context: context, state: AuthLinkInitial()));
    }
  }
}
