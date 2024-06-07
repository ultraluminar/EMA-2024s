import 'dart:developer';

import 'package:fridge_manager/src/data/products_api/lib/products_api.dart';

enum ProductsViewFilter { all, stillGood, expired }

extension ProductsViewFilterX on ProductsViewFilter {
  bool apply(Product product) {
    log("name: ${product.name}, expiresInDays: ${product.expiresInDays}, isExpires: ${product.isExpired}");
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
