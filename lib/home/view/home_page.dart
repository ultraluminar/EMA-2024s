import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/home/home.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/pages/edit_product/edit_product.dart';
import 'package:fridge_manager/pages/overview_page/overview_page.dart';
import 'package:fridge_manager/pages/products_page/products_page.dart';
import 'package:fridge_manager/pages/recipes_page/recipes_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [
          OverviewPageView(),
          RecipesPage(),
          ProductsPage(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        key: const Key("homeView_addProduct_floatingActionButton"),
        onPressed: () => Navigator.of(context).push(EditProductPage.route()),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTab.index,
        onDestinationSelected: (index) {
          context.read<HomeCubit>().setTab(HomeTab.values[index]);
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home),
            label: S.of(context).overviewPageNavigationBarLabel,
          ),
          NavigationDestination(
            icon: const Icon(Icons.book),
            label: S.of(context).recipesPageNavigationBarLabel,
          ),
          NavigationDestination(
            icon: const Icon(Icons.shopping_cart),
            label: S.of(context).productsPageNavigationBarLabel,
          ),
        ],
      ),
    );
  }
}
