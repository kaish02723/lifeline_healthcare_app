import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:lifeline_healthcare_app/models/labtest_models/popular_test_model.dart';

class PopularTestProvider with ChangeNotifier {
  final baseUrl = 'https://labtest-and-booktest.onrender.com';

  List<TestDataModel> originalList = [];
  List<TestDataModel> popularDataList = [];

  var searchLabTestController = TextEditingController();
  bool isSearchedLabTest = false;

  void clearSearch() {
    searchLabTestController.clear();
    isSearchedLabTest = false;
    popularDataList = List.from(originalList);
    notifyListeners();
  }

  Future<void> getPopularLabTest() async {
    var response = await http.get(Uri.parse('$baseUrl/get-popular'));
    // print(response.body);

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);

      PopularTestModel model = PopularTestModel.convertToModel(jsonBody);

      originalList = model.data ?? [];
      popularDataList = List.from(originalList);

      notifyListeners();
    } else {
      print("Error: ${response.body}");
    }
  }

  void filterSearch(String query) {
    if (query.isEmpty) {
      popularDataList = List.from(originalList);
      isSearchedLabTest = false;
    } else {
      popularDataList = originalList
          .where(
            (item) => item.name!.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      isSearchedLabTest = true;
    }

    notifyListeners();
  }
}
