import 'package:flutter/material.dart';

class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final Color glassBackground;
  final Color borderColor;
  final Color cardShadow;

  AppThemeColors({
    required this.glassBackground,
    required this.borderColor,
    required this.cardShadow,
  });

  @override
  AppThemeColors copyWith({
    Color? glassBackground,
    Color? borderColor,
    Color? cardShadow,
  }) {
    return AppThemeColors(
      glassBackground: glassBackground ?? this.glassBackground,
      borderColor: borderColor ?? this.borderColor,
      cardShadow: cardShadow ?? this.cardShadow,
    );
  }

  @override
  ThemeExtension<AppThemeColors> lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) return this;
    return AppThemeColors(
      glassBackground: Color.lerp(glassBackground, other.glassBackground, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      cardShadow: Color.lerp(cardShadow, other.cardShadow, t)!,
    );
  }
}
