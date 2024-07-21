import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fridge_manager/src/data/products_api/src/models/json_map.dart';
import 'package:fridge_manager/src/data/settings_api/settings_api.dart';
import 'package:fridge_manager/src/presentation/pages/products_page/products_page.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings.g.dart';

@JsonSerializable(explicitToJson: true)
class Settings extends Equatable {
  const Settings({
    required this.dailyNotificationTime,
    required this.themeMode,
    required this.productFilter,
    required this.productSort,
  });

  final TimeOfDayJson dailyNotificationTime;
  final ThemeMode themeMode;
  final ProductFilter productFilter;
  final ProductSort productSort;

  Settings copyWith({
    TimeOfDayJson? dailyNotificationTime,
    ThemeMode? themeMode,
    ProductFilter? productFilter,
    ProductSort? productSort,
  }) =>
      Settings(
        dailyNotificationTime:
            dailyNotificationTime ?? this.dailyNotificationTime,
        themeMode: themeMode ?? this.themeMode,
        productFilter: productFilter ?? this.productFilter,
        productSort: productSort ?? this.productSort,
      );

  factory Settings.fromJson(JsonMap json) => _$SettingsFromJson(json);

  JsonMap toJson() => _$SettingsToJson(this);

  @override
  List<Object?> get props => [
        dailyNotificationTime,
        themeMode,
        productFilter,
        productSort,
      ];
}
