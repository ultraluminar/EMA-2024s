import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/home/cubit/home_cubit.dart';
import 'package:fridge_manager/l10n/l10n.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(S.of(context).nothingToSeeHereYet),
          TextButton(
            onPressed: () => context.read<HomeCubit>().setTab(HomeTab.home),
            child: const Text("Go to Overview"),
          ),
        ],
      ),
    );
  }
}
