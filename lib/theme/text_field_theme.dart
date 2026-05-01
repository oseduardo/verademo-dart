import 'package:flutter/material.dart';
import 'package:verademo_dart/main.dart';
import 'package:verademo_dart/utils/constants.dart';
import 'package:verademo_dart/theme/text_theme.dart';

class VTextFormFieldTheme {
  VTextFormFieldTheme._();

  static InputDecorationTheme defaultTextFormTheme = InputDecorationTheme(
    filled: true,
    fillColor: VConstants.darkNeutral2,
    contentPadding: VConstants.textFieldPadding,
    labelStyle: VTextTheme.defaultTextTheme.bodyMedium!.copyWith(color: veracodeWhite),
    floatingLabelStyle: VTextTheme.defaultTextTheme.bodyMedium!.copyWith(color: veracodeWhite),
    hintStyle: WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return VTextTheme.defaultTextTheme.bodyMedium!.copyWith(color: VConstants.darkNeutral3);
      } else {
        return VTextTheme.defaultTextTheme.bodyMedium!.copyWith(color: VConstants.veracodeWhite);
      }
    }),
    errorStyle: VTextTheme.defaultTextTheme.labelSmall!.copyWith(color: Colors.red),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1, color: VConstants.darkNeutral2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 2, color: VConstants.darkNeutral3),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1, color: VConstants.darkNeutral1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 2, color: Colors.red),
    ),
  );

  static InputDecorationTheme loginTextFormTheme = InputDecorationTheme(
    filled: true,
    fillColor: VConstants.darkNeutral1,
    contentPadding: VConstants.textFieldPadding,
    hintStyle: WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return VTextTheme.defaultTextTheme.bodyMedium!.copyWith(color: VConstants.darkNeutral3);
      } else {
        return VTextTheme.defaultTextTheme.bodyMedium!.copyWith(color: VConstants.veracodeWhite);
      }
    }),
    errorStyle: VTextTheme.defaultTextTheme.labelSmall!.copyWith(color: Colors.red),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1, color: VConstants.darkNeutral2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 2, color: VConstants.darkNeutral3),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1, color: VConstants.darkNeutral1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 2, color: Colors.red),
    ),
  );
}