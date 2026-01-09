class SubmitRatingModel {
  String ratingTypes;
  double rating;
  String feedback;

  // App rating fields
  double? appVersion;
  String? platform;

  // Service rating fields
  String? serviceType;
  String? serviceId;

  SubmitRatingModel({
    required this.ratingTypes,
    required this.rating,
    required this.feedback,
    this.appVersion,
    this.platform,
    this.serviceType,
    this.serviceId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "rating_types": ratingTypes,
      "rating": rating,
      "feedback": feedback,
    };

    if (ratingTypes == "app") {
      data["app_version"] = appVersion;
      data["platform"] = platform;
    }

    if (ratingTypes == "service") {
      data["service_type"] = serviceType;
      data["service_id"] = serviceId;
    }

    return data;
  }
}
