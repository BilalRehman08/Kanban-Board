import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'firebase_options.dart';
import 'services/local_storage_services.dart';
import 'theme/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorageServices.init();
  await setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState of(BuildContext context) {
    return context.findAncestorStateOfType<_MyAppState>()!;
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeData _themeData;
  Locale locale = const Locale('en');

  @override
  void initState() {
    _themeData = AppTheme.darkTheme;
    super.initState();
  }

  void changeTheme() {
    setState(() {
      _themeData = _themeData == AppTheme.darkTheme
          ? AppTheme.lightTheme
          : AppTheme.darkTheme;
    });
  }

  void changeLocale() {
    setState(() {
      locale = locale == const Locale('fr')
          ? const Locale('en')
          : const Locale('fr');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _themeData,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
