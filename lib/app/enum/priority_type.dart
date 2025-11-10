import 'package:flutter/material.dart';

enum PriorityLevel { low, medium, high }

extension PriorityLevelExtension on PriorityLevel {
  String get label {
    switch (this) {
      case PriorityLevel.low:
        return 'Low';
      case PriorityLevel.medium:
        return 'Medium';
      case PriorityLevel.high:
        return 'High';
    }
  }

  int get sortValue {
    switch (this) {
      case PriorityLevel.high:
        return 3;
      case PriorityLevel.medium:
        return 2;
      case PriorityLevel.low:
        return 1;
    }
  }

  Color get color {
    switch (this) {
      case PriorityLevel.high:
        return Colors.red;
      case PriorityLevel.medium:
        return Colors.orange;
      case PriorityLevel.low:
        return Colors.green;
    }
  }
}
