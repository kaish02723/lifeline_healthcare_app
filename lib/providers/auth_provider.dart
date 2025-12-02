import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  final String authUrl = 'https://phone-auth-with-jwt-4.onrender.com/auth';

  Future<void> sendOtp(Map<String, dynamic> data) async {
    try {
      var res = await http.post(
        Uri.parse('$authUrl/send-otp'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      print("Status Code: ${res.statusCode}");
      print("Response: ${res.body}");

      if (res.statusCode == 201) {
        var body = jsonDecode(res.body);
        print("OTP Sent Success: $body");
      } else {
        print("OTP send failed: ${res.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  verifyOtp() {}
}
