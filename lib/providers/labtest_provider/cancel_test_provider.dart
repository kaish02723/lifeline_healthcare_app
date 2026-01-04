import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/providers/labtest_provider/book_test_provider.dart';
import 'package:provider/provider.dart';

import '../user_detail/auth_provider.dart';

class CancelTestProvider with ChangeNotifier {
  TextEditingController cancelReasonController = TextEditingController();
  final cancelStatusUrl = 'https://labtest-and-booktest.onrender.com/bookings';
  final cancelReasonUrl = 'https://phone-auth-with-jwt-4.onrender.com';

  Future<void> cancelLabTest(BuildContext context, int index) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    var user_token = authProvider.token;
    try {
      final bookTestProvider = Provider.of<BookTestProvider>(
        context,
        listen: false,
      );
      final testId = bookTestProvider.myLabTestList[index].testID;

      final headers = {"Content-Type": "application/json"};

      final cancelTestResponse = await http.put(
        Uri.parse('$cancelReasonUrl/labtest/cancel-labtest/$testId'),
        headers: {
          "Authorization": "Bearer $user_token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"cancelreason": cancelReasonController.text}),
      );

      print(cancelTestResponse.body);
      print(cancelTestResponse.request?.headers);

      final updateTestStatusResponse = await http.put(
        Uri.parse('$cancelStatusUrl/labtest-status/$testId'),
        headers: headers,
        body: jsonEncode({"status": 'cancelled'}),
      );

      // print('cancel labtest: ${cancelTestResponse.body}');
      // print('cancel labtest req headers: ${cancelTestResponse.request?.headers}');
      // print('update labtest status: ${updateTestStatusResponse.body}');
      // print('update labtest status req headers: ${updateTestStatusResponse.request?.headers}');

      if (cancelTestResponse.statusCode == 200 &&
          updateTestStatusResponse.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            showCloseIcon: true,
            closeIconColor: Colors.white,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green.shade900,
            content: Text(
              'Test Cancelled successfully',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        await bookTestProvider.getTestStatus(context);
        bookTestProvider.myLabTestList.removeAt(index);
        bookTestProvider.notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            showCloseIcon: true,
            content: Text('Failed to cancel labtest: ${cancelTestResponse.body}'),
          ),
        );
      }
      notifyListeners();
    } catch (e) {
      print('Error cancelling labtest: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error cancelling labtest: $e')));
    }
  }
}
