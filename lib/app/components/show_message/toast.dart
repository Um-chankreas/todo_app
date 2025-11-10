import 'package:flutter/material.dart';
import 'package:todo_app/app/enum/status_msg.dart';

class CustomToast {
  static void show(
    BuildContext context,
    String message, {
    ResponseMsg type = ResponseMsg.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    final color = _getColor(type);
    final icon = _getIcon(type);

    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (_) => Positioned(
        bottom: 32,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 300),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: color, size: 12),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      message,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(color: color),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }

  static Color _getColor(ResponseMsg type) {
    switch (type) {
      case ResponseMsg.success:
        return Colors.green;
      case ResponseMsg.warning:
        return Colors.orange;
      case ResponseMsg.failed:
        return Colors.red;
    }
  }

  static IconData _getIcon(ResponseMsg type) {
    switch (type) {
      case ResponseMsg.success:
        return Icons.check_circle;
      case ResponseMsg.warning:
        return Icons.warning;
      case ResponseMsg.failed:
        return Icons.error;
    }
  }
}
