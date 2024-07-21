import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fridge_manager/src/data/settings_api/settings_api.dart';
import 'package:fridge_manager/src/presentation/pages/products_page/models/models.dart';
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
  static const defaultSettings = Settings(
    dailyNotificationTime: TimeOfDayJson(hour: 9),
    themeMode: ThemeMode.system,
    productFilter: ProductFilter.all,
    productSort: ProductSort.byExpiresAt,
  );

  static const int settingsIndex = 0;
  static late final ValueListenable<SettingsBox> listenable;
  static SettingsBox get box => listenable.value;

  static Future<void> init() async {
    final settingsBox = await Hive.openBox<Settings>('settingsBox');
    listenable = settingsBox.listenable();
    if (box.isEmpty) await HiveSettingsApi.setSettings(defaultSettings);
  }

  static Future<void> setSettings(Settings settings) async {
    log("setSettings");
    await box.put(settingsIndex, settings);
    log("after setSettings");
  }
}
