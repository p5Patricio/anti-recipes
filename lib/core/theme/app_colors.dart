import 'package:flutter/material.dart';

/// Color tokens derived from the mascot logo palette.
abstract final class AppColors {
  static const Color graphite = Color(0xFF1F2933);
  static const Color sage = Color(0xFF7E9F82);
  static const Color terracotta = Color(0xFFD9734E);
  static const Color offWhite = Color(0xFFF4F0E8);
  static const Color kraft = Color(0xFFC9A27A);
  static const Color surface = Color(0xFFFFFFFF);

  // Semantic colors.
  static const Color success = sage;
  static const Color warning = terracotta;
  static const Color error = Color(0xFFB3412F);
}
