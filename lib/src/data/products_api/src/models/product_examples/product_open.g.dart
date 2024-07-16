// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_open.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      expiresAt: ExpirationDate.fromJson(json['expiresAt'] as String),
      expiresDaysAfterOpen: (json['expiresDaysAfterOpen'] as num).toInt(),
      openedAt: json['openedAt'] == null
          ? null
          : ExpirationDate.fromJson(json['openedAt'] as String),
      consumedAt: json['consumedAt'] == null
          ? null
          : ExpirationDate.fromJson(json['consumedAt'] as String),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'expiresAt': instance.expiresAt.toJson(),
      'expiresDaysAfterOpen': instance.expiresDaysAfterOpen,
      'openedAt': instance.openedAt?.toJson(),
      'consumedAt': instance.consumedAt?.toJson(),
    };
