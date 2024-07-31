import 'package:flutter/material.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/presentation/pages/settings_page/widgets/theme_dialog.dart';

class ThemeListTile extends StatelessWidget {
  const ThemeListTile({super.key});

  String getThemeModeString(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return S().settingsPageThemeListTileSystem;
      case ThemeMode.light:
        return S().settingsPageThemeListTileLight;
      case ThemeMode.dark:
        return S().settingsPageThemeListTileDark;
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
          title: Text(S.of(context).settingsPageThemeListTileTitle),
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
