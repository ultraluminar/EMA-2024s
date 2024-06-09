import 'package:equatable/equatable.dart';
import 'package:fridge_manager/src/shared/app_utils/app_utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:products_api/products_api.dart';
import 'package:uuid/uuid.dart';

part 'product.g.dart';

// TODO: add docstrings
@immutable
@JsonSerializable()
class Product extends Equatable {
  // TODO: check if constructor should be const
  Product({
    required this.product_id,
    required this.name,
    required this.expires_at,
    required this.owner,
    required this.tags,
    String? uuid,
    DateTime? stored_at,
    this.consumed_at,
  })  : uuid = uuid ?? const Uuid().v4(),
        stored_at = stored_at ?? DateTime.now();

  final String product_id;
  final String uuid;
  final String name;
  final DateTime expires_at;
  final DateTime stored_at;
  final DateTime? consumed_at;
  // TODO: use dedicated Datatype (e.g. Person) when new Model exist
  final String owner;

  final List<String> tags;

  int get expiresInDays =>
      DateTime.now().date.difference(expires_at.date).inDays;

  int get expiredDaysAgo => expiresInDays * -1;

  bool get isExpired => expiresInDays < 0;

  Product copyWith({
    String? product_id,
    String? name,
    DateTime? expires_at,
    String? owner,
    List<String>? tags,
    String? uuid,
    DateTime? stored_at,
    DateTime? consumed_at,
  }) {
    return Product(
      product_id: product_id ?? this.product_id,
      name: name ?? this.name,
      expires_at: expires_at ?? this.expires_at,
      owner: owner ?? this.owner,
      tags: tags ?? this.tags,
      uuid: uuid ?? this.uuid,
      stored_at: stored_at ?? this.stored_at,
      consumed_at: consumed_at ?? this.consumed_at,
    );
  }

  static Product fromJson(JsonMap json) => _$ProductFromJson(json);

  JsonMap toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props => [
        product_id,
        uuid,
        name,
        expires_at,
        stored_at,
        consumed_at,
        owner,
        tags,
      ];
}
