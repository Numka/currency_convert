import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:currency_convert/app/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //not ideal change later
    Timer(const Duration(seconds: 1), changeScreen);
  }

  Future<void> changeScreen() async {
    await context.router.replace(const AuthRoute());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}
