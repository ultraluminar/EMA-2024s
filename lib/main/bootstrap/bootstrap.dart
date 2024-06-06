import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fridge_manager/main/bootstrap/app_bloc_observer.dart';
import 'package:fridge_manager/pages/overview_page/local_notification.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:local_storage_products_api/local_storage_products_api.dart';

typedef AppBuilder = Future<Widget> Function(
  SharedPreferences sharedPreferences,
);

Future<void> bootstrap(AppBuilder builder) async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      initializeDateFormatting();
      await LocalNotification.init();

      await Firebase.initializeApp();
      // final analyticsRepository =
      //     AnalyticsRepository(FirebaseAnalytics.instance);
      final blocObserver = AppBlocObserver(
          // analyticsRepository: analyticsRepository,
          );
      Bloc.observer = blocObserver;

      final sharedPreferences = await SharedPreferences.getInstance();

      runApp(
        await builder(sharedPreferences),
      );
    },
    (_, __) {},
  );
}
