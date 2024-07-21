import 'package:flutter/foundation.dart';
import 'package:fridge_manager/src/data/settings_api/settings_api.dart';

abstract class SettingsApi {
  const SettingsApi();

  static late final ValueListenable listenable;

  static Future<void> setSettings(Settings settings) {
    throw UnimplementedError();
  }
}
