import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lifeline_healthcare_app/models/labtest_models/my_labtest_model.dart';
import 'package:lifeline_healthcare_app/providers/user_detail/auth_provider.dart';
import 'package:provider/provider.dart';

class BookTestProvider with ChangeNotifier {
  final TextEditingController testNameController = TextEditingController();
  final TextEditingController testPhoneController = TextEditingController();
  final testFormKey = GlobalKey<FormState>();

  List<MyTestDataModel> myLabTestList = [];

  final baseUrl = 'https://phone-auth-with-jwt-4.onrender.com';

  //  FINAL BOOK TEST
  Future<bool> bookTest(Map<String, dynamic> data, BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    var user_token = authProvider.token;
    try {
      var api = await http.post(
        Uri.parse('$baseUrl/test/book-test'),
        headers: {
          "Authorization": "Bearer $user_token",
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data),
      );

      print(api.body);
      print(api.request?.headers);

      if (api.statusCode == 200 || api.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("BOOK TEST ERROR: $e");
      return false;
    }
  }

  Future<void> getTestStatus(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    var user_token = authProvider.token;

    try {
      var res = await http.get(
        Uri.parse('$baseUrl/test/get-test'),
        headers: {
          "Authorization": "Bearer $user_token",
          'Content-Type': 'application/json'
        }
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        var body = jsonDecode(res.body);
        MyLabTestModel model = MyLabTestModel.convertToModel(body);
        myLabTestList = model.data ?? [];
        notifyListeners();
      }
    } catch (e) {
      print("GET TEST ERROR: $e");
    }
  }
}
