import 'package:app_ui/app_ui.dart';
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
          context.read<EditProductBloc>().state.isNewProduct
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
            onPressed: isLoadingOrSuccess
                ? null
                : () => context
                    .read<EditProductBloc>()
                    .add(const EditProductSubmitted()),
            child: isLoadingOrSuccess
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
              ExpirationDateField(),
              StorageDateField(),
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
    return BlocSelector<EditProductBloc, EditProductState, String>(
      selector: (state) => state.product.name,
      builder: (context, name) {
        return TextFormField(
          key: const Key('editProductForm_nameInput_textField'),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            enabled: !context.select<EditProductBloc, bool>(
                (bloc) => bloc.state.status.isLoadingOrSuccess),
            labelText: "Name", //S.of(context).editProductFormNameFieldLabel,
          ),
          initialValue: context.read<EditProductBloc>().state.product.name,
          maxLength: 50,
          inputFormatters: [
            LengthLimitingTextInputFormatter(50),
            // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
          ],
          // onChanged: (name) => context
          //     .read<EditProductBloc>()
          //     .add(EditProductNameChanged(name)),
          onFieldSubmitted: (name) =>
              context.read<EditProductBloc>().add(EditProductNameChanged(name)),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "Please enter a name";
            }
            return null;
          },
        );
      },
    );
  }
}

class ExpirationDateField extends StatelessWidget {
  const ExpirationDateField({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDateField(
      initialDate: context.select<EditProductBloc, DateTime>(
          (bloc) => bloc.state.product.expires_at),
      dateFormat: DateFormat("dd.MM.yyyy"),
      labelText: "ExpiresAt",
      enabled: !context.select<EditProductBloc, bool>(
          (bloc) => bloc.state.status.isLoadingOrSuccess),
      onDatePicked: (picked) => context
          .read<EditProductBloc>()
          .add(EditProductExpiresAtChanged(picked)),
      key: key,
    );
  }
}

class StorageDateField extends StatelessWidget {
  const StorageDateField({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDateField(
      initialDate: context.select<EditProductBloc, DateTime>(
          (bloc) => bloc.state.product.stored_at),
      dateFormat: DateFormat("dd.MM.yyyy"),
      labelText: "storedAt",
      enabled: !context.select<EditProductBloc, bool>(
          (bloc) => bloc.state.status.isLoadingOrSuccess),
      onDatePicked: (picked) => context
          .read<EditProductBloc>()
          .add(EditProductStoredAtChanged(picked)),
      key: key,
    );
  }
}
