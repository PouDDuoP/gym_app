import 'package:flutter/material.dart';
import 'package:gym_app/features/auth/ui/pages/login_page.dart';
import 'package:gym_app/features/auth/ui/pages/register_page.dart';

class AppRoutes {
  // static const home = '/home';
  static const login = '/';
  static const register = '/register';
}

final Map<String, WidgetBuilder> routes = {
  // AppRoutes.home: (context) => const HomePage(),
  AppRoutes.login: (context) => const LoginPage(),
  AppRoutes.register: (context) => const RegisterPage(),
};