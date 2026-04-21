import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semur/config/application.dart';
import 'package:semur/config/routing/router.dart';
import 'package:semur/global/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:semur/global/widgets/default_app_bar.dart';
import 'package:semur/global/widgets/default_rounded_button.dart';
import 'package:semur/modules/auth/bloc/auth/auth_bloc.dart';

@RoutePage()
class SomethingWentWrongScreen extends StatelessWidget {
  final String error;
  const SomethingWentWrongScreen({super.key, this.error = "Error"});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: DefaultAppBar(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.whiteColor.withValues(alpha: 0.4),
            iconTheme: IconThemeData(
              color: AppColors.primaryColor,
            ),
            title: Text(
              Application.appLocalizations!.errorTryAgainLater,
              textScaler: const TextScaler.linear(1),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
            ),
            centerTitle: true,
          ),
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      body: Container(
        margin: const EdgeInsets.only(top: 120),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  error,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: DefaultRoundedButton(
                  color: AppColors.primaryColor,
                  textColor: AppColors.whiteColor,
                  text: Application.appLocalizations!.tryAgain,
                  press: () async {
                    BlocProvider.of<AuthBloc>(context)
                        .add(AuthSignOut());
                    context.router.navigate(WelcomeRoute());
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
