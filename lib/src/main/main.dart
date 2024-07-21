import 'package:fridge_manager/src/data/hive_products_api/hive_products_api.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/main/bootstrap.dart';
import 'package:fridge_manager/src/presentation/app/app.dart';

void main() {
  bootstrap(() async {
    await HiveSettingsApi.init();
    await HiveProductsApi.init();

    return const App();
  });
}
