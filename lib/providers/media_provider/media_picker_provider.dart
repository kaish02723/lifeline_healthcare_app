import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifeline_healthcare_app/providers/user_detail/auth_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MediaPickerProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  XFile? profileImage;        // local picked image
  String? profileImageUrl;   // server image url

  final ImagePicker picker = ImagePicker();

  /// PICK FROM GALLERY
  Future<void> pickFromGallery(BuildContext context) async {
    // ANDROID 13+ ke liye specific permission
    if (Platform.isAndroid) {
      final androidGallery = Permission.storage;

      if (await androidGallery.isDenied) {
        await androidGallery.request();
      }

      if (!await androidGallery.isGranted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Gallery permission denied")));
        return;
      }
    }

    // iOS ke liye photos permission
    if (Platform.isIOS) {
      final iosGallery = Permission.photos;

      if (await iosGallery.isDenied) {
        await iosGallery.request();
      }

      if (!await iosGallery.isGranted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Gallery permission denied")));
        return;
      }
    }

    // Finally pick the image
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage = image;
      notifyListeners();
    }
  }

  /// PICK FROM CAMERA
  Future<void> pickFromCamera(BuildContext context) async {
    final permission = Permission.camera;
    if (await permission.isDenied) {
      await permission.request();
    }
    if (await permission.isGranted) {
      final image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        profileImage = image;
        notifyListeners();
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Camera permission denied')));
    }
  }

  Future<String?> uploadImage(XFile file, BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = await authProvider.getToken();

    final url = Uri.parse(
      "https://phone-auth-with-jwt-4.onrender.com/userProfile/upload",
    );

    final request = http.MultipartRequest("POST", url);

    request.headers['Authorization'] = 'Bearer $token';

    request.files.add(
      await http.MultipartFile.fromPath("image", file.path),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);
      final data = jsonDecode(res.body);
      return data["imageUrl"];
    }

    return null;
  }

}
