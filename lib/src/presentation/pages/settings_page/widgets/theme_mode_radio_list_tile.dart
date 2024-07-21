import 'package:flutter/material.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeModeRadioListTile extends StatelessWidget {
  const ThemeModeRadioListTile({
    required this.themeMode,
    required this.settingsBox,
    super.key,
  });

  final Box settingsBox;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(themeMode.name),
      value: themeMode,
      groupValue: themeMode,
      onChanged: (value) async {
        if (value == null) return;
        await settingsBox.put(Settings.themeMode.name, value);

        if (!context.mounted) return;
        Navigator.of(context).pop();
      },
    );
  }
}
