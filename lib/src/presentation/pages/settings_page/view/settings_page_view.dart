import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/data/settings_api/settings_api.dart';
import 'package:fridge_manager/src/presentation/pages/settings_page/widgets/theme_list_tile.dart';
import 'package:fridge_manager/src/presentation/pages/settings_page/widgets/widgets.dart';
import 'package:hive_flutter/adapters.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) {
        return const SettingsPage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SettingsPageView();
  }
}

class SettingsPageView extends StatelessWidget {
  const SettingsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Settings'),
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          ValueListenableBuilder(
            valueListenable: HiveSettingsApi.box.listenable(),
            builder: (context, box, child) {
              log("Box.isEmpty: ${box.isEmpty}");
              final TimeOfDayJson? dailyNotificationTime = box.isEmpty
                  ? null
                  : box
                      .get(HiveSettingsApi.settingsIndex)
                      ?.dailyNotificationTime;
              final ThemeMode themeMode =
                  box.get(HiveSettingsApi.settingsIndex)!.themeMode;
              log("after");
              return SliverList(
                delegate: SliverChildListDelegate(
                  [
                    DailyNotificationTimeListTile(
                      dailyNotificationTime: dailyNotificationTime,
                      settingsBox: box,
                    ),
                    ThemeListTile(
                      themeMode: themeMode,
                      settingsBox: box,
                    ),
                    for (var index = 0; index < 15; index++)
                      ListTile(title: Text(index.toString())),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
