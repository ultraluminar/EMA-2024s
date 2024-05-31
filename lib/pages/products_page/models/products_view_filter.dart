import 'package:products_api/products_api.dart';


enum ProductsViewFilter { all, consumed, unconsumed }

extension ProductsViewFilterX on ProductsViewFilter{
  bool apply(Product product) {
    switch (this) {
      case ProductsViewFilter.all:
        return true;
      case ProductsViewFilter.consumed:
        // TODO: should be implemented correctly
        return product.consumed_at != null;
      case ProductsViewFilter.unconsumed:
        // TODO: should be implemented correctly
        return product.consumed_at == null;
    }
  }
  Iterable<Product> applyAll(Iterable<Product> product) {
    return product.where(apply);
  }

}
