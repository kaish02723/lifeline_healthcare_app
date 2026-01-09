import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/rating_model/top_rating_review_api_model.dart';

class TopRatingProvider with ChangeNotifier {
  bool isLoadingTopReviews = false;
  bool isLoadingAverage = false;
  String? error;

  List<TopRatingData> topReviews = [];
  TotalRatingAverageData? averageData;

  final String baseUrl =
      'https://phone-auth-with-jwt-4.onrender.com/rating';

  Future<void> fetchTopReviews() async {
    isLoadingTopReviews = true;
    error = null;
    notifyListeners();

    try {
      final response =
      await http.get(Uri.parse('$baseUrl/top-reviews'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final model = TopRatingReviewApiModel.fromJson(jsonData);

        topReviews = model.data ?? [];
      } else {
        error = 'Failed to load top reviews';
      }
    } catch (e) {
      error = e.toString();
    }

    isLoadingTopReviews = false;
    notifyListeners();
  }

  Future<void> fetchAverageRating() async {
    isLoadingAverage = true;
    error = null;
    notifyListeners();

    try {
      final response =
      await http.get(Uri.parse('$baseUrl/all-ratings/average'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final model =
        TotalRatingAverageApiModel.fromJson(jsonData);

        averageData = model.data;
      } else {
        error = 'Failed to load rating summary';
      }
    } catch (e) {
      error = e.toString();
    }

    isLoadingAverage = false;
    notifyListeners();
  }

  Future<void> fetchRatingDashboardData() async {
    await Future.wait([
      fetchTopReviews(),
      fetchAverageRating(),
    ]);
  }
}
