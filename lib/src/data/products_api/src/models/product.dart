import 'package:equatable/equatable.dart';
import 'package:fridge_manager/src/data/products_api/products_api.dart';
import 'package:fridge_manager/src/data/products_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product extends Equatable {
  const Product({
    required this.uuid,
    required this.productId,
    required this.name,
    required this.expiresAt,
  });

  final String uuid;
  final String productId;
  final String name;
  final ExpirationDate expiresAt;

  Product copyWith({
    String? uuid,
    String? name,
    String? productId,
    ExpirationDate? expiresAt,
  }) {
    return Product(
      uuid: uuid ?? this.uuid,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  bool get isExpired => expiresAt.isExpired;
  int get expiresInDays => expiresAt.expiresInDays;

  factory Product.fromJson(JsonMap json) => _$ProductFromJson(json);

  JsonMap toJson() => _$ProductToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [uuid, productId, name, expiresAt];
}
