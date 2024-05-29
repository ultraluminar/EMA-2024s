import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/pages/edit_product/edit_product.dart';
import 'package:fridge_manager/pages/overview_page/overview_page.dart';
import 'package:products_repository/products_repository.dart';

class OverviewPageView extends StatelessWidget {
  const OverviewPageView({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OverviewPageBloc(
        productsRepository: context.read<ProductsRepository>(),
      )..add(const OverviewPageSubscriptionRequested()),
      child: const OverviewView(),
    );
  }
}

class OverviewView extends StatelessWidget {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).overviewAppBarTitle),
        actions: const [
          OverviewFilterButton(),
          OverviewOptionsButton(),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<OverviewPageBloc, OverviewPageState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == OverviewPageStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).overviewErrorSnackbarText),
                    ),
                  );
              }
            },
          ),
          /*
          BlocListener<OverviewPageBloc, OverviewPageState>(
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
                      S.of(context).overviewDeletedProductSnackbarText(
                        deletedProduct.name,
                      ),
                    ),
                    action: SnackBarAction(
                      label: S.of(context).overviewDeletedProductSnackbarUndo,
                      onPressed: () => context
                          .read<OverviewPageBloc>()
                          .add(OverviewPageProductAdded(deletedProduct)),
                    ),
                  ),
                );
            },
          ),
          */
        ],
        child: BlocBuilder<OverviewPageBloc, OverviewPageState>(
          builder: (context, state) {
            if (state.products.isEmpty) {
              switch (state.status) {
                case OverviewPageStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case OverviewPageStatus.success:
                  return Center(
                    child: Text(
                      S.of(context).overviewEmptyView,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                default:
                  return const SizedBox();
              }
            }
            return CupertinoScrollbar(
              child: ListView(
                children: [
                  for (final product in state.products)
                    ProductListTile(
                      product: product,
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
