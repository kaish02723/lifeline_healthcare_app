import 'dart:ui';
import 'package:flutter/material.dart';
import '../../config/app_theme_colors.dart';
import '../../config/color.dart';

class DashboardFooter extends StatelessWidget {
  const DashboardFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).extension<AppThemeColors>()!;
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    // Decide text colors based on theme
    final primaryText =
        theme.brightness == Brightness.dark
            ? AppColors.greyTextDark
            : AppColors.greyText;
    final secondaryText =
        theme.brightness == Brightness.dark
            ? AppColors.lightGreyTextDark
            : AppColors.lightGreyText;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          decoration: BoxDecoration(
            color:
                theme.brightness == Brightness.light
                    ? themeColors.glassBackground.withOpacity(0.85)
                    : AppColors.cardDark,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            border: Border(
              top: BorderSide(color: themeColors.borderColor, width: 1.5),
            ),
            boxShadow: [
              BoxShadow(
                color: themeColors.cardShadow,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo
              Image.asset(
                'images/app_logo.png',
                width: screenWidth * 0.25,
                height: screenWidth * 0.25,
              ),
              const SizedBox(height: 15),

              // Crafted in India
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Crafted with  ',
                    style: TextStyle(fontSize: 14, color: primaryText),
                  ),
                  const Icon(Icons.favorite, color: Colors.red, size: 16),
                  Text(
                    '  in India',
                    style: TextStyle(fontSize: 14, color: primaryText),
                  ),
                ],
              ),
              const SizedBox(height: 7),

              // Powered by
              Text(
                'Powered by',
                style: TextStyle(fontSize: 11, color: secondaryText),
              ),
              const SizedBox(height: 5),
              Text(
                'Lifeline Healthcare',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: primaryText,
                ),
              ),
              const SizedBox(height: 15),

              // Vision statement
              Text(
                'Our vision is to help mankind live healthier, longer lives by making quality healthcare, accessible, affordable and convenient.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: secondaryText,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
