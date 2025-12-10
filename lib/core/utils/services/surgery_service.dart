import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/surgery_model.dart';

class SurgeryService {
  final baseUrl = 'https://phone-auth-with-jwt-4.onrender.com';
  List<BookSurgeryModel> getSurgeryList = [];

  // ApiHelperSurgery();

  Future<void> getSurgeryData() async {
    var response = await http.get(Uri.parse("$baseUrl/surgery/all_details"));

    // print(response.body);
    // print(response.request?.headers);

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      List<dynamic> data = decode["data"];

      getSurgeryList = data
          .map((e) => BookSurgeryModel.jsonToModal(e))
          .toList();
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  Future<BookSurgeryModel?> postSurgeryData(Map<String, dynamic> data) async {
    var response = await http.post(
      Uri.parse("$baseUrl/surgery/book_surgery"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    print(response.body);
    print(response.request?.headers);

    if (response.statusCode == 201) {
      var jsonBody = jsonDecode(response.body);
      return BookSurgeryModel.jsonToModal(jsonBody);
    }
    return null;
  }
}
