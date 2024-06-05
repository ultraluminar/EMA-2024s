import 'package:flutter/widgets.dart';
import 'package:fridge_manager/bootstrap.dart';
import 'package:fridge_manager/pages/overview_page/local_notification.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:local_storage_products_api/local_storage_products_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  await LocalNotification.init();

  final productsApi = LocalStorageProductsApi(
    sharedPreferences: await SharedPreferences.getInstance(),
  );

  bootstrap(productsApi: productsApi);
}
