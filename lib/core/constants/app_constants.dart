import 'package:flutter/material.dart';

/// Berisi konstanta-konstanta yang digunakan di aplikasi
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Dashboard Mahasiswa D4TI';
  static const String appVersion = '1.0.0';

  // Keys
  static const String userPrefsKey = 'user_prefs';

  // Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;

  // Dashboard Gradient Colors
  static const List<List<Color>> dashboardGradients = [
    [Color(0xFFF667EE), Color(0xFF764BA2)], // Purple
    [Color(0xFFF093FB), Color(0xFFF5576C)], // Pink
    [Color(0xFF4FACFE), Color(0xFF00F2FE)], // Blue
    [Color(0xFF43E97B), Color(0xFF38F9D7)], // Green
  ];

  // Individual Gradient Colors (optional - for direct access)
  static const List<Color> gradientPurple = [
    Color(0xFFF667EE),
    Color(0xFF764BA2),
  ];
  static const List<Color> gradientPink = [
    Color(0xFFF093FB),
    Color(0xFFF5576C),
  ];
  static const List<Color> gradientBlue = [
    Color(0xFF4FACFE),
    Color(0xFF00F2FE),
  ];
  static const List<Color> gradientGreen = [
    Color(0xFF43E97B),
    Color(0xFF38F9D7),
  ];
}
