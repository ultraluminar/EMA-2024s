import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/data/settings_api/settings_api.dart';
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
            valueListenable: HiveSettingsApi.listenable,
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
                    const ListTile(
                      title: Text("1"),
                    ),
                    const ListTile(
                      title: Text("2"),
                    ),
                    const ListTile(
                      title: Text("3"),
                    ),
                    const ListTile(
                      title: Text("4"),
                    ),
                    const ListTile(
                      title: Text("5"),
                    ),
                    const ListTile(
                      title: Text("6"),
                    ),
                    const ListTile(
                      title: Text("7"),
                    ),
                    const ListTile(
                      title: Text("8"),
                    ),
                    const ListTile(
                      title: Text("9"),
                    ),
                    const ListTile(
                      title: Text("10"),
                    ),
                    const ListTile(
                      title: Text("11"),
                    ),
                    const ListTile(
                      title: Text("12"),
                    ),
                    const ListTile(
                      title: Text("13"),
                    ),
                    const ListTile(
                      title: Text("14"),
                    ),
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
