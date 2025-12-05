import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline_healthcare_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'edit_profile_screen.dart';
import 'notification_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Settings'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back, color: Colors.black87, size: 23),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          ListTile(
            leading: Icon(Icons.notifications, size: 21),
            title: Text('Notification', style: TextStyle(fontSize: 18)),
            trailing: Icon(Icons.navigate_next_rounded),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotifactionScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.light_mode, size: 21),
            title: Text('Theme Mode', style: TextStyle(fontSize: 18)),
            trailing: Icon(Icons.navigate_next_rounded),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person, size: 21),
            title: Text('Edit profile', style: TextStyle(fontSize: 18)),
            trailing: Icon(Icons.navigate_next_rounded),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.newspaper, size: 21),
            title: Text('Terms & policy', style: TextStyle(fontSize: 18)),
            trailing: Icon(Icons.navigate_next_rounded),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout, size: 21),
            title: Text('Logout', style: TextStyle(fontSize: 18)),
            trailing: Icon(Icons.navigate_next_rounded),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: Text(
                      'Logout alert!',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    content: Text(
                      'Are you sure you want to logout?    You will need to login again to access your account.',
                      style: GoogleFonts.poppins(),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Color(0xff00796B)),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          provider.logout(context);
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
