import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lifeline_healthcare_app/screens/auth/complete_profile_screen.dart';
import '../screens/auth/verify_otp_screen.dart';

class AuthProvider with ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');

  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  final TextEditingController otp = TextEditingController();

  final String authUrl = 'https://phone-auth-with-jwt-4.onrender.com/auth';

  ValueNotifier<int> timerValue = ValueNotifier(30);
  Timer? _timer;

  String? userId;

  void setUserId(String id) {
    userId = id;
    notifyListeners();
  }

  /// TIMER
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

  /// SEND OTP
  Future<void> sendOtp(Map<String, dynamic> data, BuildContext context) async {
    try {
      final res = await http.post(
        Uri.parse('$authUrl/send-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        startTimer();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerifyScreen(phone: phoneController.text),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid phone number")),
        );
      }
    } catch (e) {
      print("SEND OTP ERROR: $e");
    }
    notifyListeners();
  }

  /// RESEND OTP
  Future<void> resendOtp(String phone) async {
    var payload = {"phone": "+91$phone"};
    try {
      await http.post(
        Uri.parse('$authUrl/send-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );
      startTimer();
    } catch (e) {
      print("RESEND ERROR: $e");
    }
  }

  /// VERIFY OTP
  Future<void> verifyOtp(Map<String, dynamic> data, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('$authUrl/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      final body = jsonDecode(response.body);

      if (body["message"] == "OTP verified successfully") {
        if (body["user"] != null && body["user"]["id"] != null) {
          String id = body["user"]["id"].toString();

          setUserId(id);
          print("Stored User ID: $userId");

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UsersDetails()),
          );
        } else {
          print(" ERROR: user.id not found in response");
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Invalid OTP")));
        print("OTP FAILED: ${response.body}");
      }
    } catch (e) {
      print("VERIFY OTP ERROR: $e");
    }
  }
}
