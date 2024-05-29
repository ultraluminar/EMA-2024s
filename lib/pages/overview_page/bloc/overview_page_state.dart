part of 'overview_page_bloc.dart';

enum OverviewPageStatus { initial, loading, success, failure }

final class OverviewPageState extends Equatable {
  const OverviewPageState({
    this.status = OverviewPageStatus.initial,
    this.products = const [],
    this.filter = ProductsViewFilter.all,
    this.lastDeletedProduct,
  });

  final OverviewPageStatus status;
  final List<Product> products;
  final ProductsViewFilter filter;
  final Product? lastDeletedProduct;

  Iterable<Product> get filtredProducts => filter.applyAll(products);

  OverviewPageState copyWith({
    OverviewPageStatus Function()? status,
    List<Product> Function()? products,
    ProductsViewFilter Function()? filter,
    Product? Function()? lastDeletedProduct,
  }) {
    return OverviewPageState(
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
}
