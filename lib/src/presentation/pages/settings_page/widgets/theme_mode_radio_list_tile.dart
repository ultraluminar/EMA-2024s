import 'package:flutter/material.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeModeRadioListTile extends StatelessWidget {
  const ThemeModeRadioListTile({
    required this.settingsBox,
    required this.value,
    required this.groupValue,
    super.key,
  });

  final Box settingsBox;
  final ThemeMode value;
  final ThemeMode groupValue;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(value.name),
      value: value,
      groupValue: groupValue,
      onChanged: (value) async {
        if (value == null) return;
        await settingsBox.put(Settings.themeMode.name, value);

        if (!context.mounted) return;
        Navigator.of(context).pop();
      },
    );
  }
}
