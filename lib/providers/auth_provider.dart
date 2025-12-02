import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../screens/auth/verify_otp_screen.dart';
import '../screens/home/dashboard_screen.dart';

class AuthProvider with ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');

  final otpFormKey = GlobalKey<FormState>();
  final TextEditingController otp = TextEditingController();

  final String authUrl = 'https://phone-auth-with-jwt-4.onrender.com/auth';

  Future<void> sendOtp(Map<String, dynamic> data, BuildContext context) async {
    try {
      var res = await http.post(
        Uri.parse('$authUrl/send-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      // print("Status Code: ${res.statusCode}");
      // print("Response: ${res.body}");

      if (res.statusCode == 200 || res.statusCode == 201) {
        var body = jsonDecode(res.body);
        print("OTP Sent Success: $body");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OtpVerifyScreen(phone: '+91${phoneController.text}'),
          ),
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Otp sent successfully")));
        notifyListeners();
      } else {
        print("OTP send failed: ${res.body}");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Enter a valid phone number")));
      }
    } catch (e) {
      print("Error: $e");
    }
    notifyListeners();
  }

  Future<void> verifyOtp(
    Map<String, dynamic> data,
    BuildContext context,
  ) async {
    var response = await http.post(
      Uri.parse('$authUrl/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    // print("VERIFY STATUS CODE = ${response.statusCode}");
    // print("VERIFY BODY = ${response.body}");

    var body = jsonDecode(response.body);

    if (body["message"] == "OTP verified successfully") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } else {
      print("OTP verification failed: ${response.body}");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Invalid OTP")));
    }
  }
}
