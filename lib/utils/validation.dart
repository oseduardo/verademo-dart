class VValidator {
  static String? validateTextField(String fieldName, String? value) {
    print("Value is: $value");
    if (value == null || value.isEmpty) {
      return "$fieldName is required.";
    }

    return null;
  }
}