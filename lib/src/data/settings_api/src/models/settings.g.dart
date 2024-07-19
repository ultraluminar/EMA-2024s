// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings(
      dailyNotificationTime:
          TimeOfDayJson.fromJson(json['dailyNotificationTime'] as String),
    );

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'dailyNotificationTime': instance.dailyNotificationTime.toJson(),
    };
