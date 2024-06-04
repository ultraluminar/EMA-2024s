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
  expires_at: DateTime.now().date,
  owner: "",
  tags: const [],
);

final class EditProductState extends Equatable {
  EditProductState({
    required Product? initialProduct,
    this.status = EditProductStatus.initial,
    this.expriredAtPicked = false,
  })  : isNewProduct = initialProduct == null,
        product = initialProduct ?? defaultProduct;

  final Product product;
  final EditProductStatus status;
  final bool isNewProduct;
  final bool expriredAtPicked;

  String dateOrEmpty(DateFormat dateFormat) =>
      (!expriredAtPicked && isNewProduct)
          ? ""
          : dateFormat.format(product.expires_at);

  EditProductState copyWith({
    Product? product,
    EditProductStatus? status,
    bool? expriredAtPicked,
  }) {
    return EditProductState(
      initialProduct: product ?? this.product,
      status: status ?? this.status,
      expriredAtPicked: expriredAtPicked ?? this.expriredAtPicked,
    );
  }

  @override
  List<Object> get props => [status, product]; // initialProduct!,
}
