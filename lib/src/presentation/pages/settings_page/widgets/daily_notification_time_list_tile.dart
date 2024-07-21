import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/data/settings_api/settings_api.dart';

class DailyNotificationTimeListTile extends StatelessWidget {
  const DailyNotificationTimeListTile({
    required this.dailyNotificationTime,
    required this.settingsBox,
    super.key,
  });

  final TimeOfDayJson? dailyNotificationTime;
  final SettingsBox settingsBox;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Tägliche Benachrichtigungszeit'),
      subtitle: Text(dailyNotificationTime?.toJson() ?? "No value here"),
      onTap: () {
        showTimePicker(
          context: context,
          initialTime: dailyNotificationTime?.toTimeOfDay() ??
              const TimeOfDay(hour: 9, minute: 0),
        ).then(
          (value) async {
            if (value == null) return;
            log("before set");
            await HiveSettingsApi.setSettings(
              settingsBox.get(HiveSettingsApi.settingsIndex)!.copyWith(
                    dailyNotificationTime: TimeOfDayJson.fromTimeOfDay(value),
                  ),
            );
            log("after");
          },
        );
      },
    );
  }
}
