import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../models/user_details/user_detail_model.dart';
import 'auth_provider.dart';

class UserProfileProvider with ChangeNotifier {
  final baseUrl = 'https://phone-auth-with-jwt-4.onrender.com/userProfile';

  UserDataModel? user;

  bool isLoading = false;

  // Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final addressController = TextEditingController();
  final genderController = TextEditingController();

  String? updateGender;
  File? imageFile;
  final completeProfileFormKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  /// GETTERS (UI SAFE)
  String get userName =>
      user?.name?.isNotEmpty == true ? user!.name! : "Guest User";

  String? get profileImage => user?.picture;

  /// GET PROFILE
  Future<void> getProfile(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      final auth = Provider.of<AuthProvider>(context, listen: false);
      final token = await auth.getToken();

      final response = await http.get(
        Uri.parse('$baseUrl/get-profile'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        user = UserDetailModel.fromJson(data).user;

        print(user?.name);
        print("bearer token:$token");
        print("image Token: ${user?.picture}");
        print("RAW RESPONSE: ${response.body}");

        fillFormData();
      }

    } catch (e) {
      debugPrint("Get profile error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// CREATE PROFILE
  Future<void> createProfile(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      final auth = Provider.of<AuthProvider>(context, listen: false);
      final token = await auth.getToken();

      final request = http.MultipartRequest(
        "POST", // 👈 create
        Uri.parse('$baseUrl/create-profile'),
      );

      request.headers['Authorization'] = 'Bearer $token';

      // TEXT FIELDS
      request.fields['name'] = nameController.text.trim();
      request.fields['email'] = emailController.text.trim();
      request.fields['gender'] = updateGender ?? '';
      request.fields['date_of_birth'] = dobController.text.trim();
      request.fields['address'] = addressController.text.trim() ??'';

      // IMAGE (optional – SAME LOGIC)
      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', imageFile!.path),
        );
      }

      final response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        await getProfile(context);
      }
    } catch (e) {
      debugPrint("Create profile error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// UPDATE PROFILE
  Future<void> updateProfile(BuildContext context, {File? imageFile}) async {
    try {
      isLoading = true;
      notifyListeners();

      final auth = Provider.of<AuthProvider>(context, listen: false);
      final token = await auth.getToken();

      final request = http.MultipartRequest(
        "PATCH",
        Uri.parse('$baseUrl/update-profile'),
      );

      request.headers['Authorization'] = 'Bearer $token';

      // TEXT FIELDS
      request.fields['name'] = nameController.text;
      request.fields['email'] = emailController.text;
      request.fields['gender'] = updateGender ?? '';
      request.fields['date_of_birth'] = dobController.text;
      request.fields['address'] = addressController.text;

      // IMAGE (optional)
      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image', // ⚠️ SAME as multer field
            imageFile.path,
          ),
        );
      }

      final response = await request.send();
      final res = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        await getProfile(context);
        Navigator.pop(context, true);
      } else {
        debugPrint(res.body);
      }
    } catch (e) {
      debugPrint("Update profile error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// IMAGE PICK
  Future<void> pickImage() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        notifyListeners();
      }
    }
  }
  //pic from camera
  Future<void> pickCameraImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

//update profile  i marge upload profile & upload image
  /// UPLOAD IMAGE
  // Future<String?> uploadProfileImage(File file, BuildContext context) async {
  //   try {
  //     final auth = Provider.of<AuthProvider>(context, listen: false);
  //     final token = await auth.getToken();
  //
  //     final request = http.MultipartRequest(
  //       "POST",
  //       Uri.parse('$baseUrl/upload-image'),
  //     );
  //
  //     request.headers['Authorization'] = 'Bearer $token';
  //     request.files.add(
  //       await http.MultipartFile.fromPath("image", file.path),
  //     );
  //
  //     final response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       final res = await http.Response.fromStream(response);
  //       final imageUrl = jsonDecode(res.body)["imageUrl"];
  //
  //       print("image Url : $imageUrl");
  //
  //
  //       await getProfile(context);
  //
  //       return imageUrl;
  //     }
  //   } catch (e) {
  //     debugPrint("Upload image error: $e");
  //   }
  //   return null;
  // }

  /// DATE PICKER
  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dobController.text =
      "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      notifyListeners();
    }
  }

  /// FORM FILL
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

  void updateGenderValue(String value) {
    updateGender = value;
    notifyListeners();
  }

  String _capitalizeGender(String g) {
    g = g.trim().toLowerCase();
    if (g == "male") return "Male";
    if (g == "female") return "Female";
    return "Other";
  }

  /// CLEAR ON LOGOUT
  void clear() {
    user = null;
    imageFile = null;
    notifyListeners();
  }

  /// DISPOSE CONTROLLERS
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    dobController.dispose();
    addressController.dispose();
    genderController.dispose();
    super.dispose();
  }
}
