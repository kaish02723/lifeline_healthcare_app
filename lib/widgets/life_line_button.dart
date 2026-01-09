import 'package:flutter/material.dart';

import '../config/color.dart';

class LifeLineButton extends StatelessWidget{
  final String text;
  final List<Color> bgColor;
  final VoidCallback onTap;

  const LifeLineButton({super.key, required this.text, required this.bgColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness ==Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 200,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isDark?LinearGradient(colors: []):LinearGradient(colors: []),
          borderRadius: BorderRadius.circular(18),
        ),
        child:Text(
          text,
          style: TextStyle(
            color: isDark?AppColors.white:AppColors.black,
            fontFamily: "Inter",
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}