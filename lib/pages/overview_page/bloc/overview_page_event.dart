part of 'overview_page_bloc.dart';

sealed class OverviewPageEvent extends Equatable {
  const OverviewPageEvent();

  @override
  List<Object> get props => [];
}

final class OverviewPageSubscriptionRequested extends OverviewPageEvent {
  const OverviewPageSubscriptionRequested();
}

/*
final class OverviewPageProductCompletionToggled extends OverviewPageEvent {
  const OverviewPageProductCompletionToggled({
    required this.product,
    required this.isCompleted,
  });

  final Product product;
  final bool isCompleted;

  @override
  List<Object> get props => [product, isCompleted];
}

final class OverviewPageProductDeleted extends OverviewPageEvent {
  const OverviewPageProductDeleted(this.product);

  final Product product;

  @override
  List<Object> get props => [product];
}

final class OverviewPageUndoDeletionRequested extends OverviewPageEvent {
  const OverviewPageUndoDeletionRequested();
}
*/

class OverviewPageFilterChanged extends OverviewPageEvent {
  const OverviewPageFilterChanged(this.filter);

  final ProductsViewFilter filter;

  @override
  List<Object> get props => [filter];
}
/*
class OverviewPageToggleAllRequested extends OverviewPageEvent {
  const OverviewPageToggleAllRequested();
}
*/
