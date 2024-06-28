import 'package:fridge_manager/src/data/storage_location_api/storage_location_api.dart';

// TODO: add docstrings
abstract class StorageLocationApi {
  const StorageLocationApi();

  Stream<List<StorageLocation>> getAllStorageLocations();

  Future<void> saveStorageLocation(StorageLocation storageLocation);

  Future<void> deleteStorageLocation(String id);

  Future<void> close();
}

class StorageLocationNotFoundException implements Exception {}
