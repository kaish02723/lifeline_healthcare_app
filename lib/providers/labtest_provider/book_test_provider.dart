import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookTestProvider with ChangeNotifier {
  final TextEditingController testNameController = TextEditingController();
  final TextEditingController testPhoneController = TextEditingController();

  final testFormKey = GlobalKey<FormState>();

  final baseUrl = 'https://labtest-and-booktest.onrender.com';

  Future<void> bookTest(Map<String, dynamic> data, BuildContext context) async {
    try {
      var api = await http.post(
        Uri.parse('$baseUrl/bookings/book-test'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );

      // print("STATUS: ${api.statusCode}");
      // print("BODY: ${api.body}");

      if (api.statusCode == 200 || api.statusCode == 201) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Test booked')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Booking failed!')));
      }
    } catch (e) {
      print("BOOK TEST ERROR: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong')),
      );
    }
  }
}
