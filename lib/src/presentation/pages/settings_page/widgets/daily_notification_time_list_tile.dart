import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/data/settings_api/settings_api.dart';

class DailyNotificationTimeListTile extends StatelessWidget {
  const DailyNotificationTimeListTile({
    required this.dailyNotificationTime,
    super.key,
  });

  final TimeOfDayJson? dailyNotificationTime;

  @override
  Widget build(BuildContext context) {
    final hiveSettingsApi = context.read<HiveSettingsApi>();

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
            await hiveSettingsApi.setSettings(
              Settings(
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
