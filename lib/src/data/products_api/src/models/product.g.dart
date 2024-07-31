// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      name: json['name'] as String,
      expiresAt: ExpirationDate.fromJson(json['expiresAt'] as String),
      uuid: json['uuid'] as String,
      barcode: json['barcode'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'expiresAt': instance.expiresAt.toJson(),
      'uuid': instance.uuid,
      'barcode': instance.barcode,
    };
