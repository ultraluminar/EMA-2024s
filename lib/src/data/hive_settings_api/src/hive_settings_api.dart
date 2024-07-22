import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/data/settings_api/settings_api.dart';
import 'package:fridge_manager/src/presentation/pages/products_page/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum Settings {
  dailyNotificationTime,
  themeMode,
  productFilter,
  productSort,
}

class HiveSettingsApi implements SettingsApi {
  static final defaultSettings = {
    Settings.dailyNotificationTime.name: const TimeOfDayJson(hour: 9),
    Settings.themeMode.name: ThemeMode.system,
    Settings.productFilter.name: ProductFilter.all,
    Settings.productSort.name: ProductSort.byExpiresAt,
  };

  static late final Box _box;

  static ValueListenable<Box> listenable({List<String>? settings}) =>
      _box.listenable(keys: settings);

  static Future<void> init() async {
    Hive
      ..registerAdapter(TimeOfDayJsonAdapter())
      ..registerAdapter(ThemeModeAdapter())
      ..registerAdapter(ProductFilterAdapter())
      ..registerAdapter(ProductSortAdapter());

    _box = await Hive.openBox('settingsBox');
    if (_box.isEmpty) await _box.putAll(defaultSettings);
  }
}
