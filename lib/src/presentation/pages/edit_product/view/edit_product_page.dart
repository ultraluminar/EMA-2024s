import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/src/data/products_api/products_api.dart';
import 'package:fridge_manager/src/domain/products_repository/products_repository.dart';
import 'package:fridge_manager/src/presentation/pages/edit_product/edit_product.dart';
import 'package:fridge_manager/src/presentation/pages/edit_product/view/expiration_date_field.dart';
import 'package:fridge_manager/src/presentation/pages/edit_product/view/name_field.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({super.key});

  static Route<void> route({
    Product? product,
    String? name,
    String? barcode,
  }) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => (product != null)
            ? EditProductBloc.fromProduct(
                productsRepository: context.read<ProductsRepository>(),
                product: product)
            : (name != null)
                ? EditProductBloc.fromScan(
                    productsRepository: context.read<ProductsRepository>(),
                    name: name,
                    barcode: barcode!,
                  )
                : EditProductBloc(
                    productsRepository: context.read<ProductsRepository>(),
                    state: const EditProductState(),
                  ),
        child: const EditProductPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProductBloc, EditProductState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditProductStatus.success,
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
    void saveIfValide() {
      final state = _formKey.currentState!;
      if (!state.validate()) {
        //FIXME: never valide
        log("not valide!");
        return;
      }

      state.save();
      context.read<EditProductBloc>().add(const EditProductSubmitted());
    }

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.read<EditProductBloc>().product == null
                ? S.of(context).editProductAddAppBarTitle
                : S.of(context).editProductEditAppBarTitle,
          ),
        ),
        floatingActionButton:
            BlocSelector<EditProductBloc, EditProductState, bool>(
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
            // SizedBox(height: 14),
            // StorageDateField(),
            // SizedBox(height: 28),
            // OwnerField(),
            // _KategoryField(),
          ],
        ),
      ),
    );
  }
}
