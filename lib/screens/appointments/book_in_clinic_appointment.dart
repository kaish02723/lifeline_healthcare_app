import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../config/color.dart';

class InClinicBookedAppointment extends StatelessWidget {
  const InClinicBookedAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _glassCard(
            isDark,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 36,
                  backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1659353888906-adb3e0041693?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZmVtYWxlJTIwZG9jdG9yfGVufDB8fDB8fHww",
                  ),
                ),
                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title("Dr. Angel"),
                      _sub("MBBS, General Physician"),
                      _sub("📞 +91 95456 43567"),

                      const SizedBox(height: 10),

                      _iconRow(Icons.calendar_month, "24 Nov 2026"),
                      _iconRow(Icons.access_time, "10:30 AM – 11:00 AM"),
                      _iconRow(Icons.location_on, "Care Plus Clinic, Delhi"),

                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.navigation),
                              label: const Text("Navigate"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 44),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                                side: const BorderSide(color: Colors.red),
                                minimumSize: const Size(double.infinity, 44),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text("Cancel"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          _glassCard(
            isDark,
            child: Column(
              children: [
                _infoTile(
                  Icons.local_hospital_outlined,
                  "CLINIC",
                  "Care Plus Multispeciality Clinic",
                ),
                _divider(),
                _infoTile(
                  Icons.workspaces_outline,
                  "DEPARTMENT",
                  "General Medicine",
                ),
                _divider(),
                _infoTile(Icons.person_outline, "PATIENT NAME", "MD Jahir"),
                _divider(),
                _infoTile(
                  Icons.event_available_outlined,
                  "BOOKED ON",
                  "20 Nov 2026, 04:00 PM",
                ),
                _divider(),
                _infoTile(
                  Icons.notes_outlined,
                  "NOTES",
                  "Please arrive 10 minutes early",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _glassCard(bool isDark, {required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                isDark
                    ? AppColors.cardDark.withOpacity(0.75)
                    : AppColors.card.withOpacity(0.95),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(blurRadius: 12, color: Colors.black.withOpacity(0.12)),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }

  Widget _sub(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 13, color: AppColors.lightGreyText),
    );
  }

  Widget _iconRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.secondary),
          const SizedBox(width: 6),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22, color: AppColors.secondary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.lightGreyText,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 14),
      child: Divider(height: 1),
    );
  }
}
