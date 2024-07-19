import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:fridge_manager/src/data/settings_api/settings_api.dart';
import 'package:hive_flutter/hive_flutter.dart';

typedef SettingsBox = Box<Settings>;

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final int typeId = 1;

  @override
  Settings read(BinaryReader reader) {
    return Settings.fromJson(jsonDecode(reader.read()));
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    log("writer");
    writer.write(jsonEncode(obj.toJson()));
    log("after writer");
  }
}

class HiveSettingsApi implements SettingsApi {
  HiveSettingsApi._new();

  late final SettingsBox _box;
  static const int settingsIndex = 0;

  static Future<HiveSettingsApi> get instance async {
    final instance = HiveSettingsApi._new();
    instance._box = await Hive.openBox<Settings>('settingsBox');
    if (instance._box.isEmpty) {
      await instance.setSettings(
        const Settings(
          dailyNotificationTime: TimeOfDayJson(hour: 9),
        ),
      );
    }
    return instance;
  }

  ValueListenable<SettingsBox> getListenable() => _box.listenable();

  @override
  Future<Settings> getSettings() async => _box.get(settingsIndex)!;

  @override
  Future<void> setSettings(Settings settings) async {
    log("setSettings");
    await _box.put(settingsIndex, settings);
    log("after setSettings");
  }
}
