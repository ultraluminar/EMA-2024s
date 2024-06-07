import 'package:fridge_manager/src/app/app.dart';
import 'package:fridge_manager/src/main/bootstrap/bootstrap.dart';
import 'package:local_storage_products_api/local_storage_products_api.dart';
import 'package:products_repository/products_repository.dart';

void main() {
  bootstrap(
    (
      sharedPreferences,
    ) async {
      final productsApi = LocalStorageProductsApi(
        sharedPreferences: sharedPreferences,
      );

      final productsRepository = ProductsRepository(
        productsApi: productsApi,
      );

      return App(
        productsRepository: productsRepository,
      );
    },
  );
}
