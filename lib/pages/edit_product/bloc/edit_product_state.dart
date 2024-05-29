part of 'edit_product_bloc.dart';

enum EditProductStatus { initial, loading, success, failure }

extension EditProductStatusX on EditProductStatus {
  bool get isLoadingOrSuccess => [
        EditProductStatus.loading,
        EditProductStatus.success,
      ].contains(this);
}

final class EditProductState extends Equatable {
  EditProductState({
    this.status = EditProductStatus.initial,
    this.initialProduct,
    this.name = "",
    this.productId = "",
    DateTime? expiresAt,
    DateTime? storedAt,
    this.owner = "",
    this.tags = const [],
  })  : expiresAt = expiresAt ?? DateTime.now(),
        storedAt = storedAt ?? DateTime.now();

  final EditProductStatus status;
  final Product? initialProduct;

  final String name;
  final String productId;
  final DateTime expiresAt;
  final DateTime storedAt;
  final String owner;
  final List<String> tags;

  bool get isNewProduct => initialProduct == null;

  EditProductState copyWith({
    EditProductStatus? status,
    Product? initialProduct,
    String? name,
    DateTime? expiresAt,
    DateTime? storedAt,
    String? owner,
    List<String>? tags,
  }) {
    return EditProductState(
      status: status ?? this.status,
      initialProduct: initialProduct ?? this.initialProduct,
      name: name ?? this.name,
      expiresAt: expiresAt ?? this.expiresAt,
      storedAt: storedAt ?? this.storedAt,
      owner: owner ?? this.owner,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object> get props =>
      [status, name, expiresAt, storedAt, owner, tags]; // initialProduct!,
}
