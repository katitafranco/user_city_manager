import 'package:flutter/material.dart';

class CountryDropdown extends StatelessWidget {
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;
  final String? errorText;

  const CountryDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(labelText: 'País', errorText: errorText),
      items: items,
      onChanged: onChanged,
    );
  }
}
