import 'package:flutter/material.dart';
import 'package:verademo_dart/utils/validation.dart';

class VUserField extends StatefulWidget {
  const VUserField(
    this.fieldName,
    { super.key,
      this.controller,  
    });

    final TextEditingController? controller;
    final String fieldName;

  @override
  State<VUserField> createState() => _VUserFieldState();
}

class _VUserFieldState extends State<VUserField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField (
      style: Theme.of(context).textTheme.bodyMedium,
      controller: widget.controller,
      validator: (value) => VValidator.validateTextField(widget.fieldName, value),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        labelText: widget.fieldName,
      ),
    );
  }
}