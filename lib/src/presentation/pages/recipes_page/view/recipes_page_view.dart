import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/src/presentation/home/cubit/home_cubit.dart';
import 'package:fridge_manager/src/presentation/widgets/widgets.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            text: S.of(context).recipesAppBarTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: const <Widget>[SettingsButton()],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(S.of(context).nothingToSeeHereYet),
            TextButton(
              onPressed: () =>
                  context.read<HomeCubit>().setTab(HomeTab.products),
              child: Text(S.of(context).productsPageLink),
            ),
          ],
        ),
      ),
    );
  }
}
