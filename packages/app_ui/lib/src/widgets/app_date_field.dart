import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDateField extends StatelessWidget {
  AppDateField({
    required this.onDatePicked,
    required this.dateFormat,
    required this.labelText,
    required this.initialDate,
    this.enabled = true,
    super.key,
  });

  final ValueChanged<DateTime> onDatePicked;
  final DateFormat dateFormat;
  final String labelText;
  final DateTime initialDate;
  final bool enabled;

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then(
      (DateTime? picked) {
        if (picked != null && picked != initialDate) onDatePicked(picked);
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
      controller: TextEditingController(
        text: dateFormat.format(initialDate),
      ),
      readOnly: true,
    );
  }
}
