import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/src/data/products_api/src/models/models.dart';
import 'package:fridge_manager/src/presentation/pages/edit_product/edit_product.dart';

class ExpirationDateField extends StatelessWidget {
  const ExpirationDateField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProductCubit, EditProductState>(
      buildWhen: (previous, current) =>
          previous.status.isLoadingOrSuccess !=
              current.status.isLoadingOrSuccess ||
          previous.productPrototype.expiresAt !=
              current.productPrototype.expiresAt,
      builder: (context, state) {
        return AppDateField(
          key: const Key('editProductForm_expiresAtInput_dateField'),
          labelText: S.of(context).editProductExpirationDateInputLabel,
          dateFormat: ExpirationDate.dateFormat,
          enabled: !state.status.isLoadingOrSuccess,
          controller: TextEditingController(
            text: state.productPrototype.expiresAt?.toString() ?? "",
          ),
          onDatePicked: (date) =>
              context.read<EditProductCubit>().setExpiresAt(date),
          validator: (String? value) => (value == null || value.isEmpty)
              ? S.of(context).editProductExpirationDateInputError
              : null,
        );
      },
    );
  }
}
