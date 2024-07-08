import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:fridge_manager/src/data/products_api/products_api.dart';
import 'package:fridge_manager/src/data/products_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_open.g.dart';

@JsonSerializable(explicitToJson: true)
class Product extends Equatable {
  const Product({
    required this.uuid,
    required this.name,
    required this.expiresAt,
    required this.expiresDaysAfterOpen,
    this.openedAt,
    this.consumedAt,
  });

  final String uuid;
  final String name;
  final ExpirationDate expiresAt;
  final int expiresDaysAfterOpen;

  final ExpirationDate? openedAt;
  final ExpirationDate? consumedAt;

  bool get isOpened => openedAt != null;
  bool get isConsumed => consumedAt != null;

  ExpirationDate? get expiresAtIfOpen =>
      openedAt?.addDays(expiresDaysAfterOpen);

  bool get isExpired {
    if (expiresAt.isExpired) return true;
    return expiresAtIfOpen?.isExpired ?? false;
  }

  int get expiresInDays =>
      ((expiresAt.isExpired || !isOpened) ? expiresAt : expiresAtIfOpen!)
          .expiresInDays;

  Product open() {
    assert(isOpened, "product already opened on $openedAt !");
    return copyWith(openedAt: ExpirationDate.today());
  }

  Product consume() {
    assert(isConsumed, "product already consumed on $consumedAt !");
    return copyWith(consumedAt: ExpirationDate.today());
  }

  Product copyWith({
    String? uuid,
    String? name,
    ExpirationDate? expiresAt,
    int? expiresDaysAfterOpen,
    ExpirationDate? openedAt,
    ExpirationDate? consumedAt,
  }) {
    return Product(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      expiresAt: expiresAt ?? this.expiresAt,
      expiresDaysAfterOpen: expiresDaysAfterOpen ?? this.expiresDaysAfterOpen,
      openedAt: openedAt ?? this.openedAt,
      consumedAt: consumedAt ?? this.consumedAt,
    );
  }

  factory Product.fromJson(JsonMap json) {
    log(json.toString());
    return _$ProductFromJson(json);
  }
  JsonMap toJson() => _$ProductToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        uuid,
        name,
        expiresAt,
        expiresDaysAfterOpen,
        openedAt,
        consumedAt,
      ];
}
