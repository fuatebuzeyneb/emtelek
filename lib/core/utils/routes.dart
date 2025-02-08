import 'package:emtelek/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:emtelek/features/auth/presentation/pages/login_page.dart';
import 'package:emtelek/features/auth/presentation/pages/signup_page.dart';
import 'package:emtelek/shared/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  //---------------flight ticket-------------------
  BottomNavBar.id: (context) => const BottomNavBar(),
  LoginPage.id: (context) => const LoginPage(),

  ForgotPasswordPage.id: (context) => const ForgotPasswordPage(),
  SignupPage.id: (context) => const SignupPage(),
};
