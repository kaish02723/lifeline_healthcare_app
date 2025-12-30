import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifeline_healthcare_app/providers/user_detail/User_profile_provider.dart';
import 'package:provider/provider.dart';

import '../../config/color.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProfileProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Edit Profile"),
        elevation: 1,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------ PROFILE IMAGE ------------------
            Center(
              child: GestureDetector(
                onTap: provider.pickImage,
                child:CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage:
                  provider.imageFile != null
                      ? FileImage(provider.imageFile!)
                      : (provider.user?.picture != null &&
                      provider.user!.picture!.isNotEmpty)
                      ? NetworkImage(provider.user!.picture!)
                      : null,
                  child: (provider.user?.picture == null || provider.user!.picture!.isEmpty)
                      ? const Icon(Icons.person, size: 40)
                      : null,
                ),

              ),
            ),

            SizedBox(height: 30),


            // ------------------ NAME ------------------
            TextField(
              controller: provider.nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            // ------------------ EMAIL ------------------
            TextField(
              controller: provider.emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            // ------------------ GENDER ------------------
            DropdownButtonFormField<String>(
              value: provider.updateGender,
              decoration: InputDecoration(
                labelText: "Gender",
                border: OutlineInputBorder(),
              ),
              items:
                  ["Male", "Female", "Other"]
                      .map((g) => DropdownMenuItem(child: Text(g), value: g))
                      .toList(),
              onChanged: (value) {
                setState(() {
                  provider.updateGender = value;
                });
              },
            ),

            SizedBox(height: 15),

            // ------------------ DOB ------------------
            TextField(
              controller: provider.dobController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Date of Birth",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_month),
              ),
              onTap: () {
                provider.selectDate(context);
              },
            ),

            SizedBox(height: 15),

            // ------------------ ADDRESS ------------------
            TextField(
              controller: provider.addressController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 25),

            // ------------------ SAVE BUTTON ------------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                  onPressed: () async {
                    await provider.updateProfile(
                      context,
                      imageFile: provider.imageFile,
                    );
                    provider.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Profile updated successfully")),
                    );
                  },
                child: Text("SAVE CHANGES"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  Widget _profileImageSection(bool isDark) {
    return Consumer<UserProfileProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Center(
          child: GestureDetector(
            onTap: value.pickImage,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: isDark ? AppColors.cardDark : AppColors.card,
                  backgroundImage:
                      value.imageFile != null ? FileImage(value.imageFile!) : null,
                  child:
                      value.imageFile == null
                          ? Icon(
                            Icons.person,
                            size: 60,
                            color: isDark ? AppColors.iconDark : AppColors.icon,
                          )
                          : null,
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _formCard(BuildContext context, {required List<Widget> children}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.06)),
        ],
      ),
      child: Column(
        children:
            children
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: e,
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _genderDropdown(UserProfileProvider provider) {
    return DropdownButtonFormField<String>(
      value: provider.updateGender,
      decoration: InputDecoration(
        labelText: "Gender",
        prefixIcon: const Icon(Icons.wc_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items:
          [
            "Male",
            "Female",
            "Other",
          ].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
      onChanged: (value) {
        provider.updateGenderValue(value!);
      },
    );
  }

  Widget _dobField(UserProfileProvider provider,BuildContext context) {
    return TextField(
      controller: provider.dobController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Date of Birth",
        prefixIcon: const Icon(Icons.calendar_month_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onTap: () => provider.selectDate(context),
    );
  }