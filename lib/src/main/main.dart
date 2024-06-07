import 'package:fridge_manager/src/app/app.dart';
import 'package:fridge_manager/src/data/local_storage_products_api/lib/local_storage_products_api.dart';
import 'package:fridge_manager/src/domain/products_repository/lib/products_repository.dart';
import 'package:fridge_manager/src/main/bootstrap/bootstrap.dart';

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
