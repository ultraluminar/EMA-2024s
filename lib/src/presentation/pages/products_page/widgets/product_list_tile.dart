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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.bodySmall?.color;

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
          product.isExpired
              ? S
                  .of(context)
                  .productListTileDescriptionExpired(product.expiredDaysAgo)
              : S
                  .of(context)
                  .productListTileDescriptionNotExpired(product.expiresInDays),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: onTap == null ? null : const Icon(Icons.chevron_right),
      ),
    );
  }
}