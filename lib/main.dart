import 'package:flutter/widgets.dart';
import 'package:fridge_manager/bootstrap.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:local_storage_products_api/local_storage_products_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();

  final productsApi = LocalStorageProductsApi(
    sharedPreferences: await SharedPreferences.getInstance(),
  );

  bootstrap(productsApi: productsApi);
}
