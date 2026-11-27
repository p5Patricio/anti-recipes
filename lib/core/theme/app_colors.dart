import 'package:flutter/material.dart';

/// Color tokens derived from the ink-brush duck-chef logo palette.
///
/// Dark-first: near-black surfaces, cream text, ink red as the primary accent
/// and cherry-blossom pink as the secondary highlight.
abstract final class AppColors {
  // Surfaces.
  static const Color ink = Color(0xFF0B0B0C);
  static const Color surface = Color(0xFF161517);
  static const Color surfaceRaised = Color(0xFF211F21);
  static const Color outline = Color(0xFF3A3638);

  // Text.
  static const Color cream = Color(0xFFF2E6CF);
  static const Color creamMuted = Color(0xFFB9AE9A);

  // Brand accents.
  static const Color inkRed = Color(0xFFBF2D28);
  static const Color inkRedLight = Color(0xFFE8645B);
  static const Color blossom = Color(0xFFF2A0B0);
  static const Color kraft = Color(0xFFC9A27A);

  // Status colors: within target, below target, above target.
  static const Color statusWithin = blossom;
  static const Color statusBelow = kraft;
  static const Color statusAbove = inkRedLight;

  // Semantic colors.
  static const Color success = statusWithin;
  static const Color warning = statusAbove;
  static const Color error = Color(0xFFFF7F73);
}
