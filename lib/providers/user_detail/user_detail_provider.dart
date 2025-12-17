import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:lifeline_healthcare_app/screens/home/dashboard_screen.dart';
import 'package:provider/provider.dart';

import '../auth_provider.dart';

class UserDetailProvider with ChangeNotifier {
  final baseUrl = 'https://phone-auth-with-jwt-4.onrender.com/userProfile';

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var genderController = TextEditingController();
  var dateController = TextEditingController();

  Future<bool> completeProfile(
    String? userId,
    Map<String, dynamic> data,
    BuildContext context,
  ) async {
    try {
      if (userId == null || userId.isEmpty) {
        print("ERROR: UserId is null!");
        return false;
      }

      final url = Uri.parse('$baseUrl/create-profile');
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final token = await authProvider.getToken();


      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("User details saved successfully");

        nameController.clear();
        emailController.clear();
        genderController.clear();
        dateController.clear();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );

        notifyListeners();
        return true;
      } else {
        print("API Error: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }
}
