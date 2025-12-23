// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../config/color.dart';
// import '../../providers/rating_provider/app_rating_review_provider.dart';
//
// class RatingSummaryCard extends StatelessWidget {
//   const RatingSummaryCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Consumer<TopRatingProvider>(
//       builder: (context, provider, _) {
//         if (provider.isLoadingAverage) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         if (provider.averageData == null) return const SizedBox();
//
//         final rating = provider.averageData!.averageRating;
//         final totalReviews = provider.averageData!.totalReviews;
//
//         return Container(
//           margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: theme.cardColor.withOpacity(0.95),
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: theme.shadowColor.withOpacity(0.1),
//                 blurRadius: 12,
//                 offset: const Offset(0, 6),
//               ),
//             ],
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               //  Icon Bubble
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: AppColors.white,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: theme.shadowColor.withOpacity(0.1),
//                       blurRadius: 6,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: const Icon(
//                   Icons.star,
//                   color: AppColors.golden,
//                   size: 30,
//                 ),
//               ),
//
//               const SizedBox(width: 16),
//
//               // Rating number + stars
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         rating.toStringAsFixed(1),
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: theme.textTheme.bodyMedium?.color,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       buildStarRow(rating),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     "Based on $totalReviews reviews",
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: theme.textTheme.bodyMedium?.color?.withOpacity(
//                         0.6,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               const Spacer(),
//
//               // ✔ Trust badge
//               Container(
//                 padding: const EdgeInsets.all(6),
//                 decoration: BoxDecoration(
//                   color: Colors.green.withOpacity(0.15),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.verified,
//                   color: Colors.green,
//                   size: 26,
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   //  Stars Row
//   Widget buildStarRow(double rating) {
//     return Row(
//       children: List.generate(5, (index) {
//         if (index < rating.floor()) {
//           return const Icon(Icons.star, color: AppColors.golden, size: 18);
//         } else if (index < rating && rating - index >= 0.5) {
//           return const Icon(Icons.star_half, color: AppColors.golden, size: 18);
//         } else {
//           return const Icon(
//             Icons.star_border,
//             color: AppColors.golden,
//             size: 18,
//           );
//         }
//       }),
//     );
//   }
// }
