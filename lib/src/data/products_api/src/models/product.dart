import 'package:equatable/equatable.dart';
import 'package:fridge_manager/src/data/products_api/products_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product extends Equatable {
  const Product({
    required this.name,
    required this.expiresAt,
    required this.uuid,
    this.barcode,
  });

  final String name;
  final ExpirationDate expiresAt;
  final String uuid;
  final String? barcode;

  bool get isExpired => expiresAt.isExpired;
  int get expiresInDays => expiresAt.expiresInDays;

  factory Product.fromJson(JsonMap json) => _$ProductFromJson(json);

  JsonMap toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props => [name, expiresAt, uuid, barcode];
}
