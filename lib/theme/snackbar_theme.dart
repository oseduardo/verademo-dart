import 'package:flutter/material.dart';
import 'package:verademo_dart/theme/text_theme.dart';
import 'package:verademo_dart/utils/constants.dart';

class VSnackbarTheme {
  VSnackbarTheme._();

  static final defaultSnackBarTheme = SnackBarThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    contentTextStyle: VTextTheme.defaultTextTheme.bodyMedium!.copyWith(color: VConstants.veracodeWhite),
  );

  static final loginSnackBarTheme = SnackBarThemeData(
    backgroundColor: Colors.red,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    contentTextStyle: VTextTheme.defaultTextTheme.bodyMedium!.copyWith(color: VConstants.veracodeWhite),
  );
}