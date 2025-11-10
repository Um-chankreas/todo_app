import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final VoidCallback? onTap;
  final bool readOnly;
  final Widget? suffixIcon;

  final List<TextInputFormatter>? inputFormaters;

  const AppTextFormField({
    super.key,
    required this.controller,
    this.label = "",
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onTap,
    this.readOnly = false,
    this.suffixIcon,
    this.inputFormaters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      inputFormatters: inputFormaters,
      style: Theme.of(context).textTheme.bodyMedium,
      onTap: onTap,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
