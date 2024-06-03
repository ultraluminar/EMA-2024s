import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/pages/edit_product/edit_product.dart';
import 'package:intl/intl.dart';
import 'package:products_api/products_api.dart';
import 'package:products_repository/products_repository.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({super.key});

  static Route<void> route({Product? initialProduct}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditProductBloc(
          productsRepository: context.read<ProductsRepository>(),
          initialProduct: initialProduct,
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

class EditProductView extends StatelessWidget {
  const EditProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // TODO: extract bool check to arb?
          context.watch<EditProductBloc>().state.isNewProduct
              ? S.of(context).editProductAddAppBarTitle
              : S.of(context).editProductEditAppBarTitle,
        ),
      ),
      floatingActionButton:
          BlocSelector<EditProductBloc, EditProductState, EditProductStatus>(
        selector: (state) => state.status,
        builder: (context, state) {
          return FloatingActionButton(
            tooltip: S.of(context).editProductSaveButtonTooltip,
            onPressed: state.isLoadingOrSuccess
                ? null
                : () => context
                    .read<EditProductBloc>()
                    .add(const EditProductSubmitted()),
            child: state.isLoadingOrSuccess
                ? const CircularProgressIndicator()
                : const Icon(Icons.check_rounded),
          );
        },
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _NameField(),
              _ExpirationDateField(),
              // _StorageDateField(),
              // _OwnerField(),
              // _KategoryField(),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO: Implement some sort of validation for fields so necessary fields are filled out
class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EditProductBloc, EditProductState, bool>(
      selector: (state) => state.status.isLoadingOrSuccess,
      builder: (context, isLoadingOrSuccess) {
        return BlocSelector<EditProductBloc, EditProductState, String>(
          selector: (state) => state.product.name,
          builder: (context, name) {
            TextEditingController controller = TextEditingController(text: name);

            return TextField(
              key: const Key('editProductForm_nameInput_textField'),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                enabled: !isLoadingOrSuccess,
                labelText:
                    "Name", //S.of(context).editProductFormNameFieldLabel,
              ),
              maxLength: 50,
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
                // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
              ],
              // onChanged: (name) => context
              //     .read<EditProductBloc>()
              //     .add(EditProductNameChanged(name)),
              onEditingComplete: () => context
                  .read<EditProductBloc>()
                  .add(EditProductNameChanged(controller.text)),
              controller: controller,
            );
          },
        );
      },
    );
  }
}

class _ExpirationDateField extends StatelessWidget {
  const _ExpirationDateField();

  Future<void> _selectDate(BuildContext context) async {
    final expiresAt = context.read<EditProductBloc>().state.product.expires_at;

    showDatePicker(
      context: context,
      initialDate: expiresAt,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then(
      (DateTime? picked) {
        if (picked != null && picked != expiresAt) {
          context
              .read<EditProductBloc>()
              .add(EditProductExpiresAtChanged(picked));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EditProductBloc, EditProductState, bool>(
      selector: (state) => state.status.isLoadingOrSuccess,
      builder: (context, isLoadingOrSuccess) {
        return BlocSelector<EditProductBloc, EditProductState, DateTime>(
          selector: (state) => state.product.expires_at,
          builder: (context, expiresAt) {
            return TextField(
              key: const Key('editProductForm_expirationDateInput_dateField'),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                enabled: !isLoadingOrSuccess,
                labelText:
                    "ExpiresAt", //S.of(context).editProductFormExpirationDateFieldLabel,
              ),
              onTap: () => _selectDate(context),
              controller: TextEditingController(
                text: DateFormat("dd.MM.yyyy").format(expiresAt),
              ),
              readOnly: true,
            );
          },
        );
      },
    );
  }
}
