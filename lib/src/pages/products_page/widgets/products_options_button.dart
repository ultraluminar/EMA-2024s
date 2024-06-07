import 'package:flutter/material.dart';

class ProductsOptionsButton extends StatelessWidget {
  const ProductsOptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.more_vert_rounded),
      onPressed: () => ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Options button pressed'),
          ),
        ),
    );
  }
}

// TODO: implement PopupMenu
