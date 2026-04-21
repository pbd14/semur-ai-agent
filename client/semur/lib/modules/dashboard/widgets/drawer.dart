import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semur/config/routing/router.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/global/widgets/custom_dialog.dart';
import 'package:semur/config/application.dart';
import 'package:semur/modules/auth/bloc/auth/auth_bloc.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      elevation: 10,
      backgroundColor: AppColors.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Semur Platform",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 2,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Divider(color: AppColors.whiteColor.withValues(alpha: 0.5)),
          const SizedBox(height: 10),
          ListTile(
            leading: Icon(Icons.extension, color: AppColors.whiteColor),
            title: Text(
              Application.appLocalizations!.integrations,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              maxLines: 2,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            onTap: () {
              context.router.push(const AllIntegrationsRoute());
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.cube_box, color: AppColors.whiteColor),
            title: Text(
              Application.appLocalizations!.products,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              maxLines: 2,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            onTap: () {
              // context.router.push(const AllProductsRoute());
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.settings, color: AppColors.whiteColor),
            title: Text(
              Application.appLocalizations!.settings,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              maxLines: 2,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            onTap: () {
              // context.router.push(const SettingsRoute());
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: Text(
              Application.appLocalizations!.logout,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              maxLines: 2,
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            onTap: () {
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  return CustomDialog(
                    title: Application.appLocalizations!.logoutText,
                    text: Application.appLocalizations!.logoutText2,
                    onSubmitted: () {
                      BlocProvider.of<AuthBloc>(
                        context,
                      ).add(const AuthSignOut());
                      Navigator.of(context).pop(false);
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
