import 'package:flutter/material.dart';

class VCheckbox extends StatefulWidget {
  const VCheckbox({super.key, required this.value, required this.onChanged});

  final bool value;
  final void Function(bool) onChanged;

  @override
  State<VCheckbox> createState() => _VCheckboxState();
}

class _VCheckboxState extends State<VCheckbox> {
  late bool checked = widget.value;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: checked,
      onChanged: 
      ((bool? newValue) {
        setState(() {
          print("Previous Value: $checked");
          print("New value: $newValue");
          checked = newValue ?? true;
          print("Value changed to: $checked");
          widget.onChanged(checked);
        });
      })
    );
  }
}