import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'dashboard_glass_card.dart';

class OfferBanner extends StatelessWidget {
  final String image;

  const OfferBanner({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      height: 170,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
