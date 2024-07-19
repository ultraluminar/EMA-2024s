import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/domain/products_repository/products_repository.dart';
import 'package:fridge_manager/src/presentation/home/home.dart';
import 'package:fridge_manager/src/presentation/theme.dart';

class App extends StatelessWidget {
  const App({
    required this.productsRepository,
    required this.settingsApi,
    super.key,
  });

  final ProductsRepository productsRepository;
  final HiveSettingsApi settingsApi;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: productsRepository),
        RepositoryProvider.value(value: settingsApi),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  ThemeData? getTheme(ThemeMode themeMode) {
    if (themeMode == ThemeMode.system || themeMode == ThemeMode.light) {
      return FlutterFridgeTheme.light;
    }
    return null;
  }

  ThemeData? getdarkTheme(ThemeMode themeMode) {
    if (themeMode == ThemeMode.system || themeMode == ThemeMode.dark) {
      return FlutterFridgeTheme.dark;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: context.read<HiveSettingsApi>().getListenable(),
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
