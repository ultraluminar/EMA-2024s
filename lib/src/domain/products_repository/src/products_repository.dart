import 'package:fridge_manager/src/data/products_api/products_api.dart';

// TODO: add docstrings
class ProductsRepository {
  const ProductsRepository({
    required ProductsApi productsApi,
  }) : _productsApi = productsApi;

  final ProductsApi _productsApi;

  Stream<List<Product>> getAllProducts() => _productsApi.getAllProducts();

  Future<void> saveProduct(Product product) =>
      _productsApi.saveProduct(product);

  Future<void> deleteProduct(String uuid) => _productsApi.deleteProduct(uuid);
}
