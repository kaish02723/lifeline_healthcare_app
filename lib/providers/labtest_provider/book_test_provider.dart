import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lifeline_healthcare_app/models/labtest_models/my_labtest_model.dart';
import 'package:lifeline_healthcare_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class BookTestProvider with ChangeNotifier {
  final TextEditingController testNameController = TextEditingController();
  final TextEditingController testPhoneController = TextEditingController();
  final testFormKey = GlobalKey<FormState>();

  List<MyTestDataModel> myLabTestList = [];

  final baseUrl = 'https://labtest-and-booktest.onrender.com';

  Future<void> bookTest(Map<String, dynamic> data, BuildContext context) async {
    try {
      var api = await http.post(
        Uri.parse('$baseUrl/bookings/book-test'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      // print("STATUS: ${api.statusCode}");
      // print("BODY: ${api.body}");

      if (api.statusCode == 200 || api.statusCode == 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Test booked')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Booking failed!')));
      }
    } catch (e) {
      print("BOOK TEST ERROR: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Something went wrong')));
    }
  }

  Future<void> getTestStatus(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    var user_Id = authProvider.userId;

    print('User id is : $user_Id');

    if (user_Id == null || user_Id.toString().isEmpty) {
      print("ERROR: USER ID is NULL");
      return;
    }

    try {
      var res = await http.get(
        Uri.parse('$baseUrl/bookings/get-test/$user_Id'),
      );

      print("API : ${res.body}");

      if (res.statusCode == 200 || res.statusCode == 201) {
        var body = jsonDecode(res.body);
        MyLabTestModel model = MyLabTestModel.convertToModel(body);
        myLabTestList = model.data ?? [];
        notifyListeners();
      } else {
        print("Failed to load tests");
      }
    } catch (e) {
      print("GET TEST ERROR: $e");
    }
  }
}
