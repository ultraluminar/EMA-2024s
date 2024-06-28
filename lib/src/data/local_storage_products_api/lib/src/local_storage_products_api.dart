import 'dart:convert';

import 'package:fridge_manager/src/data/products_api/products_api.dart';
import 'package:local_storage_products_api/local_storage_products_api.dart';
import 'package:rxdart/subjects.dart';

// TODO: add docstrings
class LocalStorageProductsApi extends ProductsApi {
  LocalStorageProductsApi({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences {
    _init();
  }

  final SharedPreferences _sharedPreferences;

  late final _producStreamController = BehaviorSubject<List<Product>>.seeded(
    const <Product>[],
  );

  static const String _key = String.fromEnvironment('SHARED_PREFERENCES_KEY');

  String? _getValue() => _sharedPreferences.getString(_key);
  Future<void> _setValue(String value) =>
      _sharedPreferences.setString(_key, value);

  List<Product> productsFromJson(String json) => List<JsonMap>.from(
        jsonDecode(json) as List,
      ).map((jsonMap) => Product.fromJson(jsonMap)).toList();

  void _init() {
    final productJson = _getValue();
    _producStreamController.add(
        <Product>[if (productJson != null) ...productsFromJson(productJson)]);
  }

  @override
  Stream<List<Product>> getAllProducts() =>
      _producStreamController.asBroadcastStream();

  @override
  Future<void> saveProduct(Product product) {
    final List<Product> products = <Product>[..._producStreamController.value];
    final int productIndex =
        products.indexWhere((Product p) => p.uuid == product.uuid);
    if (productIndex != -1) {
      products[productIndex] = product;
    } else {
      products.add(product);
    }

    _producStreamController.add(products);
    return _setValue(jsonEncode(products));
  }

  @override
  Future<void> deleteProduct(String uuid) async {
    final List<Product> products = <Product>[..._producStreamController.value];
    final int productIndex = products.indexWhere((Product p) => p.uuid == uuid);

    if (productIndex == -1) throw ProductNotFoundException();
    products.removeAt(productIndex);
    _producStreamController.add(products);
    return _setValue(jsonEncode(products));
  }

  @override
  Future<void> close() => _producStreamController.close();
}
