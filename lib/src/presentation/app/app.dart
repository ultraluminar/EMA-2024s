import 'package:flutter/material.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/presentation/home/home.dart';
import 'package:fridge_manager/src/presentation/theme.dart';
import 'package:hive_flutter/adapters.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  ThemeData? getTheme(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
      case ThemeMode.light:
        return FlutterFridgeTheme.light;
      case ThemeMode.dark:
        return null;
    }
  }

  ThemeData? getdarkTheme(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
      case ThemeMode.dark:
        return FlutterFridgeTheme.dark;
      case ThemeMode.light:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: HiveSettingsApi.box.listenable(),
        builder: (context, box, child) {
          final ThemeMode themeMode =
              box.get(HiveSettingsApi.settingsIndex)!.themeMode;
          return MaterialApp(
            theme: getTheme(themeMode),
            darkTheme: getdarkTheme(themeMode),
            localizationsDelegates: const [S.delegate],
            supportedLocales: S.delegate.supportedLocales,
            home: const HomePage(),
          );
        });
  }
}
