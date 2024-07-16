import 'package:fridge_manager/src/data/products_api/products_api.dart';

enum ProductsViewFilter { all, stillGood, expired }

extension ProductsViewFilterX on ProductsViewFilter {
  bool apply(Product product) {
    switch (this) {
      case ProductsViewFilter.all:
        return true;
      case ProductsViewFilter.stillGood:
        return !product.isExpired;
      case ProductsViewFilter.expired:
        return product.isExpired;
    }
  }

  Iterable<Product> applyAll(Iterable<Product> product) {
    return product.where(apply);
  }
}
