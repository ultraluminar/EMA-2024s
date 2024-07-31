import 'dart:async';

import 'package:bloc/bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart'
//     hide EmailAuthProvider, GoogleAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:fridge_manager/firebase_options.dart';
import 'package:fridge_manager/src/data/hive_products_api/hive_products_api.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/data/notifications_api/notifications_api.dart';
import 'package:fridge_manager/src/data/product_name_api/product_name_api.dart';
import 'package:fridge_manager/src/main/app_bloc_observer.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:openfoodfacts/openfoodfacts.dart' hide Product;

typedef AppBuilder = Future<Widget> Function();

Future<void> setupOpenFoodAPIConfiguration() async {
  OpenFoodAPIConfiguration.userAgent = UserAgent(
    name: "Fridge Manager",
    version: "1.0",
    system: "Flutter",
    comment: "An app to manage product expiration dates",
  );
  OpenFoodAPIConfiguration.globalLanguages = [OpenFoodFactsLanguage.GERMAN];
  OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.GERMANY;
}

Future<void> bootstrap(AppBuilder builder) async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await setupOpenFoodAPIConfiguration();

      await Hive.initFlutter();
      await HiveSettingsApi.init();
      await HiveProductsApi.init();
      await ProductNameApi.init();

      await initializeDateFormatting();
      await NotificationsApi.init();

      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      FirebaseUIAuth.configureProviders([
        EmailAuthProvider(),
        GoogleProvider(
            clientId:
                '688703949293-5tig6q6rtro1hds41d09d865b2pt2so9.apps.googleusercontent.com')
      ]);

      final blocObserver = AppBlocObserver();
      Bloc.observer = blocObserver;

      runApp(
        await builder(),
      );
    },
    (error, stack) {},
  );
}
