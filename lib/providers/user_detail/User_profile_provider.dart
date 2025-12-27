import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lifeline_healthcare_app/models/user_details/user_detail_model.dart';
import 'package:lifeline_healthcare_app/providers/user_detail/auth_provider.dart';
import 'package:provider/provider.dart';

class UserProfileProvider with ChangeNotifier {
  final baseUrl = 'https://phone-auth-with-jwt-4.onrender.com/userProfile';
  UserDataModel? user;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final addressController = TextEditingController();
  final genderController = TextEditingController();

  String? updateGender;
  bool isLoading = false;

  //get profile
  Future<void> getProfile(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      final verified = Provider.of<AuthProvider>(context, listen: false);
      final token = await verified.getToken();

      final response = await http.get(
        Uri.parse("$baseUrl/get-profile"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final decode = jsonDecode(response.body);
        user = UserDetailModel.fromJson(decode).user;
      }
    } catch (error) {
      print("get profile error : $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //create profile
  Future<void> createProfile(
    BuildContext context,
    Map<String, dynamic> data,
  ) async {
    try {
      isLoading = true;
      notifyListeners();

      final verified = Provider.of<AuthProvider>(context, listen: false);
      final token = await verified.getToken();

      final response = await http.post(
        Uri.parse('$baseUrl/create-profile'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        await getProfile(context);
      }
    } catch (error) {
      print("get profile error : $error");
    }
  }

  //update profile
  Future<void> updateProfile(
    BuildContext context,
    Map<String, dynamic> data,
  ) async {
    try {
      isLoading = true;
      notifyListeners();

      final verified = Provider.of<AuthProvider>(context, listen: false);
      final token = await verified.getToken();

      final response = await http.put(
        Uri.parse("$baseUrl/update-profile"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-type": "application/json",
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await getProfile(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            showCloseIcon: true,
            closeIconColor: Colors.white,
            backgroundColor: Colors.green.shade900,
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Profile updated ✔️',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    } catch (error) {
      print("get profile error : $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> uploadProfileImage(File file, BuildContext context) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final userId = auth.userId;
    final token = await auth.getToken();

    final request = http.MultipartRequest(
      "POST",
      Uri.parse('$baseUrl/upload/$userId'),
    );

    request.headers['Authorization'] = 'Bearer $token';

    request.files.add(await http.MultipartFile.fromPath("image", file.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);
      final imageUrl = jsonDecode(res.body)["imageUrl"];

      ///  update local user also
      user?.picture = imageUrl;
      notifyListeners();

      return imageUrl;
    }
    return null;
  }

  // FILL FORM
  void fillFormData() {
    if (user == null) return;
    nameController.text = user!.name ?? "";
    emailController.text = user!.email ?? "";
    dobController.text = user!.dateOfBirth ?? "";
    addressController.text = user!.address ?? "";

    if (user!.gender != null) {
      updateGender = _capitalizeGender(user!.gender!);
    }
  }

  // SELECT DATE
  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      notifyListeners();
    }
  }

  String _capitalizeGender(String g) {
    g = g.trim().toLowerCase();
    if (g == "male") return "Male";
    if (g == "female") return "Female";
    return "Other";
  }

  void clear() {
    user = null;
    notifyListeners();
  }
}
