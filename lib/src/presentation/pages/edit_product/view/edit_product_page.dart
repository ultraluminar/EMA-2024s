import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/src/data/products_api/products_api.dart';
import 'package:fridge_manager/src/presentation/pages/edit_product/edit_product.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({super.key});

  static Route<void> route({
    required ProductPrototype productPrototype,
  }) =>
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => BlocProvider(
          create: (context) => EditProductCubit(
            productPrototype: productPrototype,
          ),
          child: const EditProductPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProductCubit, EditProductState>(
      listenWhen: (previous, current) => current.status == Status.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditProductView(),
    );
  }
}

class EditProductView extends StatefulWidget {
  const EditProductView({super.key});

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future<void> saveIfValide() async {
      final state = _formKey.currentState!;
      if (!state.validate()) return;

      state.save();
      await context.read<EditProductCubit>().submit();
    }

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.read<EditProductCubit>().isNewProduct
                ? S.of(context).editProductAddAppBarTitle
                : S.of(context).editProductEditAppBarTitle,
          ),
        ),
        floatingActionButton:
            BlocSelector<EditProductCubit, EditProductState, bool>(
          selector: (state) => state.status.isLoadingOrSuccess,
          builder: (context, isLoadingOrSuccess) {
            return FloatingActionButton(
              tooltip: S.of(context).editProductSaveButtonTooltip,
              onPressed: isLoadingOrSuccess ? null : saveIfValide,
              child: isLoadingOrSuccess
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.check_rounded),
            );
          },
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            NameField(),
            SizedBox(height: 14),
            ExpirationDateField(),
          ],
        ),
      ),
    );
  }
}
