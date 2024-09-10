import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fake_api/firebase_options.dart';
import 'package:flutter_fake_api/utils/navigation_utils.dart';
import 'package:flutter_fake_api/utils/sharred_preferences_utils.dart';
import 'package:flutter_fake_api/utils/theme_utils.dart';
import 'package:flutter_fake_api/utils/translations/translations_view_model.dart';
import 'package:provider/provider.dart';

import 'base/constants/app_constants.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesUtil.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    EasyLocalization(
        supportedLocales: const [LocaleConstants.trLocale, LocaleConstants.enLocale],
        path: LocaleConstants.localPath,
        saveLocale: true,
        fallbackLocale: LocaleConstants.enLocale,
        startLocale: LocaleConstants.enLocale,

        child: MyApp()),
  );
}
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {


  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(

      create: (_) => AppLanguage(context),
      child: Consumer<AppLanguage>(
        builder: (context, value, child) {
          return MaterialApp(
            navigatorKey: NavigationUtils.navigatorKey,
            debugShowCheckedModeBanner: false,
            locale: context.locale,
            localizationsDelegates: context.localizationDelegates,
            title: 'Flutter Demo',
            theme: theme,
            initialRoute: NavigationUtils.authGateScreen,
            onGenerateRoute: NavigationUtils.onGenerateRoute,
            navigatorObservers: [routeObserver],
            supportedLocales: context.supportedLocales,
          );
        },
      ),
    );
  }
}
