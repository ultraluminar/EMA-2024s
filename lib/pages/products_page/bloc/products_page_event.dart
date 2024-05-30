part of 'products_page_bloc.dart';

sealed class ProductsPageEvent extends Equatable {
  const ProductsPageEvent();

  @override
  List<Object> get props => [];
}

final class ProductsPageSubscriptionRequested extends ProductsPageEvent {
  const ProductsPageSubscriptionRequested();
}

/*
final class ProductsPageProductCompletionToggled extends ProductsPageEvent {
  const ProductsPageProductCompletionToggled({
    required this.product,
    required this.isCompleted,
  });

  final Product product;
  final bool isCompleted;

  @override
  List<Object> get props => [product, isCompleted];
}

final class ProductsPageProductDeleted extends ProductsPageEvent {
  const ProductsPageProductDeleted(this.product);

  final Product product;

  @override
  List<Object> get props => [product];
}

final class ProductsPageUndoDeletionRequested extends ProductsPageEvent {
  const ProductsPageUndoDeletionRequested();
}
*/

class ProductsPageFilterChanged extends ProductsPageEvent {
  const ProductsPageFilterChanged(this.filter);

  final ProductsViewFilter filter;

  @override
  List<Object> get props => [filter];
}
/*
class ProductsPageToggleAllRequested extends ProductsPageEvent {
  const ProductsPageToggleAllRequested();
}
*/
