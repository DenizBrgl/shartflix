import 'package:flutter/material.dart';
import 'package:shartflix/core/routes/app_routes.dart';
import 'package:shartflix/presentation/auth/pages/login_page.dart';

final Map<String, WidgetBuilder> appPages = {
  AppRoutes.login: (_) => const LoginPage(),
  // AppRoutes.home: (_) => const HomePage(),
};
