import 'package:flutter/material.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Theme'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // RadioListTile(value: value, groupValue: groupValue, onChanged: onChanged)
        ],
      ),
    );
  }
}
