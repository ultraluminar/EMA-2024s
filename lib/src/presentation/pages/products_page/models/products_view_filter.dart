import 'package:fridge_manager/src/data/hive_products_api/hive_products_api.dart';
import 'package:fridge_manager/src/data/products_api/products_api.dart';

enum ProductSort {
  byName,
  byExpiresAt;

  Comparator<Product> get function {
    switch (this) {
      case byName:
        return (a, b) => a.name.compareTo(b.name);
      case byExpiresAt:
        return (a, b) => a.expiresAt.compareTo(b.expiresAt);
    }
  }

  String toJson() => name;
  factory ProductSort.fromJson(String json) => ProductSort.values.byName(json);
}

enum ProductFilter {
  isExpired,
  notExpired,
  all;

  bool Function(Product) get filter {
    switch (this) {
      case isExpired:
        return (product) => product.isExpired;
      case notExpired:
        return (product) => !product.isExpired;
      case all:
        return (product) => true;
    }
  }

  Iterable<Product> filterProducts(Iterable<Product> products) =>
      products.where(filter);

  String toJson() => name;
  factory ProductFilter.fromJson(String json) =>
      ProductFilter.values.byName(json);
}
