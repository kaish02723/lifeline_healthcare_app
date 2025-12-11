import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../providers/dashboard_provider.dart';
import 'dashboard_glass_card.dart';

Timer? _offerTimer;
final int _totalOffers = 3;


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

void startOfferAutoScroll(BuildContext context) {
  final offerProvider = Provider.of<DashBoardProvider>(context, listen: false);

  _offerTimer = Timer.periodic(const Duration(seconds: 3), (_) {
    if (offerProvider.offerController.hasClients) {
      int nextPage = offerProvider.currentPage + 1;

      if (nextPage == _totalOffers) nextPage = 0;

      offerProvider.offerController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );

      offerProvider.updatePage(nextPage); // <-- PROVIDER Update
    }
  });
}
