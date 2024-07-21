import 'package:flutter/material.dart';
import 'package:fridge_manager/src/presentation/pages/settings_page/widgets/theme_dialog.dart';

class ThemeListTile extends StatelessWidget {
  const ThemeListTile({
    required this.themeMode,
    super.key,
  });

  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Theme'),
      subtitle: Text(themeMode.name),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const ThemeDialog(),
        );
      },
    );
  }
}
