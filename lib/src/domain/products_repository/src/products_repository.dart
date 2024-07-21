import 'package:flutter/foundation.dart';
import 'package:fridge_manager/src/data/hive_products_api/hive_products_api.dart';

// TODO: add docstrings
class ProductsRepository {
  const ProductsRepository({required this.hiveProductsApi});

  final HiveProductsApi hiveProductsApi;

  int getProductCount() => hiveProductsApi.getProductCount();

  ValueListenable<ProductBox> getListenable() =>
      hiveProductsApi.getListenable();

  Future<void> saveProduct(Product product) async =>
      await hiveProductsApi.saveProduct(product);

  Future<void> deleteProduct(String uuid) async =>
      await hiveProductsApi.deleteProduct(uuid);
}
