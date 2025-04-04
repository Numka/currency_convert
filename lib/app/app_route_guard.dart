import 'package:auto_route/auto_route.dart';
import 'package:currency_convert/app/app_router.dart';
import 'package:currency_convert/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final authCubit = router.navigatorKey.currentContext!.read<AuthCubit>();

    if (authCubit.state.status.isAuthenticated) {
      resolver.next();
    } else {
      await router.replace(const AuthRoute());

      ScaffoldMessenger.of(router.navigatorKey.currentContext!).showSnackBar(
        const SnackBar(content: Text('Please login first')),
      );
    }
  }
}
