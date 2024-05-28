import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:fridge_manager/app/app.dart';
import 'package:fridge_manager/app/app_bloc_observer.dart';
import 'package:products_api/products_api.dart';
import 'package:products_repository/products_repository.dart';

void bootstrap({required ProductsApi productsApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final ProductsRepository productsRepository =
      ProductsRepository(productsApi: productsApi);

  runZonedGuarded(
    () => runApp(App(productsRepository: productsRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
