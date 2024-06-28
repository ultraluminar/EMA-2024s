import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:fridge_manager/src/data/storage_location_api/storage_location_api.dart';
import 'package:uuid/uuid.dart';

part 'storage_location.g.dart';

// TODO: add docstrings
@immutable
@JsonSerializable()
class StorageLocation extends Equatable {
  StorageLocation({
    required this.name,
    String? uuid,
    this.description,
  }) : uuid = uuid ?? const Uuid().v4();

  final String uuid;
  final String name;
  final String? description;

  StorageLocation copyWith({
    String? name,
    String? uuid,
    String? description,
  }) {
    return StorageLocation(
      name: name ?? this.name,
      uuid: uuid ?? this.uuid,
      description: description ?? this.description,
    );
  }

  static StorageLocation fromJson(JsonMap json) =>
      _$StorageLocationFromJson(json);

  JsonMap toJson() => _$StorageLocationToJson(this);

  @override
  List<Object?> get props => [
        uuid,
        name,
        description,
      ];
}
