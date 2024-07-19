import 'package:flutter/material.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/presentation/pages/settings_page/widgets/theme_dialog.dart';

class ThemeListTile extends StatelessWidget {
  const ThemeListTile({
    required this.themeMode,
    required this.settingsBox,
    super.key,
  });

  final ThemeMode themeMode;
  final SettingsBox settingsBox;

  String getThemeModeString(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Theme'),
      subtitle: Text(getThemeModeString(themeMode)),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const ThemeDialog(),
        );
      },
    );
  }
}
