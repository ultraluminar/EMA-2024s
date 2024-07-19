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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlutterFridgeTheme.light,
      darkTheme: FlutterFridgeTheme.dark,
      localizationsDelegates: const [S.delegate],
      supportedLocales: S.delegate.supportedLocales,
      home: const HomePage(),
    );
  }
}
