import 'package:flutter/material.dart';
import 'package:task/theme/colors.dart';

class Fonts {
  static TextStyle lableMedium() {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.onBlueColor,
    );
  }

  static TextStyle bodyMedium() {
    return TextStyle(
      fontSize: 20,
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
