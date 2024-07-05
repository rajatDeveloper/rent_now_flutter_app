import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rent_now/features/auth/presentation/pages/login_page.dart';
import 'package:rent_now/features/auth/presentation/pages/register_page.dart';
import 'package:rent_now/features/auth/presentation/pages/splash_page.dart';

Map<String, Widget Function(BuildContext)> getAppRoutes() {
  Map<String, Widget Function(BuildContext)> appRoutes = {
    LoginPage.routeName: (context) => const LoginPage(),
    RegisterPage.routeName: (context) => const RegisterPage(),
    SplashPage.routeName: (context) => const SplashPage(),
  };

  return appRoutes;
}
