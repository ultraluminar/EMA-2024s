import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fridge_manager/src/data/hive_products_api/hive_products_api.dart';
import 'package:hive_flutter/hive_flutter.dart';

typedef ProductBox = Box<Product>;

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final typeId = 0;

  @override
  Product read(BinaryReader reader) {
    return Product.fromJson(jsonDecode(reader.read()));
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer.write(jsonEncode(obj.toJson()));
  }
}

class HiveProductsApi {
  static late final ValueListenable<ProductBox> listenable;
  static ProductBox get box => listenable.value;

  static Future<void> init() async {
    final productBox = await Hive.openBox<Product>("products");
    listenable = productBox.listenable();
  }

  static int getProductCount() => box.length;

  static Future<void> saveProduct(Product product) async =>
      await box.put(product.uuid, product);

  static Future<void> deleteProduct(String uuid) async =>
      await box.delete(uuid);
}
