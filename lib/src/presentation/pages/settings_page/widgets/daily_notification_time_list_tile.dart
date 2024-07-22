import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/data/settings_api/settings_api.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DailyNotificationTimeListTile extends StatelessWidget {
  const DailyNotificationTimeListTile({
    required this.settingsBox,
    super.key,
  });

  final Box settingsBox;

  @override
  Widget build(BuildContext context) {
    final TimeOfDayJson? dailyNotificationTime =
        settingsBox.get(Settings.dailyNotificationTime.name);
    final initialTimeJson =
        dailyNotificationTime ?? const TimeOfDayJson(hour: 9);

    return ListTile(
      title: const Text('Tägliche Benachrichtigungszeit'),
      subtitle: Text(dailyNotificationTime?.toJson() ?? "No value here"),
      onTap: () {
        showTimePicker(
          context: context,
          initialTime: initialTimeJson.toTimeOfDay(),
        ).then(
          (value) async {
            if (value == null) return;
            log("before set");
            await settingsBox.put(
              Settings.dailyNotificationTime.name,
              TimeOfDayJson.fromTimeOfDay(value),
            );
            log("after");
          },
        );
      },
    );
  }
}
