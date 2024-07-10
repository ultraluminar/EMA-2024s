import 'package:equatable/equatable.dart';
import 'package:fridge_manager/src/data/products_api/products_api.dart';
import 'package:fridge_manager/src/data/products_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:openfoodfacts/openfoodfacts.dart' hide Product;
import 'package:uuid/uuid.dart';

part 'product.g.dart';

Future<Product> productFromBarcode({
  required String barcode,
  required ExpirationDate expiresAt,
}) async {
  if (!BarcodeValidator.isValid(barcode)) throw Exception("barcode invalid!");

  final ProductResultV3 result = await OpenFoodAPIClient.getProductV3(
      ProductQueryConfiguration(barcode, version: ProductQueryVersion.v3));

  return Product(
    expiresAt: expiresAt,
    name: result.product!.productName!,
    barcode: barcode,
  );
}

@JsonSerializable(explicitToJson: true)
class Product extends Equatable {
  Product({
    required this.name,
    required this.expiresAt,
    String? uuid,
    this.barcode = "",
  }) : uuid = uuid ?? const Uuid().v4();

  final String name;
  final ExpirationDate expiresAt;
  final String uuid;
  final String? barcode;

  Product copyWith({
    String? uuid,
    String? name,
    ExpirationDate? expiresAt,
    String? barcode,
  }) {
    return Product(
      name: name ?? this.name,
      expiresAt: expiresAt ?? this.expiresAt,
      uuid: uuid ?? this.uuid,
      barcode: barcode ?? this.barcode,
    );
  }

  bool get isExpired => expiresAt.isExpired;
  int get expiresInDays => expiresAt.expiresInDays;

  factory Product.fromJson(JsonMap json) => _$ProductFromJson(json);

  JsonMap toJson() => _$ProductToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [uuid, barcode, name, expiresAt];
}
