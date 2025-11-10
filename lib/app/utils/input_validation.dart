class InputValidation {
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    if (value.length != 10) return 'Phone number must be 10 digits';
    return null;
  }

  static String? validateDecimal(String? value) {
    if (value == null || value.isEmpty) return 'Amount is required';
    final regex = RegExp(r'^\d*\.?\d+$');
    if (!regex.hasMatch(value)) return 'Enter a valid number';
    return null;
  }

  static String? validateText(String? value) {
    if (value == null || value.trim().isEmpty) return 'This field is required';
    return null;
  }
}
