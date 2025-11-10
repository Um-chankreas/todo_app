import 'package:flutter/services.dart';

class InputFormater {
  // Allow only digits (phone number)
  static List<TextInputFormatter> phoneNumberFormatter = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(10), // Adjust length if needed
  ];

  // Allow only decimal numbers (e.g., 123.45)
  static List<TextInputFormatter> decimalNumberFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
  ];

  // Allow only alphabetic characters (A-Z, a-z)
  static List<TextInputFormatter> textOnlyFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
  ];
}
