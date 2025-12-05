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
        title: const Text("Profile"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              if (user != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditProfileScreen()),
                );
              }
              // else {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => UsersDetails()),
              //   );
              // }
            },
            icon: const Icon(Icons.edit, color: Colors.white),
          ),
        ],
      ),

      backgroundColor: Colors.white,

      body: user == null
          ? const Center(child: Text("No user data found"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Profile Image
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.teal.shade100,
                      backgroundImage:
                          user.picture != null &&
                              user.picture.toString().isNotEmpty
                          ? NetworkImage(user.picture ?? '')
                          : null,
                      child: user.picture == null
                          ? const Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Profile Card
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          profileField("Full Name", user.name),
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
