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
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        height: 110,
        width: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(height: 45, imageUrl: imageUrl),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
