part of 'edit_product_bloc.dart';

enum EditProductStatus { initial, loading, success, failure }

extension EditProductStatusX on EditProductStatus {
  bool get isLoadingOrSuccess => [
        EditProductStatus.loading,
        EditProductStatus.success,
      ].contains(this);
}

Product defaultProduct = Product(
  product_id: "",
  name: "",
  expires_at: DateTime.now(),
  owner: "",
  tags: const [],
);

final class EditProductState extends Equatable {
  EditProductState({
    required Product? initialProduct,
    this.status = EditProductStatus.initial,
  })  : isNewProduct = initialProduct == null,
        product = initialProduct ?? defaultProduct;

  final Product product;
  final EditProductStatus status;
  final bool isNewProduct;

  EditProductState copyWith({
    Product? product,
    EditProductStatus? status,
  }) {
    return EditProductState(
      initialProduct: product ?? this.product,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status, product]; // initialProduct!,
}
