import 'package:flutter/material.dart';
import 'package:fridge_manager/src/presentation/pages/settings_page/view/settings_page_view.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings_outlined),
      onPressed: () => {Navigator.push(context, SettingsPage.route())},
    );
  }
}
