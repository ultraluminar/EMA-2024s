import 'package:fridge_manager/src/data/settings_api/settings_api.dart';

abstract class SettingsApi {
  const SettingsApi();

  Future<Settings> getSettings();

  Future<void> setSettings(Settings settings);
}
