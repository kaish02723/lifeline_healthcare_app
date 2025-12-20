import 'dart:ui';
import 'package:flutter/material.dart';

import '../../config/color.dart';
import '../../config/app_theme_colors.dart';

class TermsPolicyScreen extends StatelessWidget {
  const TermsPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final glass = theme.extension<AppThemeColors>()!;

    return Scaffold(
      backgroundColor:
      isDark ? AppColors.backgroundDark : AppColors.background,

      /// 🔹 APP BAR
      appBar: AppBar(
        title: const Text("Terms & Policy"),
        backgroundColor:
        isDark ? AppColors.primaryDark : AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _glassCard(
            context,
            title: "Terms & Conditions",
            icon: Icons.description_outlined,
            content:
            "By using this application, you agree to comply with all "
                "terms and conditions. The services provided are intended "
                "for healthcare assistance only and should not replace "
                "professional medical advice.",
          ),

          const SizedBox(height: 16),

          _glassCard(
            context,
            title: "Privacy Policy",
            icon: Icons.privacy_tip_outlined,
            content:
            "We respect your privacy. Your personal data is securely "
                "stored and never shared with third parties without consent. "
                "We only collect information necessary to provide our services.",
          ),

          const SizedBox(height: 16),

          _glassCard(
            context,
            title: "Refund & Cancellation",
            icon: Icons.currency_rupee_outlined,
            content:
            "Orders once placed can be cancelled within the allowed time. "
                "Refunds will be processed to the original payment method "
                "as per our refund policy timelines.",
          ),

          const SizedBox(height: 24),

          Center(
            child: Text(
              "Last updated: Aug 2025",
              style: TextStyle(
                fontSize: 12,
                color: isDark
                    ? AppColors.lightGreyTextDark
                    : AppColors.lightGreyText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🧊 GLASS CARD
  Widget _glassCard(
      BuildContext context, {
        required String title,
        required String content,
        required IconData icon,
      }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final glass = theme.extension<AppThemeColors>()!;

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: glass.glassBackground,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: glass.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: isDark
                        ? AppColors.iconDark
                        : AppColors.icon,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                      isDark ? AppColors.textDark : AppColors.text,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                content,
                style: TextStyle(
                  height: 1.5,
                  color: isDark
                      ? AppColors.lightGreyTextDark
                      : AppColors.greyText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
