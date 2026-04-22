import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:semur/global/screens/main_screen.dart';
import 'package:semur/global/screens/sww_screen.dart';
import 'package:semur/global/screens/user_blocked_screen.dart';
import 'package:semur/models.pb/external_apps/telegram_bot_integration.pb.dart';
import 'package:semur/modules/auth/screens/auth_change_password_screen.dart';
import 'package:semur/modules/auth/screens/auth_link_email_screen.dart';
import 'package:semur/modules/auth/welcome_screen/welcome_screen.dart';
import 'package:semur/modules/dashboard/screens/gmail_inbox_screen/gmail_inbox_screen.dart';
import 'package:semur/modules/demo/demo_chat_screen.dart';
import 'package:semur/modules/external_apps/screens/all_external_app_integrations_screen.dart';
import 'package:semur/modules/integrations/screens/all_integrations_screen.dart';
import 'package:semur/modules/user/screens/user_edit_screen/edit_user_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: WelcomeRoute.page, initial: true, path: "/"),
    AutoRoute(page: DemoChatRoute.page, path: "/demo"),
    AutoRoute(page: MainRoute.page, path: "/main"),
    AutoRoute(page: GmailInboxRoute.page, path: "/inbox"),

    // Auth
    AutoRoute(
      page: AuthChangePasswordRoute.page,
      path: "/auth/change/password",
    ),
    AutoRoute(page: AuthLinkEmailRoute.page, path: "/auth/link/password"),

    // External Apps
    AutoRoute(
      page: AllExternalAppIntegrationsRoute.page,
      path: "/external_apps/all",
    ),

    // Integrations
    AutoRoute(page: AllIntegrationsRoute.page, path: "/integrations/all"),

    // User
    AutoRoute(page: EditUserRoute.page, path: "/user/edit"),
  ];
}
