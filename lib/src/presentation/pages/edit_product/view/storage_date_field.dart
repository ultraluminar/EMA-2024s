import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/src/presentation/custom_widgets/custom_widgets.dart';
import 'package:fridge_manager/src/presentation/pages/edit_product/edit_product.dart';
import 'package:intl/intl.dart';

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
      controller: TextEditingController(text: ""
          // dateFormat.format(
          //   context.read<EditProductBloc>().state.product.stored_at,
          // ),
          ),
      onDatePicked: (picked) => log("storageDate picked: $picked"),
      // context
      //     .read<EditProductBloc>()
      //     .add(EditProductStoredAtChanged(picked)),
    );
  }
}
