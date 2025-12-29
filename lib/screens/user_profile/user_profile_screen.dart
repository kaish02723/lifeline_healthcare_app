import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_detail/User_profile_provider.dart';
import 'dart:ui';
import '../../config/color.dart';
import 'edit_profile_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isCalled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isCalled) {
      // to avoid calling multiple times
      Provider.of<UserProfileProvider>(
        context,
        listen: false,
      ).getProfile(context);
      isCalled = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProfileProvider>(context);
    var user = provider.user; // Provider se user data
    print("PROFILE IMAGE URL : ${user?.picture}");

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,

      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: isDark ? AppColors.primaryDark : AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              if (user != null) {
                final provider = Provider.of<UserProfileProvider>(
                  context,
                  listen: false,
                );

                provider.fillFormData();

                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                );

                // 🔥 YAHI MAIN FIX HAI
                if (result == true) {
                  await provider.getProfile(context);
                }
              }
            },
            icon: const Icon(Icons.edit, color: Colors.white),
          ),
        ],
      ),

      body:
          user == null
              ? const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              )
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.teal.shade100,
                          backgroundImage:
                          (user.picture != null && user.picture!.isNotEmpty)
                              ? NetworkImage(user.picture!)
                              : null,
                          child: (user.picture == null || user.picture!.isEmpty)
                              ? const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey,
                          )
                              : null,
                        ),
                      ),

                    ),

                    SizedBox(height: 10),

                    Text(
                      user.name ?? "Not set",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 20),
                    // _profileHeader(context, user),
                    const SizedBox(height: 20),

                    _infoCard(
                      context,
                      title: "Personal Information",
                      children: [
                        _infoRow(Icons.email_outlined, "Email", user.email),
                        _infoRow(Icons.person_outline, "Gender", user.gender),
                        _infoRow(
                          Icons.cake_outlined,
                          "Date of Birth",
                          user.dateOfBirth,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    _infoCard(
                      context,
                      title: "Address",
                      children: [
                        _infoRow(
                          Icons.location_on_outlined,
                          "Home Address",
                          user.address,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
    );
  }

  // Widget _profileHeader(BuildContext context, user) {
  //   final isDark = Theme.of(context).brightness == Brightness.dark;
  //
  //   return BackdropFilter(
  //     filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
  //     child: SizedBox(
  //       child: Column(
  //         children: [
  //           CircleAvatar(
  //             radius: 55,
  //             backgroundColor: AppColors.primary.withOpacity(0.15),
  //             backgroundImage:
  //                 (user.picture != null && user.picture!.isNotEmpty)
  //                     ? CachedNetworkImageProvider(
  //                       user.picture!.startsWith("http")
  //                           ? user.picture!
  //                           : "https://phone-auth-with-jwt-4.onrender.com${user.picture!}",
  //                     )
  //                     : null,
  //             child:
  //                 (user.picture == null || user.picture!.isEmpty)
  //                     ? Icon(
  //                       Icons.person,
  //                       size: 60,
  //                       color: isDark ? AppColors.iconDark : AppColors.icon,
  //                     )
  //                     : null,
  //           ),
  //           const SizedBox(height: 12),
  //           Text(
  //             user.name ?? "Not set",
  //             style: TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //               color: isDark ? AppColors.textDark : AppColors.text,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _infoCard(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textDark : AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.secondary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.lightGreyText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value?.toString() ?? "Not set",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
