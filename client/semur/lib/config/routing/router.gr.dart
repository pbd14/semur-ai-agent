// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AllExternalAppIntegrationsScreen]
class AllExternalAppIntegrationsRoute
    extends PageRouteInfo<AllExternalAppIntegrationsRouteArgs> {
  AllExternalAppIntegrationsRoute({
    Key? key,
    TelegramBotIntegration? newTelegramBotIntegration,
    List<PageRouteInfo>? children,
  }) : super(
         AllExternalAppIntegrationsRoute.name,
         args: AllExternalAppIntegrationsRouteArgs(
           key: key,
           newTelegramBotIntegration: newTelegramBotIntegration,
         ),
         initialChildren: children,
       );

  static const String name = 'AllExternalAppIntegrationsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AllExternalAppIntegrationsRouteArgs>(
        orElse: () => const AllExternalAppIntegrationsRouteArgs(),
      );
      return AllExternalAppIntegrationsScreen(
        key: args.key,
        newTelegramBotIntegration: args.newTelegramBotIntegration,
      );
    },
  );
}

class AllExternalAppIntegrationsRouteArgs {
  const AllExternalAppIntegrationsRouteArgs({
    this.key,
    this.newTelegramBotIntegration,
  });

  final Key? key;

  final TelegramBotIntegration? newTelegramBotIntegration;

  @override
  String toString() {
    return 'AllExternalAppIntegrationsRouteArgs{key: $key, newTelegramBotIntegration: $newTelegramBotIntegration}';
  }
}

/// generated route for
/// [AllIntegrationsScreen]
class AllIntegrationsRoute extends PageRouteInfo<void> {
  const AllIntegrationsRoute({List<PageRouteInfo>? children})
    : super(AllIntegrationsRoute.name, initialChildren: children);

  static const String name = 'AllIntegrationsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AllIntegrationsScreen();
    },
  );
}

/// generated route for
/// [AuthChangePasswordScreen]
class AuthChangePasswordRoute extends PageRouteInfo<void> {
  const AuthChangePasswordRoute({List<PageRouteInfo>? children})
    : super(AuthChangePasswordRoute.name, initialChildren: children);

  static const String name = 'AuthChangePasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthChangePasswordScreen();
    },
  );
}

/// generated route for
/// [AuthLinkEmailScreen]
class AuthLinkEmailRoute extends PageRouteInfo<void> {
  const AuthLinkEmailRoute({List<PageRouteInfo>? children})
    : super(AuthLinkEmailRoute.name, initialChildren: children);

  static const String name = 'AuthLinkEmailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthLinkEmailScreen();
    },
  );
}

/// generated route for
/// [DemoChatScreen]
class DemoChatRoute extends PageRouteInfo<DemoChatRouteArgs> {
  DemoChatRoute({
    Key? key,
    DemoChatClient? demoChatClient,
    List<PageRouteInfo>? children,
  }) : super(
         DemoChatRoute.name,
         args: DemoChatRouteArgs(
           key: key,
           demoChatClient: demoChatClient,
         ),
         initialChildren: children,
       );

  static const String name = 'DemoChatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DemoChatRouteArgs>(
        orElse: () => const DemoChatRouteArgs(),
      );
      return DemoChatScreen(
        key: args.key,
        demoChatClient: args.demoChatClient,
      );
    },
  );
}

class DemoChatRouteArgs {
  const DemoChatRouteArgs({
    this.key,
    this.demoChatClient,
  });

  final Key? key;

  final DemoChatClient? demoChatClient;

  @override
  String toString() {
    return 'DemoChatRouteArgs{key: $key, demoChatClient: $demoChatClient}';
  }
}

/// generated route for
/// [EditUserScreen]
class EditUserRoute extends PageRouteInfo<EditUserRouteArgs> {
  EditUserRoute({Key? key, bool isSetup = false, List<PageRouteInfo>? children})
    : super(
        EditUserRoute.name,
        args: EditUserRouteArgs(key: key, isSetup: isSetup),
        initialChildren: children,
      );

  static const String name = 'EditUserRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditUserRouteArgs>(
        orElse: () => const EditUserRouteArgs(),
      );
      return EditUserScreen(key: args.key, isSetup: args.isSetup);
    },
  );
}

