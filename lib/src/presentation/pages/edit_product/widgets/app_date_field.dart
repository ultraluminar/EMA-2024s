import 'package:flutter/material.dart';
import 'package:fridge_manager/src/shared/app_utils/app_utils.dart';
import 'package:intl/intl.dart';

class AppDateField extends StatelessWidget {
  const AppDateField({
    required this.labelText,
    required this.dateFormat,
    required this.onDatePicked,
    required this.controller,
    this.enabled = true,
    this.validator,
    super.key,
  });

  final String labelText;
  final DateFormat dateFormat;
  final ValueChanged<DateTime> onDatePicked;
  final TextEditingController controller;
  final bool enabled;
  final String? Function(String?)? validator;

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: controller.text == ""
          ? DateTime.now().date
          : dateFormat.parse(controller.text),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then(
      (DateTime? picked) {
        if (picked != null &&
            (controller.text == "" ||
                picked != dateFormat.parse(controller.text))) {
          onDatePicked(picked);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.edit_calendar_rounded),
          onPressed: () => selectDate(context),
        ),
        enabled: enabled,
        labelText: labelText,
      ),
      onTap: () => selectDate(context),
      controller: controller,
      readOnly: true,
      validator: validator,
    );
  }
}
