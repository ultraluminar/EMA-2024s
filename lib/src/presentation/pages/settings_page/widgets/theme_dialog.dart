import 'package:flutter/material.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/presentation/pages/settings_page/widgets/widgets.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            HiveSettingsApi.listenable(settings: [Settings.themeMode]),
        builder: (context, box, child) {
          return AlertDialog(
            title: const Text('Theme'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: ThemeMode.values.map((themeMode) {
                return ThemeModeRadioListTile(
                  themeMode: themeMode,
                  settingsBox: box,
                );
              }).toList(),
            ),
          );
        });
  }
}
