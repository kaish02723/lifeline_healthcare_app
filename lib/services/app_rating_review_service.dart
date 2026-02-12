import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../models/rating_model/top_rating_review_api_model.dart';

class TopRatingService {
  static const String _baseUrl =
      "https://healthcare.edugaondev.com";

  Future<TopRatingReviewApiModel> fetchTopRatings() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        return TopRatingReviewApiModel.fromJson(
          jsonDecode(response.body),
        );
      } else {
        throw Exception("Failed to load ratings");
      }
    } catch (e) {
      throw Exception("API Error: $e");
    }
  }
}
