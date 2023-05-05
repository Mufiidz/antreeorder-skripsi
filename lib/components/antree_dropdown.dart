import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AntreeDropdown extends StatelessWidget {
  final String name;
  final List<String> items;
  final void Function(String)? onValueChange;
  final String? initialValue;
  const AntreeDropdown(this.name,
      {Key? key, required this.items, this.onValueChange, this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<String>(
      name: name,
      initialValue:
          initialValue ?? (items.isNotEmpty ? items.first : 'No Category'),
      items:
          items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (value) => onValueChange!(value ?? items.first),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
      ),
    );
  }
}
