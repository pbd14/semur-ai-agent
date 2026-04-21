import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:semur/global/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  final String? text;
  const LoadingScreen({super.key, this.text});
  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(minHeight: size.height - 80),
        color: AppColors.whiteColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/Logo512.png",
                width: 64,
                // color: AppColors.lightSecondaryColor,
              ),
              const SizedBox(height: 10),
              SpinKitWave(color: AppColors.primaryColor, size: 32.0),
              // const SizedBox(
              //   width: 150,
              //   height: 150,
              //   child: RiveAnimation.asset(
              //     'assets/ozod_logo.riv',
              //     fit: BoxFit.fill,
              //   ),
              // ),
              if (widget.text != null) const SizedBox(height: 10),
              if (widget.text != null)
                Text(
                  widget.text!,
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
    );
  }
}
