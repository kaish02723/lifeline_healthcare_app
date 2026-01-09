import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/color.dart';
import '../../providers/user_detail/User_profile_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProfileProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,

      appBar: AppBar(
        backgroundColor: isDark ? AppColors.primaryDark : AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text("Edit Profile"),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            ///  PROFILE IMAGE WITH HERO ANIMATION
            GestureDetector(
              onTap: () {
                // Image expand screen pe navigate karo
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _ImageExpandScreen(
                      imageFile: provider.imageFile,
                      imageUrl: provider.user?.picture,
                      onPickImage: provider.pickImage,
                    ),
                  ),
                );
              },
              child: Hero(
                tag: 'profile_image',
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 58,
                      backgroundColor:
                      isDark ? AppColors.cardDark : AppColors.card,
                      backgroundImage:
                      provider.imageFile != null
                          ? FileImage(provider.imageFile!)
                          : (provider.user?.picture != null &&
                          provider.user!.picture!.isNotEmpty)
                          ? NetworkImage(provider.user!.picture!)
                      as ImageProvider
                          : null,
                      child: provider.imageFile == null &&
                          (provider.user?.picture == null ||
                              provider.user!.picture!.isEmpty)
                          ? Icon(
                        Icons.person,
                        size: 48,
                        color: isDark
                            ? AppColors.iconDark
                            : AppColors.icon,
                      )
                          : null,
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
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
            ),

            const SizedBox(height: 30),

            ///  FORM CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : AppColors.card,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.06),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _inputField(
                    controller: provider.nameController,
                    label: "Name",
                    icon: Icons.person_outline,
                  ),

                  _inputField(
                    controller: provider.emailController,
                    label: "Email",
                    icon: Icons.email_outlined,
                  ),

                  DropdownButtonFormField<String>(
                    value: provider.updateGender,
                    decoration: InputDecoration(
                      labelText: "Gender",
                      prefixIcon: const Icon(Icons.wc_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items:
                        ["Male", "Female", "Other"]
                            .map(
                              (g) => DropdownMenuItem(value: g, child: Text(g)),
                            )
                            .toList(),
                    onChanged: (value) {
                      provider.updateGender = value;
                    },
                  ),

                  const SizedBox(height: 14),

                  TextField(
                    controller: provider.dobController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Date of Birth",
                      prefixIcon: const Icon(Icons.calendar_month_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onTap: () => provider.selectDate(context),
                  ),

                  const SizedBox(height: 14),

                  _inputField(
                    controller: provider.addressController,
                    label: "Address",
                    icon: Icons.location_on_outlined,
                    maxLines: 2,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            ///  SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDark ? AppColors.primaryDark : AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed:
                    provider.isLoading
                        ? null
                        : () async {
                          await provider.updateProfile(
                            context,
                            imageFile: provider.imageFile,
                          );

                          provider.clear();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Profile updated successfully"),
                            ),
                          );
                        },
                child:
                    provider.isLoading
                        ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                        : const Text(
                          "SAVE CHANGES",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///  INPUT FIELD WIDGET
  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

/// IMAGE EXPAND SCREEN (Separate widget for expanded view)
class _ImageExpandScreen extends StatelessWidget {
  final File? imageFile;
  final String? imageUrl;
  final VoidCallback onPickImage;

  const _ImageExpandScreen({
    required this.imageFile,
    required this.imageUrl,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {
              onPickImage();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Hero(
          tag: 'profile_image',
          child: Container(
            width: double.infinity,
            height: 400,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isDark ? AppColors.cardDark : AppColors.card,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: imageFile != null
                  ? Image.file(
                imageFile!,
                fit: BoxFit.cover,
              )
                  : (imageUrl != null && imageUrl!.isNotEmpty)
                  ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
              )
                  : Icon(
                Icons.person,
                size: 120,
                color: isDark ? AppColors.iconDark : AppColors.icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}