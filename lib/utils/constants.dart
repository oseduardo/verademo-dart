import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VConstants {
  VConstants._();
  
  static String apiUrl = "http://10.0.2.2:8000";

  static const Color veracodeBlue = Color(0xFF00B3E6);
  static const Color codeBlack = Color(0xFF000000);
  static const Color veracodeBlack = Color(0xFF242626);
  static const Color darkNeutral1 = Color(0xFF454443);
  static const Color darkNeutral2 = Color(0xFF5C5A59);
  static const Color darkNeutral3 = Color(0xFF8C8986);
  static const Color lightNeutral3 = Color(0xFFBBB6B3);
  static const Color lightNeutral2 = Color(0xFFD5D3D1);
  static const Color lightNeutral1 = Color(0xFFE8E8E8);
  static const Color veracodeWhite = Color(0xFFF4F4F4);
  static const Color codeWhite = Color(0xFFFFFFFF);

  static const String vcIcon = "assets/VCicon.png";
  static const String vcLogo = "assets/VClogo.png";
  static const String defaultProfile = "assets/images/default_profile.png";

  static const double textFieldSpacing = 17.0;
  static const double textFieldSpacingMed = 24.0;
  static const double loginMargin = 33.0;

  static DateFormat dateFormat = DateFormat("MMM d, y");

  static const EdgeInsetsGeometry loginSpacing = EdgeInsets.only(
    top: 0,
    left: loginMargin,
    bottom: 0,
    right: loginMargin,
  );

  static const EdgeInsetsGeometry textFieldPadding = EdgeInsets.symmetric(
    vertical: 12,
    horizontal: 16,
  );

  static const EdgeInsetsGeometry pagePadding = EdgeInsets.only(
    top: 20,
    left: 20,
    bottom: 0,
    right: 20,
  );
}