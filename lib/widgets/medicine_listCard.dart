import 'package:flutter/material.dart';
import '../config/color.dart';
import '../config/test_styles.dart';

class MedicineListCard extends StatelessWidget {
  final VoidCallback onTap;
  final Image image;
  final String title;
  final String subtitle;
  final String mrp;
  final Widget quantityBox;

  const MedicineListCard({
    super.key,
    required this.onTap,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.mrp,
    required this.quantityBox,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final imageSize = width * 0.22;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(width * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.transparent : Colors.black12,
              offset: const Offset(0, 3),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image(
                image: image.image,
                width: imageSize,
                height: imageSize,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: width * 0.03),

            /// TEXT CONTENT
            Expanded(
              child: SizedBox(
                height: imageSize,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    Text(
                      title,
                      style: AppTextStyle.h2.copyWith(
                        fontSize: 15,
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    /// Subtitle
                    Text(
                      subtitle,
                      style: AppTextStyle.h3.copyWith(
                        fontSize: width * 0.035,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: width * 0.02),

                    /// Price
                    Text(
                      mrp,
                      style: AppTextStyle.titleLarge.copyWith(
                        fontSize: width * 0.04,
                        color: AppColors.colorText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    /// Quantity Box
                    quantityBox,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
