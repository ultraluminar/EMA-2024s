import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/src/data/hive_products_api/hive_products_api.dart';
import 'package:fridge_manager/src/data/hive_settings_api/hive_settings_api.dart';
import 'package:fridge_manager/src/presentation/pages/edit_product/edit_product.dart';
import 'package:fridge_manager/src/presentation/pages/products_page/products_page.dart';
import 'package:fridge_manager/src/presentation/pages/scanner_page/scanner_page.dart';
import 'package:fridge_manager/src/presentation/widgets/widgets.dart';
import 'package:hive_flutter/adapters.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProductsPageView();
  }
}

class ProductsPageView extends StatefulWidget {
  const ProductsPageView({super.key});

  @override
  State<StatefulWidget> createState() => ProductsPageViewState();
}

class ProductsPageViewState extends State<ProductsPageView> {
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            text: S.of(context).productsAppBarTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: const <Widget>[
          ProductsFilterButton(),
          SettingsButton(),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
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
                onPressed: () {
                  Navigator.of(context).push(EditProductPage.route(
                      productPrototype: const ProductPrototype()));
                  _key.currentState!.toggle();
                },
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
                onPressed: () {
                  Navigator.of(context).push(ScannerPage.route());
                  _key.currentState!.toggle();
                },
              ),
            ],
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: HiveProductsApi.box.listenable(),
        builder: (context, productBox, child) {
          if (productBox.isEmpty) {
            return Center(
              child: Text(
                S.of(context).productsEmptyView,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            );
          }
          return ValueListenableBuilder(
            valueListenable: HiveSettingsApi.box.listenable(),
            builder: (context, settingBox, child) {
              return ListView(
                children: (productBox.values.toList()
                      ..sort(settingBox
                          .get(HiveSettingsApi.settingsIndex)!
                          .productSort
                          .function))
                    .map(ProductListTile.new)
                    .toList(),
              );
            },
          );
        },
      ),
    );
  }
}
