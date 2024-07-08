// TODO: Implement some sort of validation for fields so necessary fields are filled out
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/src/presentation/pages/edit_product/edit_product.dart';

class NameField extends StatelessWidget {
  const NameField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EditProductBloc, EditProductState, String>(
      selector: (state) => state.name,
      builder: (context, name) {
        return TextFormField(
          key: const Key('editProductForm_nameInput_textField'),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            enabled: !context.select<EditProductBloc, bool>(
                (bloc) => bloc.state.status.isLoadingOrSuccess),
            labelText: "Name", //S.of(context).editProductFormNameFieldLabel,
          ),
          initialValue: name,
          maxLength: 50,
          inputFormatters: [LengthLimitingTextInputFormatter(50)],
          onSaved: (name) {
            assert(name != null, "Namefield cannot return null!");
            context.read<EditProductBloc>().add(EditProductNameChanged(name!));
          },
          validator: (String? value) =>
              (value == null || value.isEmpty) ? "Please enter a name" : null,
        );
      },
    );
  }
}
