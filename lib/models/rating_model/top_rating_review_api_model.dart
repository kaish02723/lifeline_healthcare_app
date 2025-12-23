class TopRatingReviewApiModel {
  bool? status;
  List<TopRatingData>? data;

  TopRatingReviewApiModel({this.status, this.data});

  factory TopRatingReviewApiModel.fromJson(Map<String, dynamic> json) {
    return TopRatingReviewApiModel(
      status: json['status'],
      data:
          json['data'] != null
              ? (json['data'] as List)
                  .map((e) => TopRatingData.fromJson(e))
                  .toList()
              : [],
    );
  }
}

class TopRatingData {
  int? rating;
  String? feedback;
  String? createdAt;

  TopRatingData({this.rating, this.feedback, this.createdAt});

  factory TopRatingData.fromJson(Map<String, dynamic> json) {
    return TopRatingData(
      rating: json['rating'],
      feedback: json['feedback'],
      createdAt: json['created_at'],
    );
  }
}

class TotalRatingAverageApiModel {
  final String status;
  final TotalRatingAverageData? data;

  TotalRatingAverageApiModel({required this.status, this.data});

  factory TotalRatingAverageApiModel.fromJson(Map<String, dynamic> json) {
    return TotalRatingAverageApiModel(
      status: json['status'] ?? false,
      data:
          json['data'] != null
              ? TotalRatingAverageData.fromJson(json['data'])
              : null,
    );
  }
}

class TotalRatingAverageData {
  final double averageRating;
  final int totalReviews;

  TotalRatingAverageData({
    required this.averageRating,
    required this.totalReviews,
  });

  factory TotalRatingAverageData.fromJson(Map<String, dynamic> json) {
    return TotalRatingAverageData(
      averageRating: double.tryParse(json['average_rating'].toString()) ?? 0.0,
      totalReviews: json['total_reviews'] ?? 0,
    );
  }
}
