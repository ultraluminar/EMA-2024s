// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      uuid: json['uuid'] as String,
      productId: json['productId'] as String,
      name: json['name'] as String,
      expiresAt: ExpirationDate.fromJson(json['expiresAt'] as String),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'productId': instance.productId,
      'name': instance.name,
      'expiresAt': instance.expiresAt.toJson(),
    };
