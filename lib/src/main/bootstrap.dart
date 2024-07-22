import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fridge_manager/src/data/hive_products_api/hive_products_api.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/data/product_name_api/product_name_api.dart';
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
      log("init WidgegBindings");
      WidgetsFlutterBinding.ensureInitialized();
      log("init DateFormatting");
      initializeDateFormatting();
      log("init LocalNotification");
      await LocalNotification.init();

      log("config OpenFoodApi");
      OpenFoodAPIConfiguration.userAgent = UserAgent(
        name: "Fridge Manager",
        version: "1.0",
        system: "Flutter",
        comment: "An app to manage product expiration dates",
      );
      OpenFoodAPIConfiguration.globalLanguages = [OpenFoodFactsLanguage.GERMAN];
      OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.GERMANY;

      log("init Hive");
      await Hive.initFlutter();
      log("init HiveSettingsApi");
      await HiveSettingsApi.init();
      log("init HiveProductsApi");
      await HiveProductsApi.init();
      log("init ProductNameApi");
      await ProductNameApi.init();

      log("init FirebaseApp");
      final firebaseApp = await Firebase.initializeApp();
      log("init Firestore");
      final FirebaseFirestore firestore =
          FirebaseFirestore.instanceFor(app: firebaseApp);
      log("use Firestore Emulator");
      firestore.useFirestoreEmulator(emulatorIP, emulatorPort);

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
      log("init BlocObserver");
      // final analyticsRepository =
      //     AnalyticsRepository(FirebaseAnalytics.instance);
      final blocObserver = AppBlocObserver(
          // analyticsRepository: analyticsRepository,
          );
      Bloc.observer = blocObserver;
      log("done");
      runApp(
        await builder(),
      );
    },
    (_, __) {},
  );
}
