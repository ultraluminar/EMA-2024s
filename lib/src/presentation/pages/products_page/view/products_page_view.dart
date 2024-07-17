import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/src/data/products_api/products_api.dart';
import 'package:fridge_manager/src/domain/products_repository/products_repository.dart';
import 'package:fridge_manager/src/presentation/pages/edit_product/edit_product.dart';
import 'package:fridge_manager/src/presentation/pages/products_page/products_page.dart';
import 'package:fridge_manager/src/presentation/pages/scanner_page/view/scanner_page_view.dart';
import 'package:fridge_manager/src/presentation/widgets/widgets.dart';

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
        title: Text.rich(
          TextSpan(
              text: S.of(context).productsAppBarTitle,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        actions: const <Widget>[
          ProductsFilterButton(),
          SettingsButton(),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        type: ExpandableFabType.up,
        distance: 50,
        openButtonBuilder: DefaultFloatingActionButtonBuilder(
          child: const Icon(Icons.edit),
        ),
        childrenAnimation: ExpandableFabAnimation.none,
        childrenOffset: const Offset(-4, 0),
        children: [
          Row(
            children: [
              const Text("Manuell hinzufügen"),
              const SizedBox(width: 20),
              FloatingActionButton.small(
                heroTag: "FloatingActionButtonEdit",
                child: const Icon(Icons.edit_outlined),
                onPressed: () => Navigator.of(context).push(
                  EditProductPage.route(
                      productPrototype: const ProductPrototype()),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text("Barcode Scanner"),
              const SizedBox(width: 20),
              FloatingActionButton.small(
                heroTag: "FloatingActionBuzzonScan",
                child: const Icon(Icons.camera_alt_outlined),
                onPressed: () => Navigator.of(context).push(
                  ScannerPage.route(),
                ),
              ),
            ],
          ),
        ],
      ),
      // FloatingActionButton(
      //   key: const Key("homeView_addProduct_floatingActionButton"),
      //   onPressed: () => Navigator.of(context).push(ScannerPage.route()),
      //   child: const Icon(Icons.add),
      // ),
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
                        // FIXME: delete not working
                        context
                            .read<ProductsPageBloc>()
                            .add(ProductsPageProductDeleted(product));
                      },
                      onTap: () {
                        Navigator.of(context).push<void>(
                          EditProductPage.route(
                              productPrototype:
                                  ProductPrototype.fromProduct(product)),
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
