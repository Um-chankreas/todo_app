import 'package:flutter/material.dart';
import 'package:todo_app/app/enum/button_type.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final ButtonSize size;
  final Color? color;
  final double borderRadius;
  final bool isLoading;
  final IconData? icon;
  final TextStyle? textStyle;
  final bool isExpanded;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.filled,
    this.size = ButtonSize.md,
    this.color,
    this.borderRadius = 8.0,
    this.isLoading = false,
    this.icon,
    this.textStyle,
    this.isExpanded = false,
  });

  EdgeInsets get _padding {
    switch (size) {
      case ButtonSize.sm:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case ButtonSize.lg:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
      case ButtonSize.md:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    }
  }

  double get _fontSize {
    switch (size) {
      case ButtonSize.sm:
        return 14;
      case ButtonSize.lg:
        return 18;
      case ButtonSize.md:
        return 16;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = color ?? Theme.of(context).colorScheme.primary;
    final isFilled = type == ButtonType.filled;
    final hasIcon = icon != null;

    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return isFilled
                ? themeColor.withValues(alpha: 0.5)
                : Colors.transparent;
          }
          return isFilled ? themeColor : Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.all(
          isFilled ? Colors.white : themeColor,
        ),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        padding: WidgetStateProperty.all(_padding),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: isFilled ? BorderSide.none : BorderSide(color: themeColor),
          ),
        ),
      ),
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isFilled ? Colors.white : themeColor,
                ),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (hasIcon) ...[
                  Icon(icon, size: _fontSize + 2),
                  const SizedBox(width: 6),
                ],
                Text(
                  text,
                  style:
                      textStyle ??
                      TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: _fontSize,
                        color: isFilled ? Colors.white : themeColor,
                      ),
                ),
              ],
            ),
    );

    // 👇 Wrap in SizedBox if full-width is requested
    return isExpanded
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}
