import 'package:auto_route/auto_route.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/app_colors.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UserBlockedScreen extends StatefulWidget {
  final String? text;
  const UserBlockedScreen({super.key, this.text});
  @override
  UserBlockedScreenState createState() => UserBlockedScreenState();
}

class UserBlockedScreenState extends State<UserBlockedScreen> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.lightPrimaryColor,
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/icons/Logo512.png", width: 120),
                const SizedBox(height: 20),
                Text(
                  Application.appLocalizations!.errorAccountBlocked,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
