part of 'edit_product_bloc.dart';

enum EditProductStatus { initial, loading, success, failure }

extension EditProductStatusX on EditProductStatus {
  bool get isLoadingOrSuccess => [
        EditProductStatus.loading,
        EditProductStatus.success,
      ].contains(this);
}

class EditProductState extends Equatable {
  const EditProductState({
    this.name = "",
    this.expiresAt,
    this.status = EditProductStatus.initial,
    this.barcode,
  });

  EditProductState.fromProduct({
    required Product product,
    this.barcode,
  })  : name = product.name,
        expiresAt = product.expiresAt,
        status = EditProductStatus.initial;

  const EditProductState.fromScan({
    required this.name,
    required this.barcode,
    this.expiresAt,
    this.status = EditProductStatus.initial,
  });

  final String name;
  final ExpirationDate? expiresAt;
  final String? barcode;

  final EditProductStatus status;

  EditProductState copyWith({
    String? name,
    ExpirationDate? expiresAt,
    int? expiresDaysAfterOpen,
    EditProductStatus? status,
  }) =>
      EditProductState(
        name: name ?? this.name,
        expiresAt: expiresAt ?? this.expiresAt,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [name, expiresAt, status];
}
