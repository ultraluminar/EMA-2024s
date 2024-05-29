import 'package:fridge_manager/pages/overview_page/overview_page.dart';

part of 'overview_page_bloc.dart';

enum OverviewPageStatus { initial, loading, success, failure }

sealed class OverviewPageState extends Equatable {
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

  @override
  List<Object> get props => [];
}

//TODO: file unfinished

final class OverviewPageInitial extends OverviewPageState {}
