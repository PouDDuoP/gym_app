import 'package:flutter/material.dart';
import 'package:gym_app/features/auth/ui/pages/login_page.dart';

class AppRoutes {
  static const login = '/';
  // static const home = '/home';
}

final Map<String, WidgetBuilder> routes = {
  AppRoutes.login: (context) => const LoginPage(),
  // AppRoutes.login: (context) => const LoginPage(),
  // AppRoutes.login: (context) => const LoginPage(),
};