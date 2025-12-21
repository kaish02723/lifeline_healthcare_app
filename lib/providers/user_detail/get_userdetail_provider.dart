import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifeline_healthcare_app/models/user_model.dart';
import 'package:lifeline_healthcare_app/providers/auth_provider.dart';
import 'package:lifeline_healthcare_app/screens/home/user_profile_screen.dart';
import 'package:provider/provider.dart';

class GetUserDetailProvider with ChangeNotifier {
  final TextEditingController updateNameController = TextEditingController();
  final TextEditingController updateEmailController = TextEditingController();
  final TextEditingController updateDobController = TextEditingController();
  final TextEditingController updateAddressController = TextEditingController();
  String? updateGender;

  final baseUrl = 'https://phone-auth-with-jwt-4.onrender.com/userProfile';

  UserDataModel? user;

  bool get isProfileCompleted => user?.isProfileComplete ?? false;

  String get userName =>
      user?.name?.isNotEmpty == true ? user!.name! : "Guest User";

  String? get profileImage => user?.picture;

  Future<void> getUserDetail(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final userId = authProvider.userId;
    final token = await authProvider.getToken();

    if (userId == null || token == null) {
      print("USER ID OR TOKEN NULL");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get-profile'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      print("RESPONSE BODY: ${response.body}");
      print("HEADERS USED: ${response.request?.headers}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        GetUserDetailModel model = GetUserDetailModel.fromJson(data);
        user = model.user;

        print("User Detail Loaded: ${user?.name}");
        fillUserData();
        notifyListeners();
      } else {
        print("ERROR: ${response.body}");
      }
    } catch (e) {
      print("EXCEPTION: $e");
    }
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      updateDobController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  Future<void> updateUserProfile(
    BuildContext context,
    Map<String, dynamic> data,
  ) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final userId = authProvider.userId;
    final token = await authProvider.getToken();

    if (userId == null || token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Session expired! Please login again.")),
      );
      return;
    }

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/update-profile'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );

      print("UPDATE RESPONSE: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        /// UPDATE SUCCESS
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully!")),
        );

        /// Refresh user data
        await getUserDetail(context);
        Navigator.pop(context, true);

        notifyListeners();
      } else {
        /// INVALID DATA OR ERROR
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("update failed")));
      }
    } catch (e) {
      print("UPDATE EXCEPTION: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Something went wrong!")));
    }
  }

  void fillUserData() {
    if (user != null) {
      updateNameController.text = user!.name ?? "";
      updateEmailController.text = user!.email ?? "";
      updateDobController.text = user!.dateOfBirth ?? "";
      updateAddressController.text = user!.address ?? "";

      // FIX CASE ISSUE
      if (user!.gender != null) {
        updateGender = _capitalizeGender(user!.gender!);
      }
    }
  }

  String _capitalizeGender(String g) {
    g = g.trim().toLowerCase();
    if (g == "male") return "Male";
    if (g == "female") return "Female";
    return "Other";
  }

  Future<String?> uploadProfileImage(File file, BuildContext context) async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var userId = authProvider.userId;

    final url = Uri.parse(
      "https://phone-auth-with-jwt-4.onrender.com/userProfile/upload/$userId",
    );

    var request = http.MultipartRequest("POST", url);
    final token = await authProvider.getToken();

    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await http.MultipartFile.fromPath("image", file.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);
      final data = jsonDecode(res.body);
      return data["imageUrl"];
    }
    return null;
  }

  Future<void> uploadAndUpdateImage(
      File file,
      BuildContext context,
      ) async {
    final imageUrl = await uploadProfileImage(file, context);

    if (imageUrl != null) {
      user?.picture = imageUrl;
      notifyListeners();
    }
  }


  updateGenderValue(String value) {
    updateGender = value;
    notifyListeners();
  }

  // update profile
  File? imageFile;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }
}
