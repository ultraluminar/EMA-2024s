import 'dart:async';

import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fridge_manager/src/data/hive_products_api/hive_products_api.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/data/hive_settings_api/src/models/models.dart';
import 'package:fridge_manager/src/data/product_name_api/product_name_api.dart';
// import 'package:fridge_manager/src/data/products_api/products_api.dart';
import 'package:fridge_manager/src/main/app_bloc_observer.dart';
import 'package:fridge_manager/src/presentation/pages/overview_page/local_notification.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:openfoodfacts/openfoodfacts.dart' hide Product;

typedef AppBuilder = Future<Widget> Function();

const String emulatorIP = "10.0.2.2";
const int emulatorPort = 8080;

Future<void> bootstrap(AppBuilder builder) async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      initializeDateFormatting();
      await LocalNotification.init();

      OpenFoodAPIConfiguration.userAgent = UserAgent(
        name: "Fridge Manager",
        version: "1.0",
        system: "Flutter",
        comment: "An app to manage product expiration dates",
      );
      OpenFoodAPIConfiguration.globalLanguages = [OpenFoodFactsLanguage.GERMAN];
      OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.GERMANY;

      // final productName = await ProductNameApi.fetchFromApi("4001686322963");
      // log(productName!);

      await Hive.initFlutter();

      await HiveSettingsApi.init();
      await HiveProductsApi.init();
      await ProductNameApi.init();

      // final firebaseApp = await Firebase.initializeApp();

      // final FirebaseFirestore firestore =
      //     FirebaseFirestore.instanceFor(app: firebaseApp);
      // firestore.useFirestoreEmulator(emulatorIP, emulatorPort);

      // final product = await Product.fromBarcode(
      //     barcode: "40468259", expiresAt: ExpirationDate.today());

      // firestore.collection("products").add(product.toJson());

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
    (_, __) {},
  );
}
