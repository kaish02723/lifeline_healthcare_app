import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../models/rating_model/submit_rating_model.dart';
import '../auth_provider.dart';

class SubmitRatingProvider with ChangeNotifier {
  bool isLoading = false;
  String? successMessage;
  String? errorMessage;

  Future<void> submitRating(
    SubmitRatingModel model,
    BuildContext context,
  ) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = await authProvider.getToken();

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
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(model.toJson()),
      );

      // print(response.body);
      // print(response.request?.headers);

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        successMessage = data['message'];
      } else {
        errorMessage = data['message'] ?? "Failed to submit rating";
      }
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  int selectedRating = 0;
  int labtestRating = 0;


  selectedRatingCount(int index) {
    selectedRating = index + 1;
    notifyListeners();
  }

  labtestSelectedRatingCount(int index) {
    labtestRating = index + 1;
    notifyListeners();
  }
}
