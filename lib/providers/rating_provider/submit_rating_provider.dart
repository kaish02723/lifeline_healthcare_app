import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/rating_model/submit_rating_model.dart';

class SubmitRatingProvider with ChangeNotifier {
  bool isLoading = false;
  String? successMessage;
  String? errorMessage;

  Future<void> submitRating(SubmitRatingModel model) async {
    isLoading = true;
    successMessage = null;
    errorMessage = null;
    notifyListeners();

    try {
      final uri = Uri.parse(
        "https://phone-auth-with-jwt-4.onrender.com/rating/ratenow",
      );

      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(model.toJson()),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        successMessage = data['message'];
      } else {
        errorMessage =
            data['message'] ?? "Failed to submit rating";
      }
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
