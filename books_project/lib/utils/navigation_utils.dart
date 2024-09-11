

import 'package:flutter/material.dart';

import '../screens/auth/auth_gate.dart';
import '../screens/home/home_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/register/register_screen.dart';

class NavigationUtils {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static const String loginScreen = "loginScreen";
  static const String signUpScreen = "signUpScreen";
  static const String homeScreen = "homeScreen";
  static const String authGateScreen = "authGateScreen";
  static _navigateToPage(context, String pageName, {Object? arguments}) => Navigator.pushNamed(context, pageName, arguments: arguments);
  static _navigateTo(context, String pageName, {Object? arguments}) => Navigator.pushReplacementNamed(context, pageName, arguments: arguments);
  static _navigateToAndRemoveUntil(context, String pageName, {Object? arguments}) =>
      Navigator.pushNamedAndRemoveUntil(context, pageName, (Route<dynamic> route) => false, arguments: arguments);
  static navigateToBack(context, {dynamic value}) => Navigator.pop(context, value);

  static navigateToLoginScreen(context) => _navigateTo(context, loginScreen);
  static navigateToHomeScreen(context) => _navigateToAndRemoveUntil(context, homeScreen);
  static navigateToSignUpScreen(context) => _navigateToPage(context, signUpScreen);
  static Route onGenerateRoute(settings) =>
      MaterialPageRoute(builder: (context) => _buildNavigationMap(context, settings), settings: RouteSettings(name: settings.name));
  static _buildNavigationMap(context, settings) {
    Widget page = const AuthGate();

    switch (settings.name) {
      case loginScreen:
        page = const LoginScreen();
        break;
      case signUpScreen:
        page = const SignupScreen();
        break;

      case homeScreen:
        page = const HomeScreen();
        break;
    }
    return page;
  }
}