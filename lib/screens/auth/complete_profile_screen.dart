import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifeline_healthcare_app/providers/auth_provider.dart';
import 'package:lifeline_healthcare_app/providers/user_detail_provider.dart';
import 'package:lifeline_healthcare_app/screens/home/dashboard_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class UsersDetails extends StatefulWidget {
  const UsersDetails({super.key});

  @override
  State<UsersDetails> createState() => _UsersDetailsState();
}

class _UsersDetailsState extends State<UsersDetails> {
  final _formKey = GlobalKey<FormState>();

  XFile? profileImage;

  final ImagePicker picker = ImagePicker();

  /// PICK FROM GALLERY
  Future<void> pickFromGallery() async {
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
      setState(() {
        profileImage = image;
      });
    }
  }

  /// PICK FROM CAMERA
  Future<void> pickFromCamera() async {
    final permission = Permission.camera;
    if (await permission.isDenied) {
      await permission.request();
    }
    if (await permission.isGranted) {
      final image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        setState(() {
          profileImage = image;
        });
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Camera permission denied')));
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserDetailProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.teal,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text('Your Details'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              );
            },
            child: Text(
              "Skip",
              style: TextStyle(
                fontSize: 15,
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.3),
          child: Container(height: 0.3, color: Colors.grey.shade400),
        ),
      ),

      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.teal, width: 0.5),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade100,
                      backgroundImage: profileImage != null
                          ? FileImage(File(profileImage!.path))
                          : null,
                      child: profileImage == null
                          ? Icon(
                              Icons.person,
                              size: 70,
                              color: Colors.grey.shade400,
                            )
                          : null,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(22),
                                    topRight: Radius.circular(22),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 10),
                                    Container(
                                      width: 45,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    const SizedBox(height: 20),

                                    const Text(
                                      "Upload Profile Photo",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                    const SizedBox(height: 25),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundColor:
                                                  Colors.grey.shade200,
                                              child: IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  pickFromCamera();
                                                },
                                                icon: const Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.teal,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            const Text("Camera"),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundColor:
                                                  Colors.grey.shade200,
                                              child: IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  pickFromGallery();
                                                },
                                                icon: const Icon(
                                                  Icons.image,
                                                  color: Colors.teal,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            const Text("Gallery"),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 25),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            /// FORM
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildInputField(
                    controller: provider.nameController,
                    label: "Full Name",
                    hint: "Enter your full name",
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 18),

                  _buildInputField(
                    controller: provider.emailController,
                    label: "Email Address",
                    hint: "example@gmail.com",
                    icon: Icons.email_outlined,
                    keyboard: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 18),

                  _buildInputField(
                    controller: provider.genderController,
                    label: "Gender",
                    hint: "Male / Female / Other",
                    icon: Icons.wc,
                  ),
                  const SizedBox(height: 18),

                  // Date Picker
                  TextFormField(
                    controller: provider.dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Date of Birth",
                      hintText: "dd/mm/yyyy",
                      prefixIcon: const Icon(
                        Icons.calendar_month,
                        color: Colors.teal,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.edit_calendar,
                          color: Colors.teal,
                        ),
                        onPressed: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            provider.dateController.text =
                                "${picked.day}/${picked.month}/${picked.year}";
                          }
                        },
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1.3,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.teal,
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  // Submit Button
                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Additional DOB validation
                          if (provider.dateController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Please select your Date of Birth",
                                ),
                              ),
                            );
                            return;
                          }

                          // All Valid → Submit Data
                          var data = {
                            "name": provider.nameController.text.trim(),
                            "email": provider.emailController.text.trim(),
                            "gender": provider.genderController.text.trim(),
                            "date_of_birth": provider.dateController.text
                                .trim(),
                            "address": "anywhere",
                            "picture": profileImage?.path,
                          };

                          String? userId = authProvider.userId;
                          provider.addUserDetails(userId!, data, context);
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// REUSABLE INPUT FIELD
  Widget _buildInputField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "$label is required";
        }

        if (label == "Full Name") {
          if (value.trim().length < 3) {
            return "Name must be at least 3 characters";
          }
        }

        if (label == "Email Address") {
          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

          if (!emailRegex.hasMatch(value.trim())) {
            return "Enter a valid email";
          }
        }

        if (label == "Gender") {
          final allowedGender = ["male", "female", "other"];
          if (!allowedGender.contains(value.trim().toLowerCase())) {
            return "Enter Male, Female or Other";
          }
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.teal),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.teal, width: 2),
        ),
      ),
    );
  }
}
