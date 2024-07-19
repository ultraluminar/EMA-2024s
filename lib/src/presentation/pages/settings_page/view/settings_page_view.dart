import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/data/settings_api/settings_api.dart';
import 'package:fridge_manager/src/presentation/pages/settings_page/widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => RepositoryProvider.value(
        value: context.read<HiveSettingsApi>(),
        child: const SettingsPage(),
      ),
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
    final hiveSettingsApi = context.read<HiveSettingsApi>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text('Settings'),
            // floating: true,
            // pinned: true,
          ),
          ValueListenableBuilder(
            valueListenable: hiveSettingsApi.getListenable(),
            builder: (context, box, child) {
              log("Box.isEmpty: ${box.isEmpty}");
              final TimeOfDayJson? dailyNotificationTime = box.isEmpty
                  ? null
                  : box
                      .get(HiveSettingsApi.settingsIndex)
                      ?.dailyNotificationTime;
              log("after");
              return SliverList(
                delegate: SliverChildListDelegate(
                  [
                    DailyNotificationTimeListTile(
                      dailyNotificationTime: dailyNotificationTime,
                    ),

                    // ListTile(
                    //   title: const Text('Theme'),
                    //   subtitle: const Text('System'),
                    //   onTap: () {
                    //     showDialog(
                    //       context: context,
                    //       builder: (context) => const ThemeDialog(),
                    //     );
                    //   },
                    // ),
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
