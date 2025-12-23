import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/providers/user_detail/auth_provider.dart';
import 'package:lifeline_healthcare_app/providers/media_provider/media_picker_provider.dart';
import 'package:lifeline_healthcare_app/screens/home/dashboard_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/user_detail/User_profile_provider.dart';

class UsersDetails extends StatefulWidget {
  const UsersDetails({super.key});

  @override
  State<UsersDetails> createState() => _UsersDetailsState();
}

class _UsersDetailsState extends State<UsersDetails> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProfileProvider>(context, listen: false);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var mediaProvider = Provider.of<MediaPickerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.teal,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text('Complete your profile'),
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
                      radius: 70,
                      backgroundColor: Colors.grey.shade100,
                      backgroundImage:
                          mediaProvider.profileImage != null
                              ? FileImage(
                                File(mediaProvider.profileImage!.path),
                              ) // LOCAL PREVIEW
                              : mediaProvider.profileImageUrl != null
                              ? CachedNetworkImageProvider(
                                mediaProvider.profileImageUrl!,
                              ) // SERVER IMAGE
                              : null,
                      child:
                          mediaProvider.profileImage == null &&
                                  mediaProvider.profileImageUrl == null
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
                                                  mediaProvider.pickFromCamera(
                                                    context,
                                                  );
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
                                                  mediaProvider.pickFromGallery(
                                                    context,
                                                  );
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
              key: mediaProvider.formKey,
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
                    icon: Icons.male,
                  ),
                  const SizedBox(height: 18),
                  // Date Picker
                  TextFormField(
                    controller: provider.dobController,
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
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            provider.dobController.text =
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
                      onPressed: () async {
                        if (mediaProvider.formKey.currentState!.validate()) {
                          if (provider.dobController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please select your Date of Birth",
                                ),
                              ),
                            );
                            return;
                          }

                          String? imageUrl;
                          if (mediaProvider.profileImage != null) {
                            imageUrl = await mediaProvider.uploadImage(
                              mediaProvider.profileImage!,
                              context,
                            );
                          }
                          if (imageUrl != null) {
                                mediaProvider.profileImageUrl = imageUrl;
                                 mediaProvider.notifyListeners();
                          }

                          var data = {
                            "name": provider.nameController.text.trim(),
                            "email": provider.emailController.text.trim(),
                            "gender": provider.genderController.text.trim(),
                            "date_of_birth":
                                provider.dobController.text.trim(),
                            "address": "anywhere",
                            "picture": imageUrl,
                          };

                          String? userId = authProvider.userId;
                          provider.createProfile(context, data);
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

        if (label == "Full Name" && value.trim().length < 3) {
          return "Name must be at least 3 characters";
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
          borderSide: BorderSide(color: Colors.teal, width: 0.5),
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
