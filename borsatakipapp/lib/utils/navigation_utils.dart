

import 'package:flutter/material.dart';
import 'package:flutter_fake_api/screens/my_cryptos_screen/my_cryptos_screen.dart';

import '../models/crypto_model.dart';
import '../screens/auth/auth_gate.dart';
import '../screens/crypto_detail_screen/crypto_detail_view.dart';
import '../screens/followed_by_screen/followedby_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/profile_settings/profile_settings_screen.dart';
import '../screens/signup/signup_screen.dart';

class NavigationUtils {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static const String loginScreen = "loginScreen";
  static const String signUpScreen = "signUpScreen";
  static const String homeScreen = "homeScreen";
  static const String authGateScreen = "authGateScreen";
  static const String profileSettingsScreen = "profileSettingsScreen";
  static const String cryptoDetailScreen = "cryptoDetailScreen";
  static const String followedByScreen = 'followedByScreen';
  static const String myCryptosScreen = 'myCryptosScreen';
  static _navigateToPage(context, String pageName, {Object? arguments}) => Navigator.pushNamed(context, pageName, arguments: arguments);
  static _navigateTo(context, String pageName, {Object? arguments}) => Navigator.pushReplacementNamed(context, pageName, arguments: arguments);
  static _navigateToAndRemoveUntil(context, String pageName, {Object? arguments}) =>
      Navigator.pushNamedAndRemoveUntil(context, pageName, (Route<dynamic> route) => false, arguments: arguments);
  static navigateToBack(context, {dynamic value}) => Navigator.pop(context, value);

  static navigateToLoginScreen(context) => _navigateTo(context, loginScreen);
  static navigateToHomeScreen(context) => _navigateToAndRemoveUntil(context, homeScreen);
  static navigateToProfileSettingsScreen(context) => _navigateToPage(context, profileSettingsScreen);
  static navigateToSignUpScreen(context) => _navigateToPage(context, signUpScreen);
  static navigateToCryptoDetailScreen(context, CryptoModel crypto) => _navigateToPage(context, cryptoDetailScreen, arguments: crypto);
  static navigateToFollowedByScreen(context)=> _navigateToPage(context, followedByScreen);
  static navigateToMyCryptosScreen(context)=> _navigateToPage(context, myCryptosScreen);
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

      case profileSettingsScreen:
        page = const ProfileSettingsScreen();
        break;

      case cryptoDetailScreen:
        var crypto = settings.arguments as CryptoModel;
        page = CryptoDetailView(cryptoModel: crypto);
        break;

      case followedByScreen:
        page = const FollowedbyScreen();
        break;
      case myCryptosScreen:
        page = const MyCryptosScreen();
        break;
    }
    return page;
  }
}
