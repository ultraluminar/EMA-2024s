import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fridge_manager/src/data/products_api/src/models/json_map.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings.g.dart';

class TimeOfDayJson extends TimeOfDay {
  const TimeOfDayJson({
    required super.hour,
    super.minute = 0,
  });

  TimeOfDayJson.fromTimeOfDay(TimeOfDay timeOfDay)
      : this(hour: timeOfDay.hour, minute: timeOfDay.minute);

  factory TimeOfDayJson.fromJson(String time) {
    final parts = time.split(':');
    return TimeOfDayJson(
      hour: int.parse(parts.first),
      minute: int.parse(parts.last),
    );
  }

  TimeOfDay toTimeOfDay() => TimeOfDay(hour: hour, minute: minute);

  String toJson() {
    String addLeadingZeroIfNeeded(int value) {
      if (value < 10) {
        return '0$value';
      }
      return value.toString();
    }

    final String hourLabel = addLeadingZeroIfNeeded(hour);
    final String minuteLabel = addLeadingZeroIfNeeded(minute);

    return '$hourLabel:$minuteLabel';
  }
}

@JsonSerializable(explicitToJson: true)
class Settings extends Equatable {
  const Settings({
    required this.dailyNotificationTime,
    required this.themeMode,
  });

  final TimeOfDayJson dailyNotificationTime;
  final ThemeMode themeMode;

  Settings copyWith({
    TimeOfDayJson? dailyNotificationTime,
    ThemeMode? themeMode,
  }) =>
      Settings(
        dailyNotificationTime:
            dailyNotificationTime ?? this.dailyNotificationTime,
        themeMode: themeMode ?? this.themeMode,
      );

  factory Settings.fromJson(JsonMap json) => _$SettingsFromJson(json);

  JsonMap toJson() => _$SettingsToJson(this);

  @override
  List<Object?> get props => [dailyNotificationTime];
}
