import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/presentation/pages/settings_page/widgets/theme_list_tile.dart';
import 'package:fridge_manager/src/presentation/pages/settings_page/widgets/widgets.dart';

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
            valueListenable: HiveSettingsApi.listenable(
              settings: [Settings.dailyNotificationTime, Settings.themeMode],
            ),
            builder: (context, box, child) {
              log("Box.isEmpty: ${box.isEmpty}");
              log("after");
              return SliverList(
                delegate: SliverChildListDelegate(
                  [
                    DailyNotificationTimeListTile(settingsBox: box),
                    ThemeListTile(
                        themeMode: box.get(Settings.themeMode)! as ThemeMode),
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
