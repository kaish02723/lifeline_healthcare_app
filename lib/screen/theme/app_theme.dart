import 'package:flutter/material.dart';
import 'package:lifeline_healthcare/screen/theme/color.dart';
import 'package:lifeline_healthcare/screen/theme/text_styles.dart';

class AppTheme{
  // LIGHT MODE

  static ThemeData lightTheme=ThemeData(
    brightness:Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    cardColor: AppColors.card,
    fontFamily: "Inter",

    textTheme: const TextTheme(
      headlineLarge: AppTextStyle.h1,
      headlineMedium: AppTextStyle.h2,
      headlineSmall: AppTextStyle.h3,

      titleLarge: AppTextStyle.titleLarge,
      titleMedium: AppTextStyle.titleMedium,
      titleSmall: AppTextStyle.h4,

      bodyLarge: AppTextStyle.bodyLarge,
      bodyMedium: AppTextStyle.bodyMedium,
      bodySmall: AppTextStyle.bodySmall,
    ),
    iconTheme: const IconThemeData(color: AppColors.icon),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      titleTextStyle: AppTextStyle.h2,
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );

  // DARK THEME
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.backgroundDark,
    primaryColor: AppColors.primary,
    cardColor: AppColors.cardDark,

    fontFamily: "Inter",

    textTheme: const TextTheme(
      headlineLarge: AppTextStyle.h1,
      headlineMedium: AppTextStyle.h2,
      headlineSmall: AppTextStyle.h3,

      titleLarge: AppTextStyle.titleLarge,
      titleMedium: AppTextStyle.titleMedium,
      titleSmall: AppTextStyle.h4,

      bodyLarge: AppTextStyle.bodyLarge,
      bodyMedium: AppTextStyle.bodyMedium,
      bodySmall: AppTextStyle.bodySmall,
    ),

    iconTheme: const IconThemeData(color: AppColors.iconDark),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      titleTextStyle: AppTextStyle.h2,
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );

}