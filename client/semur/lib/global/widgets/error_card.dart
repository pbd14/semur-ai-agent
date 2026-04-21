import 'package:flutter/material.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/global/widgets/default_rounded_button.dart';


class ErrorCard extends StatelessWidget {
  final String text;
  final Function? onRetry;

  const ErrorCard({
    super.key,
    this.text = "Error",
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/Logo512.png",
            width: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (onRetry != null)
            Center(
              child: DefaultRoundedButton(
                color: AppColors.primaryColor,
                textColor: AppColors.secondaryColor,
                text: Application.appLocalizations!.retry,
                press: () {
                  onRetry!();
                },
              ),
            ),
        ],
      ),
    );
  }
}
