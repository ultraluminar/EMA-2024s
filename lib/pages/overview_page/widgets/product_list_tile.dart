import 'package:flutter/material.dart';
import 'package:products_api/products_api.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    required this.product,
    super.key,
    this.onTap,
  });

  final Product product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.bodySmall?.color;

    return Dismissible(
      key: Key('productListTile_dismissible_${product.uuid}'),
      // TODO: implement onDismissed
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
            "uuid: ${product.uuid}", // TODO: choose appropriate product field
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: onTap == null ? null : const Icon(Icons.chevron_right),
      ),
    );
  }
}
