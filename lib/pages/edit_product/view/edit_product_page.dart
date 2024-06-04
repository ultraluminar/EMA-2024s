import 'dart:developer';

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

class EditProductView extends StatefulWidget {
  const EditProductView({super.key});

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
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
                  : () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        context
                            .read<EditProductBloc>()
                            .add(const EditProductSubmitted());
                      }
                    },
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
            SizedBox(height: 14),
            StorageDateField(),
            SizedBox(height: 28),
            OwnerField(),
            // _KategoryField(),
          ],
        ),
      ),
    );
  }
}

// TODO: Implement some sort of validation for fields so necessary fields are filled out
class NameField extends StatelessWidget {
  const NameField({super.key});

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
          ],
          onSaved: (name) {
            assert(name != null, "Namefield cannot return null!");
            context.read<EditProductBloc>().add(EditProductNameChanged(name!));
          },
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
    DateFormat dateFormat = DateFormat("dd.MM.yyyy");

    return AppDateField(
      key: const Key('editProductForm_expiresAtInput_dateField'),
      labelText: "ExpiresAt",
      dateFormat: dateFormat,
      enabled: !context.select<EditProductBloc, bool>(
          (bloc) => bloc.state.status.isLoadingOrSuccess),
      controller: TextEditingController(
        text: context.select<EditProductBloc, String>(
            (bloc) => bloc.state.dateOrEmpty(dateFormat)),
      ),
      onDatePicked: (picked) {
        log("Picked date: $picked");
        context
            .read<EditProductBloc>()
            .add(EditProductExpiresAtChanged(picked));
      },
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Please enter an expiration date";
        }
        return null;
      },
    );
  }
}

class StorageDateField extends StatelessWidget {
  const StorageDateField({super.key});

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("dd.MM.yyyy");

    return AppDateField(
      key: const Key('editProductForm_storedAtInput_dateField'),
      labelText: "storedAt",
      dateFormat: dateFormat,
      enabled: !context.select<EditProductBloc, bool>(
          (bloc) => bloc.state.status.isLoadingOrSuccess),
      controller: TextEditingController(
        text: dateFormat.format(
          context.read<EditProductBloc>().state.product.stored_at,
        ),
      ),
      onDatePicked: (picked) => context
          .read<EditProductBloc>()
          .add(EditProductStoredAtChanged(picked)),
    );
  }
}

class OwnerField extends StatelessWidget {
  const OwnerField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EditProductBloc, EditProductState, String>(
      selector: (state) => state.product.owner,
      builder: (context, owner) {
        return TextFormField(
          key: const Key('editProductForm_ownerInput_textField'),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            enabled: !context.select<EditProductBloc, bool>(
                (bloc) => bloc.state.status.isLoadingOrSuccess),
            labelText: "Owner", //S.of(context).editProductFormOwnerFieldLabel,
          ),
          initialValue: context.read<EditProductBloc>().state.product.owner,
          maxLength: 50,
          inputFormatters: [
            LengthLimitingTextInputFormatter(50),
          ],
          onSaved: (owner) {
            assert(owner != null, "Ownerfield cannot return null!");
            context
                .read<EditProductBloc>()
                .add(EditProductOwnerChanged(owner!));
          },
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "Please enter an owner";
            }
            return null;
          },
        );
      },
    );
  }
}
