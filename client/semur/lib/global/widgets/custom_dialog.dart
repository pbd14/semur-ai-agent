import 'package:flutter/material.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/app_colors.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String text;
  final Function()? onSubmitted;
  final bool showNo;

  const CustomDialog({
    super.key,
    required this.title,
    required this.text,
    required this.onSubmitted,
    this.showNo = true,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      // title: Text(
      //     Languages.of(context).profileScreenSignOut),
      // content: Text(
      //     Languages.of(context)!.profileScreenWantToLeave),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      content: Text(text, style: Theme.of(context).textTheme.bodyMedium),
      actions: <Widget>[
        TextButton(
          onPressed: onSubmitted,
          child: Text(
            Application.appLocalizations!.yes,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.greenColor,
            ),
          ),
        ),
        if (showNo)
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              Application.appLocalizations!.no,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}
