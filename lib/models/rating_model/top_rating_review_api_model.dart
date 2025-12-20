class TopRatingReviewApiModel {
  bool? status;
  List<TopRatingData>? data;

  TopRatingReviewApiModel({this.status, this.data});

  factory TopRatingReviewApiModel.fromJson(Map<String, dynamic> json) {
    return TopRatingReviewApiModel(
      status: json['status'],
      data: json['data'] != null
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

  TopRatingData({
    this.rating,
    this.feedback,
    this.createdAt,
  });

  factory TopRatingData.fromJson(Map<String, dynamic> json) {
    return TopRatingData(
      rating: json['rating'],
      feedback: json['feedback'],
      createdAt: json['created_at'],
    );
  }
}

