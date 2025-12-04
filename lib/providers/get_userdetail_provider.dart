import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:lifeline_healthcare_app/models/get_user_detail_model.dart';
import 'package:lifeline_healthcare_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class GetUserDetailProvider with ChangeNotifier {
  final baseUrl = 'https://phone-auth-with-jwt-4.onrender.com/userProfile';

  UserDataModel? user;

  Future<void> getUserDetail(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final userId = authProvider.userId;
    final token = await authProvider.getToken();  // <-- Token load here

    if (userId == null || token == null) {
      print("USER ID OR TOKEN NULL");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/details/$userId'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      print("RESPONSE BODY: ${response.body}");
      print("HEADERS USED: ${response.request?.headers}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        GetUserDetailModel model = GetUserDetailModel.fromJson(data);
        user = model.user;

        print("User Detail Loaded: ${user?.name}");
        notifyListeners();
      } else {
        print("ERROR: ${response.body}");
      }
    } catch (e) {
      print("EXCEPTION: $e");
    }
  }
}
