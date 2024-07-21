import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/src/presentation/pages/products_page/products_page.dart';

class ProductsFilterButton extends StatelessWidget {
  const ProductsFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    // final currentFilter = context.select<ProductsPageBloc, ProductsViewFilter>(
    //     (bloc) => bloc.state.filter);

    return PopupMenuButton<ProductsViewFilter>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      // initialValue: currentFilter,
      // tooltip: ,
      onSelected: (filter) {
        // context.read<ProductsPageBloc>().add(ProductsPageFilterChanged(filter));
      },
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: ProductsViewFilter.all,
          child: Text("all"),
        ),
        PopupMenuItem(
          value: ProductsViewFilter.stillGood,
          child: Text("still good"),
        ),
        PopupMenuItem(
          value: ProductsViewFilter.expired,
          child: Text("expired"),
        ),
      ],
      icon: const Icon(Icons.filter_list_rounded),
    );

    // return IconButton(
    //   icon: const Icon(Icons.filter_list_rounded),
    //   onPressed: () => ScaffoldMessenger.of(context)
    //     ..hideCurrentSnackBar()
    //     ..showSnackBar(
    //       const SnackBar(
    //         content: Text('Filter button pressed'),
    //       ),
    //     ),
    // );
  }
}
