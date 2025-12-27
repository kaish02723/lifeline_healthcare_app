import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:lifeline_healthcare_app/models/labtest_models/popular_test_model.dart';

class PopularTestProvider with ChangeNotifier {
  final baseUrl = 'https://phone-auth-with-jwt-4.onrender.com';

  List<TestDataModel> originalList = [];
  List<TestDataModel> popularDataList = [];

  var searchLabTestController = TextEditingController();
  bool isSearchedLabTest = false;
  bool isLoading = false;

  void clearSearch() {
    searchLabTestController.clear();
    isSearchedLabTest = false;
    popularDataList = List.from(originalList);
    notifyListeners();
  }

  Future<void> getPopularLabTest() async {
    isLoading = true;
    notifyListeners();

    try {
      var response = await http.get(
        Uri.parse('$baseUrl/lab/all-popular-tests'),
      );

      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        PopularTestModel model =
        PopularTestModel.convertToModel(jsonBody);

        originalList = model.data ?? [];
        popularDataList = List.from(originalList);
      }
    } catch (e) {
      debugPrint("API Error: $e");
    }

    isLoading = false;
    notifyListeners();
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
