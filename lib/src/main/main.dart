import 'package:fridge_manager/src/data/hive_products_api/hive_products_api.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/domain/products_repository/products_repository.dart';
import 'package:fridge_manager/src/main/bootstrap.dart';
import 'package:fridge_manager/src/presentation/app/app.dart';

void main() {
  bootstrap(() async {
    final hiveProductApi = await HiveProductsApi.instance;

    final productsRepository = ProductsRepository(
      hiveProductsApi: hiveProductApi,
    );

    final settingsApi = await HiveSettingsApi.instance;

    return App(
      productsRepository: productsRepository,
      settingsApi: settingsApi,
    );
  });
}
