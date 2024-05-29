import 'package:flutter/material.dart';

class OverviewFilterButton extends StatelessWidget {
  const OverviewFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.filter_list_rounded),
      onPressed: () => ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Filter button pressed'),
          ),
        ),
    );
  }
}

// TODO: implement PopupMenu