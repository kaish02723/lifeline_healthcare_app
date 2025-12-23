import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lifeline_healthcare_app/providers/user_detail/get_userdetail_provider.dart';
import 'package:lifeline_healthcare_app/screens/auth/verify_otp_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lifeline_healthcare_app/screens/auth/complete_profile_screen.dart';

class AuthProvider with ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otp = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

  final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');

  final String authUrl = 'https://phone-auth-with-jwt-4.onrender.com/auth';

  ValueNotifier<int> timerValue = ValueNotifier(60);
  Timer? _timer;

  // NEW VALUE NOTIFIER FOR BUTTON COLOR
  ValueNotifier<bool> isPhoneValid = ValueNotifier(false);

  AuthProvider() {
    phoneController.addListener(_validatePhone);
  }

  void _validatePhone() {
    isPhoneValid.value = phoneRegex.hasMatch(phoneController.text);
  }

  String? userId;
  String? token;

  Future<void> saveUserId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", id);
    userId = id;
    notifyListeners();
  }

  Future<void> saveToken(String t) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", t);
    token = t;
    notifyListeners();
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    return token;
  }

  void startTimer() {
    timerValue.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerValue.value == 0) {
        timer.cancel();
      } else {
        timerValue.value--;
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  Future<void> sendOtp(BuildContext context) async {
    try {
      final res = await http.post(
        Uri.parse('$authUrl/send-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"phone": "+91${phoneController.text}"}),
      );

      print(res.body);
      print(res.request?.headers);

      final body = jsonDecode(res.body);

      if (res.statusCode == 200 || res.statusCode == 201) {
        startTimer();

        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerifyScreen(phone: phoneController.text),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(body["error"] ?? "Failed to send OTP")),
        );
      }
    } catch (e) {
      print("SEND OTP ERROR: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }

  Future<void> resendOtp(String phone, BuildContext context) async {
    try {
      final res = await http.post(
        Uri.parse('$authUrl/send-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"phone": "+91$phone"}),
      );

      final body = jsonDecode(res.body);

      if (res.statusCode == 200) {
        startTimer();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OTP resent successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(body["error"] ?? "Failed to resend OTP")),
        );
      }
    } catch (e) {
      print("RESEND ERROR: $e");
    }
  }

  Future<void> verifyOtp(
    Map<String, dynamic> data,
    BuildContext context,
  ) async {
    try {
      var userDetailProvider = Provider.of<GetUserDetailProvider>(
        context,
        listen: false,
      );

      final response = await http.post(
        Uri.parse('$authUrl/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      print(response.body);
      print(response.request?.headers);

      final body = jsonDecode(response.body);

      print("VERIFY RESPONSE: $body");

      if (response.statusCode == 200 &&
          body["message"] == "OTP verified successfully") {
        String id = body["user"]["id"].toString();
        String jwt = body["token"];

        await saveToken(jwt);
        await saveUserId(id);

        otp.clear();

        await userDetailProvider.getUserDetail(context);
        var user = userDetailProvider.user;

        bool isProfileComplete =
            user != null &&
                user.name != null &&
                user.name!.trim().isNotEmpty &&
                user.email != null &&
                user.email!.trim().isNotEmpty;

        if (!context.mounted) return;

        if (isProfileComplete) {
          Navigator.pushReplacementNamed(context, '/dashboard');
        } else {
          Navigator.pushReplacementNamed(context, '/create_profile');
        }
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Invalid OTP")));
      }
    } catch (e) {
      print("VERIFY OTP ERROR: $e");
    }
  }

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    token = prefs.getString("token");
    userId = prefs.getString("userId");

    return token != null && token!.isNotEmpty;
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove("token");
    await prefs.remove("userId");

    token = null;
    userId = null;

    stopTimer();

    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/phone_auth_screen',
      (route) => false,
    );

    notifyListeners();
  }
}
