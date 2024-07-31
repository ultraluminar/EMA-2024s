import 'package:flutter/foundation.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';

abstract class SettingsApi {
  const SettingsApi();

  static late final ValueListenable listenable;

  static Future<void> setSettings(Settings settings) {
    throw UnimplementedError();
  }
}
