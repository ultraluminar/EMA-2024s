import 'package:hive_flutter/hive_flutter.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

Future<Product?> fetchProduct(
  String barcode, {
  List<ProductField>? fields,
  ProductQueryVersion version = ProductQueryVersion.v3,
}) async {
  final configuration =
      ProductQueryConfiguration(barcode, version: version, fields: fields);
  final result = await OpenFoodAPIClient.getProductV3(configuration);
  return result.product;
}

final box = Hive.box<String>("product_names");

class ProductNameApi {
  static Future<String?> fetchFromApi(String barcode) async {
    final product = await fetchProduct(barcode, fields: [ProductField.NAME]);
    return product?.productName;
  }

  static Future<String?> fetch(String barcode) async {
    final fromHive = box.get(barcode);
    if (fromHive != null) return fromHive;

    final fromApi = await fetchFromApi(barcode);
    if (fromApi == null) return null;

    await box.put(barcode, fromApi);
    return fromApi;
  }
}
