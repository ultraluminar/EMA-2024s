import 'dart:async';

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

class ProductNameApi {
  static late final Box<String> _box;
  static Future<void> init() async {
    _box = await Hive.openBox<String>("product_names");
  }

  static Future<String?> fetchFromApi(String barcode) async {
    final product = await fetchProduct(barcode, fields: [
      ProductField.NAME,
      ProductField.BRANDS,
      ProductField.QUANTITY,
    ]);

    if (product == null) throw Exception("Product returned null!");
    if (product.productName!.isEmpty) return null;
    return [
      product.productName,
      if (product.brands != null && product.brands!.isNotEmpty) product.brands,
      if (product.quantity != null && product.quantity!.isNotEmpty)
        product.quantity,
    ].join(' - ');
  }

  static Future<String?> fetch(String barcode) async {
    final fromHive = _box.get(barcode);
    if (fromHive != null) return fromHive;

    final fromApi = await fetchFromApi(barcode);
    if (fromApi == null) return null;

    await _box.put(barcode, fromApi);
    return fromApi;
  }
}
