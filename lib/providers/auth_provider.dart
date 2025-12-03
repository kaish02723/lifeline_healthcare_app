import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../screens/auth/verify_otp_screen.dart';
import '../screens/home/dashboard_screen.dart';

class AuthProvider with ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');

  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  final TextEditingController otp = TextEditingController();

  final String authUrl = 'https://phone-auth-with-jwt-4.onrender.com/auth';

  /// OTP expiry timer
  ValueNotifier<int> timerValue = ValueNotifier(30);
  Timer? _timer;

  void startTimer() {
    timerValue.value = 30;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerValue.value == 0) {
        timer.cancel();
      } else {
        timerValue.value--;
      }
    });
    notifyListeners();
  }

  Future<void> sendOtp(Map<String, dynamic> data, BuildContext context) async {
    try {
      var res = await http.post(
        Uri.parse('$authUrl/send-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        var body = jsonDecode(res.body);
        print("OTP Sent: $body");

        startTimer();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerifyScreen(phone: phoneController.text),
          ),
        );

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("OTP sent successfully")));
      } else {
        print("OTP failed: ${res.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Enter a valid phone number")),
        );
      }
    } catch (e) {
      print("SEND OTP ERROR: $e");
    }

    notifyListeners();
  }

  Future<void> resendOtp(String phone) async {
    var payload = {"phone": "+91$phone"};

    try {
      var res = await http.post(
        Uri.parse('$authUrl/send-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      print("RESEND OTP: ${res.body}");
      startTimer();
    } catch (e) {
      print("RESEND ERROR: $e");
    }
  }

  Future<void> verifyOtp(
    Map<String, dynamic> data,
    BuildContext context,
  ) async {
    try {
      var response = await http.post(
        Uri.parse('$authUrl/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      var body = jsonDecode(response.body);

      if (body["message"] == "OTP verified successfully") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Invalid OTP")));
        print("OTP FAILED: ${response.body}");
      }
    } catch (e) {
      print("VERIFY OTP ERROR: $e");
    }
  }
}
