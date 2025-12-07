import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline_healthcare_app/config/app_theme.dart';
import 'package:lifeline_healthcare_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

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
              color: notificationOn
                  ? Theme.of(context).primaryColor
                  : Colors.grey.shade700,
            ),
            title: const Text("Notifications", style: TextStyle(fontSize: 18)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  notificationOn ? "ON" : "OFF",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: notificationOn
                        ? Theme.of(context).primaryColor
                        : Colors.black54,
                  ),
                ),
                Switch(
                  value: notificationOn,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (value) {
                    setState(() => notificationOn = value);
                  },
                ),
              ],
            ),
          ),

          Consumer<ThemeProvider>(
            builder: (BuildContext context, provider, Widget? child) {
              return ListTile(
                leading: Icon(
                  provider.isDark ? Icons.dark_mode : Icons.sunny,
                  color: provider.isDark
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade700,
                ),
                title: const Text("Theme Mode", style: TextStyle(fontSize: 18)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      provider.isDark ? "Dark" : "Light",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: provider.isDark
                            ? Theme.of(context).primaryColor
                            : Colors.black54,
                      ),
                    ),
                    Switch(
                      value: provider.isDark,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (val) {
                        provider.toggleTheme(); // <-- THEME SWITCH HERE
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

          // 👤 Edit Profile
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Edit Profile", style: TextStyle(fontSize: 18)),
            trailing: const Icon(Icons.navigate_next_rounded),
            onTap: () {
              Navigator.pushNamed(context, "/edit-profile");
            },
          ),

          // 📄 Terms
          ListTile(
            leading: const Icon(Icons.newspaper),
            title: const Text("Terms & Policy", style: TextStyle(fontSize: 18)),
            trailing: const Icon(Icons.navigate_next_rounded),
            onTap: () {},
          ),

          // 🌐 Language
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language", style: TextStyle(fontSize: 18)),
            trailing: const Icon(Icons.navigate_next_rounded),
            onTap: () {},
          ),

          // 🚪 Logout
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout", style: TextStyle(fontSize: 18)),
            trailing: const Icon(Icons.navigate_next_rounded),

            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(
                    "Logout alert!",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
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
