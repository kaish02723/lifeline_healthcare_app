
import 'package:flutter/material.dart';

import '../config/color.dart';

class MedicineListCard extends StatelessWidget {
  final VoidCallback onTap;
  final String imageUrl;
  final String title;
  final String subtitle;
  final String rating;
  final String price;
  final String discount;
  final Widget actionButton;

  const MedicineListCard({
    super.key,
    required this.onTap,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.price,
    required this.discount,
    required this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(width * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: isDark ? Colors.grey.shade900 : Colors.white,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            /// IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                width: width * 0.18,
                height: width * 0.18,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: width * 0.04),

            /// DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: width * 0.037,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),

                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: width * 0.033,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// Rating
                  Row(
                    children: [
                      const Icon(Icons.star,
                          size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// PRICE + ACTION
                  Row(
                    children: [
                      Text(
                        "₹$price",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.035,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "$discount% OFF",
                        style: TextStyle(
                          fontSize: width * 0.03,
                          color: AppColors.secondary,
                        ),
                      ),
                      const Spacer(),
                      actionButton,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
