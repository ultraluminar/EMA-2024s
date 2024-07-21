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
  HiveProductsApi._new(ProductBox box) : _box = box;

  late final ProductBox _box;

  static Future<HiveProductsApi> get instance async =>
      HiveProductsApi._new(await Hive.openBox<Product>("products"));

  int getProductCount() => _box.length;

  ValueListenable<ProductBox> getListenable() => _box.listenable();

  Future<void> saveProduct(Product product) async =>
      await _box.put(product.uuid, product);

  Future<void> deleteProduct(String uuid) async => await _box.delete(uuid);
}
