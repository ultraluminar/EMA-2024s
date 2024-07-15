part of 'edit_product_cubit.dart';

enum Status { initial, loading, success, failure }

extension StatusX on Status {
  bool get isLoadingOrSuccess =>
      [Status.loading, Status.success].contains(this);
}

class EditProductState extends Equatable {
  const EditProductState({
    required this.productPrototype,
    this.status = Status.initial,
  });

  final ProductPrototype productPrototype;
  final Status status;

  EditProductState copyWith({
    ProductPrototype? productPrototype,
    Status? status,
  }) =>
      EditProductState(
        productPrototype: productPrototype ?? this.productPrototype,
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [productPrototype, status];
}
