import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/src/pages/edit_product/edit_product.dart';
import 'package:fridge_manager/src/pages/products_page/products_page.dart';
import 'package:products_repository/products_repository.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsPageBloc(
        productsRepository: context.read<ProductsRepository>(),
      )..add(const ProductsPageSubscriptionRequested()),
      child: const ProductsView(),
    );
  }
}

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).productsAppBarTitle),
        actions: const [
          ProductsFilterButton(),
          ProductsOptionsButton(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        key: const Key("homeView_addProduct_floatingActionButton"),
        onPressed: () => Navigator.of(context).push(EditProductPage.route()),
        child: const Icon(Icons.add),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ProductsPageBloc, ProductsPageState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == ProductsPageStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).productsErrorSnackbarText),
                    ),
                  );
              }
            },
          ),
          /*
          BlocListener<ProductsPageBloc, ProductsPageState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedProduct != current.lastDeletedProduct &&
                current.lastDeletedProduct != null,
            listener: (context, state) {
              final deletedProduct = state.lastDeletedProduct!;
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      S.of(context).productsDeletedProductSnackbarText(
                        deletedProduct.name,
                      ),
                    ),
                    action: SnackBarAction(
                      label: S.of(context).productsDeletedProductSnackbarUndo,
                      onPressed: () => context
                          .read<ProductsPageBloc>()
                          .add(ProductsPageProductAdded(deletedProduct)),
                    ),
                  ),
                );
            },
          ),
          */
        ],
        child: BlocBuilder<ProductsPageBloc, ProductsPageState>(
          builder: (context, state) {
            if (state.products.isEmpty) {
              switch (state.status) {
                case ProductsPageStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ProductsPageStatus.success:
                  return Center(
                    child: Text(
                      S.of(context).productsEmptyView,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                default:
                  return const SizedBox();
              }
            }
            return Scrollbar(
              child: ListView(
                children: [
                  for (final product in state.filtredProducts)
                    ProductListTile(
                      product: product,
                      onDismissed: (_) {
                        context
                            .read<ProductsPageBloc>()
                            .add(ProductsPageProductDeleted(product));
                      },
                      onTap: () {
                        Navigator.of(context).push<void>(
                          EditProductPage.route(initialProduct: product),
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
