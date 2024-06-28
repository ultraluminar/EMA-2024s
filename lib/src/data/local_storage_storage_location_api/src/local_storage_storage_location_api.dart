import 'dart:convert';

import 'package:fridge_manager/src/data/storage_location_api/storage_location_api.dart';
import 'package:fridge_manager/src/data/local_storage_storage_location_api/local_storage_storage_location_api.dart';
import 'package:rxdart/subjects.dart';

// TODO: add docstrings
class LocalStorageStorageLocationApi extends StorageLocationApi {
  LocalStorageStorageLocationApi({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences {
    _init();
  }

  final SharedPreferences _sharedPreferences;

  late final _storageLocationStreamController =
      BehaviorSubject<List<StorageLocation>>.seeded(
    const <StorageLocation>[],
  );

  static const String _key = String.fromEnvironment('SHARED_PREFERENCES_KEY');

  String? _getValue() => _sharedPreferences.getString(_key);
  Future<void> _setValue(String value) =>
      _sharedPreferences.setString(_key, value);

  List<StorageLocation> storageLocationsFromJson(String json) =>
      List<JsonMap>.from(
        jsonDecode(json) as List,
      ).map((jsonMap) => StorageLocation.fromJson(jsonMap)).toList();

  void _init() {
    final storageLocationJson = _getValue();
    _storageLocationStreamController.add(
      <StorageLocation>[
        if (storageLocationJson != null)
          ...storageLocationsFromJson(storageLocationJson)
      ],
    );
  }

  @override
  Stream<List<StorageLocation>> getAllStorageLocations() =>
      _storageLocationStreamController.asBroadcastStream();

  @override
  Future<void> saveStorageLocation(StorageLocation storageLocation) {
    final List<StorageLocation> storageLocations = <StorageLocation>[
      ..._storageLocationStreamController.value
    ];
    final int storageLocationIndex = storageLocations
        .indexWhere((StorageLocation s) => s.uuid == storageLocation.uuid);
    if (storageLocationIndex != -1) {
      storageLocations[storageLocationIndex] = storageLocation;
    } else {
      storageLocations.add(storageLocation);
    }

    _storageLocationStreamController.add(storageLocations);
    return _setValue(jsonEncode(storageLocations));
  }

  @override
  Future<void> deleteStorageLocation(String uuid) async {
    final List<StorageLocation> storageLocations = <StorageLocation>[
      ..._storageLocationStreamController.value
    ];
    final int storageLocationIndex =
        storageLocations.indexWhere((StorageLocation s) => s.uuid == uuid);

    if (storageLocationIndex == -1) throw StorageLocationNotFoundException();
    storageLocations.removeAt(storageLocationIndex);
    _storageLocationStreamController.add(storageLocations);
    return _setValue(jsonEncode(storageLocations));
  }

  @override
  Future<void> close() => _storageLocationStreamController.close();
}
