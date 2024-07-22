import 'package:flutter/material.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/presentation/pages/settings_page/widgets/theme_dialog.dart';

class ThemeListTile extends StatelessWidget {
  const ThemeListTile({super.key});

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
    return ValueListenableBuilder(
      valueListenable:
          HiveSettingsApi.listenable(settings: [Settings.themeMode.name]),
      builder: (context, box, child) {
        final ThemeMode themeMode = box.get(Settings.themeMode.name);
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
      },
    );
  }
}
