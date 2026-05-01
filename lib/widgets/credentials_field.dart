import 'package:flutter/material.dart';
import 'package:verademo_dart/utils/validation.dart';

class VCredField extends StatefulWidget {
  const VCredField(
    this.fieldName,
    { super.key,
      this.controller, 
      this.hide = false,
      this.edit = true, 
    });

    final TextEditingController? controller;
    final bool edit;
    final bool hide;
    final String fieldName;

  @override
  State<VCredField> createState() => _VCredFieldState();
}

class _VCredFieldState extends State<VCredField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField (
      enabled: widget.edit,
      controller: widget.controller,
      obscureText: widget.hide,
      validator: (value) => VValidator.validateTextField(widget.fieldName, value),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: widget.fieldName,
      ),
    );
  }
}