import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/src/data/products_api/products_api.dart';
import 'package:fridge_manager/src/presentation/custom_widgets/custom_widgets.dart';
import 'package:fridge_manager/src/presentation/pages/edit_product/edit_product.dart';
import 'package:intl/intl.dart';

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
        text: context.select<EditProductBloc, String?>(
                (bloc) => bloc.state.expiresAt?.toString()) ??
            "",
      ),
      onDatePicked: (picked) {
        context
            .read<EditProductBloc>()
            .add(EditProductExpiresAtChanged(ExpirationDate.fromDate(picked)));
      },
      validator: (String? value) {
        return (value == null || value.isEmpty)
            ? "Please enter an expiration date"
            : null;
      },
    );
  }
}
