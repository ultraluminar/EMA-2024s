// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_old.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductOld _$ProductOldFromJson(Map<String, dynamic> json) => ProductOld(
      product_id: json['product_id'] as String,
      name: json['name'] as String,
      expires_at: DateTime.parse(json['expires_at'] as String),
      owner: json['owner'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      uuid: json['uuid'] as String?,
      stored_at: json['stored_at'] == null
          ? null
          : DateTime.parse(json['stored_at'] as String),
      consumed_at: json['consumed_at'] == null
          ? null
          : DateTime.parse(json['consumed_at'] as String),
    );

Map<String, dynamic> _$ProductOldToJson(ProductOld instance) =>
    <String, dynamic>{
      'product_id': instance.product_id,
      'uuid': instance.uuid,
      'name': instance.name,
      'expires_at': instance.expires_at.toIso8601String(),
      'stored_at': instance.stored_at.toIso8601String(),
      'consumed_at': instance.consumed_at?.toIso8601String(),
      'owner': instance.owner,
      'tags': instance.tags,
    };
