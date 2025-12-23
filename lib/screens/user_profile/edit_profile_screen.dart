import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifeline_healthcare_app/providers/user_detail/User_profile_provider.dart';
import 'package:provider/provider.dart';

import '../../config/color.dart';
import '../../providers/user_detail/get_userdetail_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? imageFile;

  Future pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

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
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage:
                  imageFile != null
                      ? FileImage(imageFile!)
                      : provider.user?.picture != null
                      ? NetworkImage(provider.user!.picture!)
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
                  // 🔍 DEBUG LOGS (YAHI LAGANA HAI)
                  print("SAVE CLICKED");
                  print("NAME: ${provider.nameController.text}");
                  print("EMAIL: ${provider.emailController.text}");
                  // upload image first (if selected)
                  if (imageFile != null) {
                    await provider.uploadProfileImage(imageFile!, context);
                  }
                  //  update profile (WITHOUT picture)
                  Map<String, dynamic> data = {
                    "name": provider.nameController.text,
                    "email": provider.emailController.text,
                    "gender": provider.updateGender,
                    "date_of_birth": provider.dobController.text,
                    "address": provider.addressController.text,
                  };
                  await provider.updateProfile(context, data);
                  //  go back
                  Navigator.pop(context);
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


// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});
//
//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }
//
// class _EditProfileScreenState extends State<EditProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<GetUserDetailProvider>();
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Scaffold(
//       backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
//
//       appBar: AppBar(
//         title: const Text("Edit Profile"),
//         elevation: 0,
//         backgroundColor: isDark ? AppColors.primaryDark : AppColors.primary,
//         foregroundColor: Colors.white,
//       ),
//
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _profileImageSection(isDark),
//
//             const SizedBox(height: 24),
//
//             _formCard(
//               context,
//               children: [
//                 _inputField(
//                   controller: provider.updateNameController,
//                   label: "Name",
//                   icon: Icons.person_outline,
//                 ),
//
//                 _inputField(
//                   controller: provider.updateEmailController,
//                   label: "Email",
//                   icon: Icons.email_outlined,
//                 ),
//
//                 _genderDropdown(provider),
//
//                 _dobField(provider),
//
//                 _inputField(
//                   controller: provider.updateAddressController,
//                   label: "Address",
//                   icon: Icons.location_on_outlined,
//                   maxLines: 2,
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 24),
//
//             SizedBox(
//               width: double.infinity,
//               height: 48,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:
//                       isDark ? AppColors.secondaryDark : AppColors.primary,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(7),
//                   ),
//                 ),
//                 onPressed: () async {
//                   String? imageUrl;
//
//                   if (provider.imageFile != null) {
//                     imageUrl = await provider.uploadProfileImage(
//                       provider.imageFile!,
//                       context,
//                     );
//                   }
//
//                   final data = {
//                     "name": provider.updateNameController.text,
//                     "email": provider.updateEmailController.text,
//                     "gender": provider.updateGender,
//                     "date_of_birth": provider.updateDobController.text,
//                     "address": provider.updateAddressController.text,
//                   };
//
//                   if (imageUrl != null && imageUrl.isNotEmpty) {
//                     data["picture"] = imageUrl;
//                   }
//
//                   provider.updateUserProfile(context, data);
//                 },
//                 child: const Text(
//                   "SAVE CHANGES",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

  Widget _profileImageSection(bool isDark) {
    return Consumer<GetUserDetailProvider>(
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

  Widget _genderDropdown(GetUserDetailProvider provider) {
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

  Widget _dobField(GetUserDetailProvider provider,BuildContext context) {
    return TextField(
      controller: provider.updateDobController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Date of Birth",
        prefixIcon: const Icon(Icons.calendar_month_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onTap: () => provider.selectDate(context),
    );
  }