import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/providers/labtest_provider/book_test_provider.dart';
import 'package:provider/provider.dart';

class CancelTestProvider with ChangeNotifier {
  TextEditingController cancelReasonController = TextEditingController();
  final url = 'https://labtest-and-booktest.onrender.com/bookings';

  Future<void> cancelLabTest(BuildContext context, int index) async {
    try {
      final bookTestProvider = Provider.of<BookTestProvider>(context, listen: false);
      final testId = bookTestProvider.myLabTestList[index].testID;

      final headers = {
        "Content-Type": "application/json",
      };

      final cancelTestResponse = await http.put(
        Uri.parse('$url/cancel-test/$testId'),
        headers: headers,
        body: jsonEncode({"cancelreason": cancelReasonController.text}),
      );

      final updateTestStatusResponse = await http.put(
        Uri.parse('$url/test-status/$testId'),
        headers: headers,
        body: jsonEncode({"status": 'cancelled'}),
      );

      print('cancel test: ${cancelTestResponse.body}');
      print('cancel test req headers: ${cancelTestResponse.request?.headers}');
      print('update test status: ${updateTestStatusResponse.body}');
      print('update test status req headers: ${updateTestStatusResponse.request?.headers}');

      if (cancelTestResponse.statusCode == 200 && updateTestStatusResponse.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Test Cancelled successfully')),
        );
        bookTestProvider.getTestStatus(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to cancel test: ${cancelTestResponse.body}')),
        );
      }
    } catch (e) {
      print('Error cancelling test: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error cancelling test: $e')),
      );
    }
  }

}
