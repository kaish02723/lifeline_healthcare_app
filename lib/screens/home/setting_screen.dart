import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline_healthcare_app/config/app_theme.dart';
import 'package:lifeline_healthcare_app/providers/theme_provider/theme_provider.dart';
import 'package:lifeline_healthcare_app/screens/home/terms_and_policy_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/user_detail/User_profile_provider.dart';
import '../../providers/user_detail/auth_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool notificationOn = true;
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.back),
        ),
      ),

      body: ListView(
        children: [
          const SizedBox(height: 10),

          ListTile(
            leading: Icon(
              notificationOn ? Icons.notifications_active : Icons.notifications,
              color: notificationOn ? Color(0xff00796B) : Colors.grey.shade800,
            ),
            title: const Text("Notifications", style: TextStyle(fontSize: 18)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  notificationOn ? "ON" : "OFF",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: notificationOn ? Color(0xff00796B) : Colors.black54,
                  ),
                ),
                Switch(
                  value: notificationOn,
                  activeColor: Color(0xff00796B),
                  onChanged: (value) {
                    setState(() => notificationOn = value);
                  },
                ),
              ],
            ),
            onTap: () {
              setState(() => notificationOn = !notificationOn);
            },
          ),

          Consumer<ThemeProvider>(
            builder: (BuildContext context, provider, Widget? child) {
              return ListTile(
                leading: Icon(
                  provider.isDark ? Icons.dark_mode : Icons.sunny,
                  color:
                      provider.isDark
                          ? Color(0xff00796B)
                          : Colors.grey.shade800,
                ),
                title: const Text("Theme Mode", style: TextStyle(fontSize: 18)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      provider.isDark ? "Dark" : "Light",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color:
                            provider.isDark
                                ? Color(0xff00796B)
                                : Colors.grey.shade700,
                      ),
                    ),
                    Switch(
                      value: provider.isDark,
                      activeColor: Color(0xff00796B),
                      onChanged: (val) {
                        provider.toggleTheme();
                      },
                    ),
                  ],
                ),
                onTap: () {
                  provider.toggleTheme();
                },
              );
            },
          ),

          // ListTile(
          //   leading: const Icon(Icons.person),
          //   title: const Text("Edit Profile", style: TextStyle(fontSize: 18)),
          //   trailing: const Icon(Icons.navigate_next_rounded),
          //   onTap: () {
          //     final provider = Provider.of<UserProfileProvider>(
          //       context,
          //       listen: false,
          //     );
          //     provider.fillFormData();
          //     Navigator.pushNamed(context, "/edit-profile");
          //   },
          // ),

          ListTile(
            leading: const Icon(Icons.newspaper),
            title: const Text("Terms & Policy", style: TextStyle(fontSize: 18)),
            trailing: const Icon(Icons.navigate_next_rounded),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TermsPolicyScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language", style: TextStyle(fontSize: 18)),
            trailing: const Icon(Icons.navigate_next_rounded),
            onTap: () {},
          ),

          // ListTile(
          //   leading: const Icon(Icons.newspaper),
          //   title: const Text(
          //     "Open source licence",
          //     style: TextStyle(fontSize: 18),
          //   ),
          //   trailing: const Icon(Icons.navigate_next_rounded),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => TermsPolicyScreen()),
          //     );
          //   },
          // ),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout", style: TextStyle(fontSize: 18)),
            trailing: const Icon(Icons.navigate_next_rounded),

            onTap: () {
              showDialog(
                context: context,
                builder:
                    (_) => AlertDialog(
                      title: Text(
                        "Logout alert!",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      content: Text(
                        "Are you sure you want to logout?\n\nYou will need to login again to access your account.",
                        style: GoogleFonts.poppins(),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Color(0xff00796B)),
                          ),
                        ),
                        TextButton(
                          onPressed: () => provider.logout(context),
                          child: Text(
                            "Logout",
                            style: TextStyle(color: Colors.red.shade700),
                          ),
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}
