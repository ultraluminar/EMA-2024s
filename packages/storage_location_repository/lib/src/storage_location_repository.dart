import 'package:storage_location_api/storage_location_api.dart';

// TODO: add docstrings
class StorageLocationRepository {
  const StorageLocationRepository({
    required StorageLocationApi storageLocationApi,
  }) : _storageLocationApi = storageLocationApi;

  final StorageLocationApi _storageLocationApi;

  Stream<List<StorageLocation>> getAllStorageLocations() =>
      _storageLocationApi.getAllStorageLocations();

  Future<void> saveStorageLocation(StorageLocation storageLocation) =>
      _storageLocationApi.saveStorageLocation(storageLocation);

  Future<void> deleteStorageLocation(String uuid) =>
      _storageLocationApi.deleteStorageLocation(uuid);
}
