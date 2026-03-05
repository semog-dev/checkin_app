import 'package:flutter/material.dart';

abstract final class AppColors {
  // Primary — Indigo
  static const primary = Color(0xFF3F51B5);
  static const primaryLight = Color(0xFF7986CB);
  static const primaryDark = Color(0xFF303F9F);

  // Secondary — Cyan
  static const secondary = Color(0xFF00BCD4);
  static const secondaryLight = Color(0xFF4DD0E1);
  static const secondaryDark = Color(0xFF0097A7);

  // Semantic
  static const error = Color(0xFFE53935);
  static const success = Color(0xFF43A047);
  static const warning = Color(0xFFFB8C00);

  // Neutral
  static const surface = Color(0xFFFFFFFF);
  static const surfaceDark = Color(0xFF121212);
  static const onSurface = Color(0xFF1C1B1F);
  static const onSurfaceDark = Color(0xFFE6E1E5);
}
