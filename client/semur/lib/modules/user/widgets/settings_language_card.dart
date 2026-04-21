import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/l10n/locale_constant.dart';

class SettingsLanguageCard extends StatelessWidget {
  const SettingsLanguageCard({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      // width: size.width * 0.8,
      padding: const EdgeInsets.all(10),
      // constraints: BoxConstraints(maxHeight: size.height * 0.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          // tileMode: TileMode.mirror,
          colors: [AppColors.primaryColor, AppColors.primaryColor],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              Application.appLocalizations!.language,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: 20,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          const SizedBox(height: 5),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              changeLanguage(context, 'uz');
            },
            child: Container(
              width: size.width * 1,
              height: 40,
              padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.whiteColor, AppColors.whiteColor],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "🇺🇿 O'zbek",
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (Application.language == "uz")
                    const Icon(
                      CupertinoIcons.check_mark_circled_solid,
                      color: AppColors.greenColor,
                      size: 30,
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              changeLanguage(context, 'en');
            },
            child: Container(
              width: size.width * 1,
              height: 40,
              padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.whiteColor, AppColors.whiteColor],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "🇺🇸 English",
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (Application.language == "en")
                    const Icon(
                      CupertinoIcons.check_mark_circled_solid,
                      color: AppColors.greenColor,
                      size: 30,
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              changeLanguage(context, 'ru');
            },
            child: Container(
              width: size.width * 1,
              height: 40,
              padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.whiteColor, AppColors.whiteColor],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // Arabic
                    "🇸🇦 العربية",
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (Application.language == "ru")
                    const Icon(
                      CupertinoIcons.check_mark_circled_solid,
                      color: AppColors.greenColor,
                      size: 30,
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 5),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              changeLanguage(context, 'ru');
            },
            child: Container(
              width: size.width * 1,
              height: 40,
              padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.whiteColor, AppColors.whiteColor],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "🇷🇺 Русский",
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (Application.language == "ru")
                    const Icon(
                      CupertinoIcons.check_mark_circled_solid,
                      color: AppColors.greenColor,
                      size: 30,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
