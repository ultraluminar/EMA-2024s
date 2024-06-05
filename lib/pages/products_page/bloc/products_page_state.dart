part of 'products_page_bloc.dart';

enum ProductsPageStatus { initial, loading, success, failure }

final class ProductsPageState extends Equatable {
  const ProductsPageState({
    this.status = ProductsPageStatus.initial,
    this.products = const [],
    this.filter = ProductsViewFilter.all,
    this.lastDeletedProduct,
  });

  final ProductsPageStatus status;
  final List<Product> products;
  final ProductsViewFilter filter;
  final Product? lastDeletedProduct;

  Iterable<Product> get filtredProducts => filter.applyAll(products);

  ProductsPageState copyWith({
    ProductsPageStatus Function()? status,
    List<Product> Function()? products,
    ProductsViewFilter Function()? filter,
    Product? Function()? lastDeletedProduct,
  }) {
    return ProductsPageState(
      status: status != null ? status() : this.status,
      products: products != null ? products() : this.products,
      filter: filter != null ? filter() : this.filter,
      lastDeletedProduct: lastDeletedProduct != null
          ? lastDeletedProduct()
          : this.lastDeletedProduct,
    );
  }

  @override
  List<Object> get props => [
        status,
        products,
        filter,
        //lastDeletedProduct as Object,
      ];

  @override
  String toString() => 'ProductsPageState( $status )';
}
