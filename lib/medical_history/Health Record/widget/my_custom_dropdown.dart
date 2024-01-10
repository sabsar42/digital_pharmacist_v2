
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCustomDropdown extends StatelessWidget {
  final List<String> items;
  final String? initialValue;
  final Function(String?) onChanged;

  MyCustomDropdown({
    required this.items,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      value: items.contains(initialValue) ? initialValue : null,
      onChanged: onChanged,
    );
  }
}
