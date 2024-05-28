import 'package:flutter/widgets.dart';
import 'package:fridge_manager/bootstrap.dart';
import 'package:local_storage_products_api/local_storage_products_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final productsApi = LocalStorageProductsApi(
    sharedPreferences: await SharedPreferences.getInstance(),
  );

  bootstrap(productsApi: productsApi);
}
