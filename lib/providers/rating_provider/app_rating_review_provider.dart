import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/rating_model/top_rating_review_api_model.dart';


class TopRatingProvider with ChangeNotifier {
  bool isLoading = false;
  String? error;
  List<TopRatingData> ratings = [];

  Future<void> getTopRatings() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final uri = Uri.parse(
        "https://phone-auth-with-jwt-4.onrender.com/rating/top-reviews",
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final apiModel =
        TopRatingReviewApiModel.fromJson(jsonData);

        ratings = apiModel.data ?? [];
      } else {
        error = "Failed to load top ratings";
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
