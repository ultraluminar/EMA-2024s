import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/src/presentation/pages/edit_product/edit_product.dart';

class NameField extends StatelessWidget {
  const NameField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProductCubit, EditProductState>(
      buildWhen: (previous, current) =>
          previous.status.isLoadingOrSuccess !=
              current.status.isLoadingOrSuccess ||
          previous.productPrototype.name != current.productPrototype.name,
      builder: (context, state) {
        return TextFormField(
          key: const Key('editProductForm_nameInput_textField'),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            enabled: !state.status.isLoadingOrSuccess,
            labelText: S.of(context).editProductNameInputLabel,
          ),
          initialValue: state.productPrototype.name,
          onSaved: (name) {
            assert(name != null, "Namefield cannot return null!");
            context.read<EditProductCubit>().setName(name!);
          },
          validator: (String? value) => (value == null || value.isEmpty)
              ? S.of(context).editProductNameInputError
              : null,
        );
      },
    );
  }
}
