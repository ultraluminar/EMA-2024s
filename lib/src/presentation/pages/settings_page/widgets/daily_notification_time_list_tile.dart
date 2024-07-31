import 'package:flutter/material.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/data/settings_api/settings_api.dart';

class DailyNotificationTimeListTile extends StatelessWidget {
  const DailyNotificationTimeListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveSettingsApi.listenable(
          settings: [Settings.dailyNotificationTime.name]),
      builder: (context, box, child) {
        final TimeOfDayJson? dailyNotificationTime =
            box.get(Settings.dailyNotificationTime.name);
        return ListTile(
          title: Text(S.of(context).settingsPageDailyNotificationTime),
          subtitle: Text(dailyNotificationTime?.toJson() ??
              S.of(context).settingsPageErrorText),
          onTap: () {
            showTimePicker(
              context: context,
              initialTime: dailyNotificationTime!.toTimeOfDay(),
            ).then(
              (value) async {
                if (value == null) return;
                await box.put(
                  Settings.dailyNotificationTime.name,
                  TimeOfDayJson.fromTimeOfDay(value),
                );
              },
            );
          },
        );
      },
    );
  }
}
