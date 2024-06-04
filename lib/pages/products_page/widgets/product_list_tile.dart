import 'package:app_utils/app_utils.dart' show DateTimeX;
import 'package:flutter/material.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:products_api/products_api.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    required this.product,
    super.key,
    this.onDismissed,
    this.onTap,
  });

  final Product product;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  int daysDifferenceFromToday(DateTime date) =>
      date.date.difference(DateTime.now().date).inDays;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.bodySmall?.color;
    final expiresInDays = daysDifferenceFromToday(product.expires_at);

    return Dismissible(
      key: Key('productListTile_dismissible_${product.uuid}'),
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: theme.colorScheme.error,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(
          Icons.delete,
          color: Color(0xAAFFFFFF),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            // TODO: implement style
            color: captionColor,
            //decoration: TextDecoration.lineThrough,
          ),
        ),
        subtitle: Text(
          expiresInDays >= 0
          ? S.of(context).productListTileDescriptionNotExpired(expiresInDays)
          : S.of(context).productListTileDescriptionExpired(expiresInDays.abs()),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: onTap == null ? null : const Icon(Icons.chevron_right),
      ),
    );
  }
}
