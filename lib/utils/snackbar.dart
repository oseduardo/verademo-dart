import "package:flutter/material.dart";

class VSnackBar {
  static SnackBar errorSnackBar(content) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(content),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
    );
  }

  static SnackBar successSnackBar(content) {
    return SnackBar(
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      content: Text(content),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
    );
  }
}