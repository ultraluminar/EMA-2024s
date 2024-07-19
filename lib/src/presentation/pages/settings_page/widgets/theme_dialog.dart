import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final hiveSettingsApi = context.read<HiveSettingsApi>();

    void onChanged(ThemeMode value, SettingsBox settingsBox) async {
      await hiveSettingsApi.setSettings(
        settingsBox.get(HiveSettingsApi.settingsIndex)!.copyWith(
              themeMode: value,
            ),
      );
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }

    return ValueListenableBuilder(
        valueListenable: hiveSettingsApi.getListenable(),
        builder: (context, box, child) {
          final ThemeMode themeMode =
              box.get(HiveSettingsApi.settingsIndex)!.themeMode;

          return AlertDialog(
            title: const Text('Theme'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile(
                  title: const Text("System"),
                  value: ThemeMode.system,
                  groupValue: themeMode,
                  onChanged: (value) => onChanged(value!, box),
                ),
                RadioListTile(
                  title: const Text("Light"),
                  value: ThemeMode.light,
                  groupValue: themeMode,
                  onChanged: (value) => onChanged(value!, box),
                ),
                RadioListTile(
                  title: const Text("Dark"),
                  value: ThemeMode.dark,
                  groupValue: themeMode,
                  onChanged: (value) => onChanged(value!, box),
                ),
              ],
            ),
          );
        });
  }
}
