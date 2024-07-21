import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/src/data/products_api/products_api.dart';
import 'package:fridge_manager/src/domain/products_repository/products_repository.dart';
import 'package:fridge_manager/src/presentation/pages/edit_product/edit_product.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.bodySmall?.color;

    return Dismissible(
      key: ValueKey(product.uuid),
      onDismissed: (_) =>
          context.read<ProductsRepository>().deleteProduct(product.uuid),
      direction: DismissDirection.startToEnd,
      background: Container(
        alignment: Alignment.centerLeft,
        color: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(
          Icons.restaurant,
          color: Color(0xAAFFFFFF),
        ),
      ),
      child: ListTile(
        onTap: () => Navigator.of(context).push<void>(EditProductPage.route(
            productPrototype: ProductPrototype.fromProduct(product))),
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
                  .productListTileDescriptionExpired(product.expiresInDays * -1)
              : S
                  .of(context)
                  .productListTileDescriptionNotExpired(product.expiresInDays),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
