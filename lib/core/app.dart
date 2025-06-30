import 'package:auto_route/auto_route.dart';
import 'package:eterny_task/core/widgets/unfocuser.dart';
import 'package:eterny_task/di.dart';
import 'package:eterny_task/l10n/app_localizations.dart';
import 'package:eterny_task/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Eterny Task',
      supportedLocales: const [
        Locale('en'),
      ],
      locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      showPerformanceOverlay: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0000FF),
          dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0000FF),
          dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
          brightness: Brightness.dark,
        ),
      ),
      routerConfig: _router.config(navigatorObservers: () => [sl<AppRouteObserver>()]),

      builder: (context, child) => Unfocuser(child: child!),
    );
  }
}

class ConsoleColors {
  static const String reset = '\x1B[0m';
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String magenta = '\x1B[35m';
  static const String cyan = '\x1B[36m';
  static const String white = '\x1B[37m';
}

@injectable
class AppRouteObserver extends AutoRouterObserver {
  AppRouteObserver();

  final Logger logger = Logger('AutoRoute');

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final message =
        '${ConsoleColors.green}Pushed: ${"${route.settings.name} ${route.settings.arguments}"}${ConsoleColors.reset}';
    logger.finest(message);
  }
}
