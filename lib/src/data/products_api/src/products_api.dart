import 'package:fridge_manager/src/data/products_api/products_api.dart';

// TODO: add docstrings
abstract class ProductsApi {
  const ProductsApi();

  Future<List<Product>> getAllProducts();

  Future<void> saveProduct(Product product);

  Future<void> deleteProduct(String id);

  Future<void> close();
}

class ProductNotFoundException implements Exception {}
