import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'dashboard_glass_card.dart';

class ServiceItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const ServiceItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    // Responsive sizes
    final cardWidth = w * 0.24;
    final cardHeight = h * 0.13;
    final imageSize = w * 0.12;
    final textSize = w * 0.035;

    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        height: cardHeight,
        width: cardWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              height: imageSize,
              width: imageSize,
              fit: BoxFit.contain,
              imageUrl: imageUrl,
            ),

            SizedBox(height: h * 0.01),

            Flexible(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: textSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