class EditUserRouteArgs {
  const EditUserRouteArgs({this.key, this.isSetup = false});

  final Key? key;

  final bool isSetup;

  @override
  String toString() {
    return 'EditUserRouteArgs{key: $key, isSetup: $isSetup}';
  }
}

/// generated route for
/// [GmailInboxScreen]
class GmailInboxRoute extends PageRouteInfo<void> {
  const GmailInboxRoute({List<PageRouteInfo>? children})
    : super(GmailInboxRoute.name, initialChildren: children);

  static const String name = 'GmailInboxRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const GmailInboxScreen();
    },
  );
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<MainRouteArgs> {
  MainRoute({
    Key? key,
    PageRouteInfo<dynamic>? appLinkRoute,
    List<PageRouteInfo>? children,
  }) : super(
         MainRoute.name,
         args: MainRouteArgs(key: key, appLinkRoute: appLinkRoute),
         initialChildren: children,
       );

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MainRouteArgs>(
        orElse: () => const MainRouteArgs(),
      );
      return MainScreen(key: args.key, appLinkRoute: args.appLinkRoute);
    },
  );
}

class MainRouteArgs {
  const MainRouteArgs({this.key, this.appLinkRoute});

  final Key? key;

  final PageRouteInfo<dynamic>? appLinkRoute;

  @override
  String toString() {
    return 'MainRouteArgs{key: $key, appLinkRoute: $appLinkRoute}';
  }
}

/// generated route for
/// [SomethingWentWrongScreen]
class SomethingWentWrongRoute
    extends PageRouteInfo<SomethingWentWrongRouteArgs> {
  SomethingWentWrongRoute({
    Key? key,
    String error = "Error",
    List<PageRouteInfo>? children,
  }) : super(
         SomethingWentWrongRoute.name,
         args: SomethingWentWrongRouteArgs(key: key, error: error),
         initialChildren: children,
       );

  static const String name = 'SomethingWentWrongRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SomethingWentWrongRouteArgs>(
        orElse: () => const SomethingWentWrongRouteArgs(),
      );
      return SomethingWentWrongScreen(key: args.key, error: args.error);
    },
  );
}

class SomethingWentWrongRouteArgs {
  const SomethingWentWrongRouteArgs({this.key, this.error = "Error"});

  final Key? key;

  final String error;

  @override
  String toString() {
    return 'SomethingWentWrongRouteArgs{key: $key, error: $error}';
  }
}

/// generated route for
/// [UserBlockedScreen]
class UserBlockedRoute extends PageRouteInfo<UserBlockedRouteArgs> {
  UserBlockedRoute({Key? key, String? text, List<PageRouteInfo>? children})
    : super(
        UserBlockedRoute.name,
        args: UserBlockedRouteArgs(key: key, text: text),
        initialChildren: children,
      );

  static const String name = 'UserBlockedRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserBlockedRouteArgs>(
        orElse: () => const UserBlockedRouteArgs(),
      );
      return UserBlockedScreen(key: args.key, text: args.text);
    },
  );
}

class UserBlockedRouteArgs {
  const UserBlockedRouteArgs({this.key, this.text});

  final Key? key;

  final String? text;

  @override
  String toString() {
    return 'UserBlockedRouteArgs{key: $key, text: $text}';
  }
}

/// generated route for
/// [WelcomeScreen]
class WelcomeRoute extends PageRouteInfo<WelcomeRouteArgs> {
  WelcomeRoute({
    Key? key,
    PageRouteInfo<dynamic>? appLinkRoute,
    List<PageRouteInfo>? children,
  }) : super(
         WelcomeRoute.name,
         args: WelcomeRouteArgs(key: key, appLinkRoute: appLinkRoute),
         initialChildren: children,
       );

  static const String name = 'WelcomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WelcomeRouteArgs>(
        orElse: () => const WelcomeRouteArgs(),
      );
      return WelcomeScreen(key: args.key, appLinkRoute: args.appLinkRoute);
    },
  );
}

class WelcomeRouteArgs {
  const WelcomeRouteArgs({this.key, this.appLinkRoute});

  final Key? key;

  final PageRouteInfo<dynamic>? appLinkRoute;

  @override
  String toString() {
    return 'WelcomeRouteArgs{key: $key, appLinkRoute: $appLinkRoute}';
  }
}
