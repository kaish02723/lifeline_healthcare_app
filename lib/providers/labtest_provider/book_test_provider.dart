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

  final baseUrl = 'https://labtest-and-booktest.onrender.com';

  //  FINAL BOOK TEST
  Future<bool> bookTest(Map<String, dynamic> data) async {
    try {
      var api = await http.post(
        Uri.parse('$baseUrl/bookings/book-test'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

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
    var user_Id = authProvider.userId;

    if (user_Id == null || user_Id.toString().isEmpty) return;

    try {
      var res = await http.get(
        Uri.parse('$baseUrl/bookings/get-test/$user_Id'),
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
