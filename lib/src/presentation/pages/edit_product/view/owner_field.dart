import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/src/presentation/pages/edit_product/edit_product.dart';

class OwnerField extends StatelessWidget {
  const OwnerField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EditProductBloc, EditProductState, String>(
      selector: (state) => "owner", //state.product.owner,
      builder: (context, owner) {
        return TextFormField(
          key: const Key('editProductForm_ownerInput_textField'),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            enabled: !context.select<EditProductBloc, bool>(
                (bloc) => bloc.state.status.isLoadingOrSuccess),
            labelText: "Owner", //S.of(context).editProductFormOwnerFieldLabel,
          ),
          initialValue:
              "owner", //context.read<EditProductBloc>().state.product.owner,
          maxLength: 50,
          inputFormatters: [
            LengthLimitingTextInputFormatter(50),
          ],
          onSaved: (owner) {
            assert(owner != null, "Ownerfield cannot return null!");
            log("ownerField saved: $owner");
            // context
            //     .read<EditProductBloc>()
            //     .add(EditProductOwnerChanged(owner!));
          },
          validator: (String? value) {
            // TODO: reanable validation
            // if (value == null || value.isEmpty) {
            //   return "Please enter an owner";
            // }
            return null;
          },
        );
      },
    );
  }
}
