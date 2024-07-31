import 'package:flutter/material.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/presentation/pages/products_page/products_page.dart';

class ProductsFilterButton extends StatelessWidget {
  const ProductsFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      onSelected: (filter) {
        HiveSettingsApi.listenable().value.put(
              Settings.productFilter.name,
              filter,
            );
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: ProductFilter.all,
          child: Text(S.of(context).productsFilterButtonAll),
        ),
        PopupMenuItem(
          value: ProductFilter.notExpired,
          child: Text(S.of(context).productsFilterButtonNotExpired),
        ),
        PopupMenuItem(
          value: ProductFilter.isExpired,
          child: Text(S.of(context).productsFilterButtonExpired),
        ),
      ],
      icon: const Icon(Icons.filter_list_rounded),
    );
  }
}
