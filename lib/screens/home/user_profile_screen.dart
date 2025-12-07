import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/screens/auth/complete_profile_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/user_detail/get_userdetail_provider.dart';
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
      Provider.of<GetUserDetailProvider>(
        context,
        listen: false,
      ).getUserDetail(context);
      isCalled = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GetUserDetailProvider>(context);
    var user = provider.user; // Provider se user data

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              if (user != null) {
                final provider = Provider.of<GetUserDetailProvider>(
                  context,
                  listen: false,
                );

                provider.fillUserData();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditProfileScreen()),
                );
              }
            },
            icon: const Icon(Icons.edit, color: Colors.white),
          ),
        ],
      ),

      backgroundColor: Colors.white,

      body: user == null
          ? const Center(child: CircularProgressIndicator(color: Colors.teal))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.teal.shade100,
                      child: user.picture != null && user.picture!.isNotEmpty
                          ? ClipOval(
                              child: Image.network(
                                user.picture!,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  // Agar image load na ho → default icon
                                  return const Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.grey,
                                  );
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.teal,
                                        ),
                                      );
                                    },
                              ),
                            )
                          : const Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.grey,
                            ),
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    user.name.toString() ?? "Not set",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Profile Card
                  Card(
                    color: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          profileField("Email", user.email),
                          profileField("Gender", user.gender),
                          profileField("Date of Birth", user.dateOfBirth ?? ''),
                          profileField("Address", user.address),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget profileField(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            value?.toString() ?? "Not set",
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          Divider(color: Colors.grey.shade300),
        ],
      ),
    );
  }
}
