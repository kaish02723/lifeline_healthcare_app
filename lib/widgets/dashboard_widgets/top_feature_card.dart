import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dashboard_glass_card.dart';

class TopFeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final VoidCallback onTap;

  const TopFeatureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        height: h * 0.16,
        width: w * 0.44,
        child: Stack(
          children: [
            Positioned(
              top: h * 0.010,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14, // responsive font
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Positioned(
              top: h * 0.055,
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: w * 0.028, // responsive font
                  color: Colors.grey,
                ),
              ),
            ),

            Positioned(
              right: 0,
              top: h * 0.03,
              child: CachedNetworkImage(
                height: h * 0.11, // responsive image
                fit: BoxFit.cover,
                imageUrl: image,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
