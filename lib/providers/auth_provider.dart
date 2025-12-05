import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lifeline_healthcare_app/screens/auth/phone_auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lifeline_healthcare_app/screens/auth/complete_profile_screen.dart';
import '../screens/auth/verify_otp_screen.dart';

class AuthProvider with ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otp = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

  final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');

  final String authUrl = 'https://phone-auth-with-jwt-4.onrender.com/auth';

  ValueNotifier<int> timerValue = ValueNotifier(30);
  Timer? _timer;

  String? userId;
  String? token;

  // ---------------------------------------------------------
  // SAVE USER ID
  // ---------------------------------------------------------
  Future<void> saveUserId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", id);
    userId = id;
    notifyListeners();
  }

  // ---------------------------------------------------------
  // SAVE TOKEN
  // ---------------------------------------------------------
  Future<void> saveToken(String t) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", t);
    token = t;
    notifyListeners();
  }

  // ---------------------------------------------------------
  // GET TOKEN
  // ---------------------------------------------------------
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    return token;
  }

  // ---------------------------------------------------------
  // START OTP TIMER
  // ---------------------------------------------------------
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
  }

  // ---------------------------------------------------------
  // SEND OTP
  // ---------------------------------------------------------
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
            builder: (context) =>
                OtpVerifyScreen(phone: phoneController.text),
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
  }

  // ---------------------------------------------------------
  // RESEND OTP
  // ---------------------------------------------------------
  Future<void> resendOtp(String phone) async {
    try {
      await http.post(
        Uri.parse('$authUrl/send-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"phone": "+91$phone"}),
      );
      startTimer();
    } catch (e) {
      print("RESEND ERROR: $e");
    }
  }

  // ---------------------------------------------------------
  // VERIFY OTP
  // ---------------------------------------------------------
  Future<void> verifyOtp(
      Map<String, dynamic> data, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('$authUrl/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      final body = jsonDecode(response.body);

      print("VERIFY RESPONSE: $body");

      if (body["message"] == "OTP verified successfully") {
        String id = body["user"]["id"].toString();
        String jwt = body["token"];

        // SAVE TOKEN + USER ID (VERY IMPORTANT)
        await saveToken(jwt);
        await saveUserId(id);

        print("Saved User ID: $id");
        print("Saved Token: $jwt");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UsersDetails()),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Invalid OTP")));
      }
    } catch (e) {
      print("VERIFY OTP ERROR: $e");
    }
  }

  // ---------------------------------------------------------
  // CHECK LOGIN STATUS
  // ---------------------------------------------------------
  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    token = prefs.getString("token");
    userId = prefs.getString("userId"); // RESTORE USER ID

    if (token != null && token!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  // ---------------------------------------------------------
  // LOGOUT
  // ---------------------------------------------------------
  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove("token");
    await prefs.remove("userId");

    token = null;
    userId = null;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PhoneAuthScreen()),
    );

    notifyListeners();
  }
}
