import 'package:fridge_manager/src/data/products_api/products_api.dart';
import 'package:fridge_manager/src/data/products_api/src/models/models.dart';
import 'package:uuid/uuid.dart';

class ProductPrototype {
  const ProductPrototype({
    this.name,
    this.expiresAt,
    this.uuid,
    this.barcode,
  });

  ProductPrototype.fromProduct(Product product)
      : name = product.name,
        expiresAt = product.expiresAt,
        uuid = product.uuid,
        barcode = product.barcode;

  ProductPrototype.fromScan(String name, String barcode)
      : this(name: name, barcode: barcode);

  final String? name;
  final ExpirationDate? expiresAt;
  final String? uuid;
  final String? barcode;

  ProductPrototype copyWith({
    String? name,
    ExpirationDate? expiresAt,
  }) =>
      ProductPrototype(
        name: name ?? this.name,
        expiresAt: expiresAt ?? this.expiresAt,
        uuid: uuid,
        barcode: barcode,
      );

  Product toProduct() => Product(
        name: name!,
        expiresAt: expiresAt!,
        uuid: uuid ?? const Uuid().v4(),
        barcode: barcode,
      );
}
