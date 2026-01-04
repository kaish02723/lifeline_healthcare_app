import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:lifeline_healthcare_app/providers/user_detail/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/surgery/surgery_model.dart';

class SurgeryService {
  final baseUrl = 'https://phone-auth-with-jwt-4.onrender.com';
  List<BookSurgeryModel> getSurgeryList = [];

  // ApiHelperSurgery();

  Future<void> getSurgeryData(String user_Id) async {
    var response = await http.get(
      Uri.parse("$baseUrl/surgery/details/$user_Id"),
    );

    // print(response.body);
    // print(response.request?.headers);

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      List<dynamic> data = decode["data"];

      getSurgeryList =
          data.map((e) => BookSurgeryModel.jsonToModal(e)).toList();
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  Future<BookSurgeryModel?> postSurgeryData(
    Map<String, dynamic> data,
    BuildContext context,
  ) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final authToken = authProvider.token;

    var response = await http.post(
      Uri.parse("$baseUrl/surgery/book_surgery"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $authToken",
      },
      body: jsonEncode(data),
    );

    print(response.body);
    print(response.request?.headers);

    if (response.statusCode == 201) {
      var jsonBody = jsonDecode(response.body);
      return BookSurgeryModel.jsonToModal(jsonBody);
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  }
}
