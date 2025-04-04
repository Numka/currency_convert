import 'package:auto_route/auto_route.dart';
import 'package:currency_convert/features/features.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          path: '/',
        ),
        AutoRoute(
          page: AuthRoute.page,
          path: '/login',
        ),
        CustomRoute(
          page: BottomTabRoute.page,
          path: '/tabs-screen',
          transitionsBuilder: (_, animation, ___, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          children: <AutoRoute>[
            RedirectRoute(path: '', redirectTo: 'currency-list'),
            CupertinoRoute(
              page: CurrencyListRoute.page,
              path: 'currency-list',
            ),
            CupertinoRoute(
              page: ConversionRoute.page,
              path: 'conversion-route',
            ),
          ],
        ),
      ];
}
