import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, GoogleAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:fridge_manager/firebase_options.dart';
import 'package:fridge_manager/src/data/hive_products_api/hive_products_api.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/data/product_name_api/product_name_api.dart';
import 'package:fridge_manager/src/main/app_bloc_observer.dart';
import 'package:fridge_manager/src/presentation/pages/overview_page/local_notification.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:openfoodfacts/openfoodfacts.dart' hide Product;

typedef AppBuilder = Future<Widget> Function();

Future<void> testFirestore(FirebaseFirestore firestore) async {
  const barcode = "40468259";
  log("fetch productName");
  final name = await ProductNameApi.fetch(barcode).timeout(
    const Duration(seconds: 10),
    onTimeout: () => "timeouted",
  );

  final prototype = ProductPrototype.fromScan(name ?? "notFound", barcode)
      .copyWith(expiresAt: ExpirationDate.today());

  log("define ProductsCollectionRef");
  final productsCollectionRef = firestore.collection("products");
  log("save to collection");
  await productsCollectionRef.add(prototype.toProduct().toJson());
}

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
      await initializeDateFormatting();

      await LocalNotification.init();

      await setupOpenFoodAPIConfiguration();

      await Hive.initFlutter();
      await HiveSettingsApi.init();
      await HiveProductsApi.init();
      await ProductNameApi.init();

      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      FirebaseUIAuth.configureProviders([
        EmailAuthProvider(),
        GoogleProvider(
            clientId:
                '688703949293-5tig6q6rtro1hds41d09d865b2pt2so9.apps.googleusercontent.com')
      ]);

      // await testFirestore(firestore);

      // final analyticsRepository =
      //     AnalyticsRepository(FirebaseAnalytics.instance);
      final blocObserver = AppBlocObserver(
          // analyticsRepository: analyticsRepository,
          );
      Bloc.observer = blocObserver;

      runApp(
        await builder(),
      );
    },
    (error, stack) {},
  );
}
