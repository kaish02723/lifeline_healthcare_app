import 'dart:ffi';
import 'package:flutter/material.dart';

import '../screen/theme/color.dart';
import '../screen/theme/test_styles.dart';

class MedicineListCard extends StatelessWidget{
  final VoidCallback onTap;
  final Image image;
  final String title;
  final String subtitle;
  final String mrp;
  final Container quantityBox;
  const MedicineListCard({super.key, required this.onTap, required this.image, required this.title, required this.subtitle, required this.mrp, required this.quantityBox});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isDark ? Colors.grey[900] : Colors.grey[200],
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 3),
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ]
        ),
        child:Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image(
                image: image.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.h2.copyWith(
                      color: AppColors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyle.h3.copyWith(
                      color: AppColors.greyText,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    mrp,
                    style: AppTextStyle.titleLarge.copyWith(
                      color: AppColors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  quantityBox,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }}