import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter();

  static RouteType mainScreenRouteType = RouteType.custom(
    customRouteBuilder: _glassyRouteBuilder,
    opaque: false,
    barrierColor: Colors.transparent,
  );

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRouteGuard> get guards => [];

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      type: mainScreenRouteType,
      initial: true,
    ),
  ];

  static Route<T> _glassyRouteBuilder<T>(
    BuildContext context,
    Widget child,
    AutoRoutePage<T> page,
  ) {
    return PageRouteBuilder<T>(
      settings: page,
      transitionDuration: const Duration(milliseconds: 320),
      reverseTransitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (context, animation, secondaryAnimation) => child,
      opaque: false,
      barrierColor: Colors.transparent,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final fadeInOut = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          ),
        );

        final scaleInOut = Tween<double>(begin: 0.95, end: 1).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          ),
        );

        return FadeTransition(
          opacity: fadeInOut,
          child: ScaleTransition(scale: scaleInOut, child: child),
        );
      },
    );
  }
}
