import 'package:flutter/material.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/presentation/pages/products_page/products_page.dart';

class ProductsSortButton extends StatelessWidget {
  const ProductsSortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      onSelected: (sort) {
        HiveSettingsApi.listenable().value.put(
              Settings.productSort.name,
              sort,
            );
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: ProductSort.byName,
          child: Text(S.of(context).productsSortButtonName),
        ),
        PopupMenuItem(
          value: ProductSort.byExpiresAt,
          child: Text(S.of(context).productsSortButtonExpirationDate),
        ),
      ],
      icon: const Icon(Icons.sort_rounded),
    );
  }
}
