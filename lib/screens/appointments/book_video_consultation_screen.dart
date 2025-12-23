import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../config/color.dart';

class BookVideoConsultation extends StatelessWidget {
  const BookVideoConsultation({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
      isDark ? AppColors.backgroundDark : AppColors.background,
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
                  backgroundImage:
                  NetworkImage("https://i.pravatar.cc/150?img=47"),
                ),
                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _titleText("Alexa"),
                      _subText("alex@gmail.com"),
                      _subText("+91 9545643567"),

                      const SizedBox(height: 12),

                      _iconRow(Icons.calendar_month, "24 Nov 2026"),
                      _iconRow(Icons.access_time, "10:30 AM – 11:00 AM"),
                      _iconRow(Icons.timer, "45 Minutes"),

                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize:
                                const Size(double.infinity, 44),
                              ),
                              onPressed: () {},
                              child: const Text("Join"),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                                side: const BorderSide(color: Colors.red),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize:
                                const Size(double.infinity, 44),
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
                  Icons.workspaces_outlined,
                  "WORKSPACE",
                  "Consultations – New York",
                ),
                _divider(),
                _infoTile(
                  Icons.event_note_outlined,
                  "EVENT TYPE",
                  "Tax Planning",
                ),
                _divider(),
                _infoTile(
                  Icons.person_outline,
                  "USER ASSIGNED",
                  "Ashton Prince",
                ),
                _divider(),
                _infoTile(
                  Icons.calendar_month_outlined,
                  "BOOKED ON",
                  "24 Nov 2026, 04:00 PM",
                ),
                _divider(),
                _infoTile(
                  Icons.notes_outlined,
                  "NOTES",
                  "Booked appointment over call",
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
                ? AppColors.cardDark.withOpacity(0.7)
                : AppColors.card.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                color: Colors.black.withOpacity(0.12),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _titleText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _subText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.lightGreyText,
        fontSize: 13,
      ),
    );
  }

  Widget _iconRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.secondary),
          const SizedBox(width: 6),
          Text(text),
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
                  letterSpacing: 0.5,
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
