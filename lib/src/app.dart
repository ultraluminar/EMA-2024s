import 'package:flutter/material.dart';

import 'appPages/homePage.dart';
import 'appPages/productsPage.dart';
import 'appPages/recipesPage.dart';

class FridgeManager extends StatelessWidget {
  const FridgeManager({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fridge Manager',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightGreen,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightGreen,
          brightness: Brightness.dark,
        ),
      ),
      home: const FridgeManagerScaffold(),
    );
  }
}

class FridgeManagerScaffold extends StatefulWidget {
  const FridgeManagerScaffold({super.key});

  @override
  State<FridgeManagerScaffold> createState() => _FridgeManagerScaffoldState();
}

class _FridgeManagerScaffoldState extends State<FridgeManagerScaffold> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fridge Manager'),
        backgroundColor: colorScheme.secondaryContainer,
      ),
      body: <Widget>[
        const HomePage(),
        const RecipesPage(),
        const ProductsPage(),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.description),
            icon: Icon(Icons.description_outlined),
            label: 'Rezepte',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.kitchen),
            icon: Icon(Icons.kitchen_outlined),
            label: 'Produkte',
          ),
        ],
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }
}
