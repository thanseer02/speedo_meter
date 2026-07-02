import 'package:flutter/material.dart';

extension StringExtensions on String {
  /// Capitalizes the first letter of the string.
  String capitalizeFirst() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension DoubleExtensions on double {
  /// Formats speed double to 1 decimal place.
  String toSpeedString() {
    return toStringAsFixed(1);
  }
  
  /// Formats distance double to 2 decimal places.
  String toDistanceString() {
    return toStringAsFixed(2);
  }
}

extension BuildContextExtensions on BuildContext {
  /// Easily get MediaQuery size.
  Size get screenSize => MediaQuery.sizeOf(this);
  
  /// Easily get Theme.
  ThemeData get theme => Theme.of(this);
}
