import 'package:flutter/material.dart';
import 'package:task/theme/colors.dart';

class Fonts {
  static TextStyle lableMedium() {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.onBlueColor,
    );
  }

  static TextStyle titleLarge() {
    return TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w900,
      color: AppColors.onBlueColor,
    );
  }

  static TextStyle lableLarge() {
    return TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: AppColors.onBlueColor,
    );
  }

  static TextStyle bodyLarge() {
    return TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    );
  }

  static TextStyle bodyMedium() {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    );
  }

  static TextStyle bodySmall() {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    );
  }

  static TextStyle numberCircle() {
    return TextStyle(
      color: AppColors.blueColor,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      shadows: const [
        Shadow(blurRadius: 3, color: Colors.black45, offset: Offset(0, 1)),
      ],
    );
  }
}
