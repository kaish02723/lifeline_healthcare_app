import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/rating_provider/app_rating_review_provider.dart';
import 'top_rating_review_card.dart';

class TopRatingReviewList extends StatelessWidget {
  const TopRatingReviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TopRatingProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.ratings.isEmpty) {
          return const SizedBox.shrink();
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: provider.ratings.length,
          itemBuilder: (context, index) {
            return TopRatingReviewCard(
              data: provider.ratings[index],
            );
          },
        );
      },
    );
  }
}
