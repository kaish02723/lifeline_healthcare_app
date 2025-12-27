import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/providers/appointment_provider/book_appointment_provider.dart';
import 'package:provider/provider.dart';
import '../../../config/color.dart';

class BookVideoConsultation extends StatefulWidget {
  const BookVideoConsultation({super.key});

  @override
  State<BookVideoConsultation> createState() => _BookVideoConsultationState();
}

class _BookVideoConsultationState extends State<BookVideoConsultation> {
  @override
  void initState() {
    super.initState();

    // Safe way to call provider after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookAppointmentProvider>(context, listen: false)
          .getBookAppointmentAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<BookAppointmentProvider>(
      builder: (context, provider, child) {
        //  Loading state
        if (provider.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        //  Empty list state
        if (provider.bookAppointment.isEmpty) {
          return Scaffold(
            body: Center(
              child: Text(
                "No Appointments Found",
                style: TextStyle(fontSize: 18, color: AppColors.lightGreyText),
              ),
            ),
          );
        }

        //  API data available
        final data = provider.bookAppointment[0];

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
                      backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=47"),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _titleText(data.dr_name ?? ""),
                          _subText("alex@gmail.com"),
                          _subText("+91 9545643567"),
                          const SizedBox(height: 12),
                          _iconRow(Icons.calendar_month, data.slot_date ?? ""),
                          _iconRow(Icons.access_time,
                              "${data.start_time ?? ""} – ${data.end_time ?? ""}"),
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
                                    minimumSize: const Size(double.infinity, 44),
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
                                    minimumSize: const Size(double.infinity, 44),
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
                    _infoTile(Icons.workspaces_outlined, "WORKSPACE",
                        "Consultations – New York"),
                    _divider(),
                    _infoTile(Icons.event_note_outlined, "EVENT TYPE",
                        data.status ?? ""),
                    _divider(),
                    _infoTile(Icons.person_outline, "USER ASSIGNED", "Ashton Prince"),
                    _divider(),
                    _infoTile(Icons.calendar_month_outlined, "BOOKED ON",
                        data.created_at ?? ""),
                    _divider(),
                    _infoTile(Icons.notes_outlined, "NOTES",
                        data.cancle_reason ?? "No Notes"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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
            color: isDark
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
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }

  Widget _subText(String text) {
    return Text(
      text,
      style: TextStyle(color: AppColors.lightGreyText, fontSize: 13),
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
              Text(label,
                  style: TextStyle(
                      fontSize: 12, color: AppColors.lightGreyText, letterSpacing: 0.5)),
              const SizedBox(height: 4),
              Text(value,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
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
