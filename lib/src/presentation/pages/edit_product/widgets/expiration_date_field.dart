import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/src/presentation/pages/edit_product/edit_product.dart';
import 'package:intl/intl.dart';

class ExpirationDateField extends StatelessWidget {
  const ExpirationDateField({super.key});

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("dd.MM.yyyy");

    return BlocBuilder<EditProductCubit, EditProductState>(
      buildWhen: (previous, current) =>
          previous.status.isLoadingOrSuccess !=
              current.status.isLoadingOrSuccess ||
          previous.productPrototype.expiresAt !=
              current.productPrototype.expiresAt,
      builder: (context, state) {
        return AppDateField(
          key: const Key('editProductForm_expiresAtInput_dateField'),
          labelText: "ExpiresAt",
          dateFormat: dateFormat,
          enabled: !state.status.isLoadingOrSuccess,
          controller: TextEditingController(
            text: state.productPrototype.expiresAt?.toString() ?? "",
          ),
          onDatePicked: (date) =>
              context.read<EditProductCubit>().setExpiresAt(date),
          validator: (String? value) => (value == null || value.isEmpty)
              ? "Please enter an expiration date"
              : null,
        );
      },
    );
  }
}
