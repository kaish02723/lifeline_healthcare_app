import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:lifeline_healthcare_app/models/labtest_models/popular_test_model.dart';

class PopularTestProvider with ChangeNotifier {
  final baseUrl = 'https://labtest-and-booktest.onrender.com';
  List<TestDataModel> popularDataList = [];

  Future<void> getPopularLabTest() async {
    var response = await http.get(Uri.parse('$baseUrl/get-popular'));
    print(response.body);
    print(response.request?.headers);

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      PopularTestModel model = PopularTestModel.convertToModel(jsonBody);
      popularDataList = model.data ?? [];
      notifyListeners();
    } else {
      print("Error: ${response.body}");
    }
  }
}
