import 'package:books_project/utils/theme_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'utils/navigation_utils.dart';
import 'utils/sharredpref_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesUtil.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationUtils.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme,
      initialRoute: NavigationUtils.authGateScreen,
      onGenerateRoute: NavigationUtils.onGenerateRoute,
      navigatorObservers: [routeObserver],
    );
  }
}
