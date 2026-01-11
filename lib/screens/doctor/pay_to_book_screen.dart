import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifeline_healthcare_app/config/color.dart';
import 'package:provider/provider.dart';

import '../../models/doctors/doctor_model.dart';
import '../../providers/appointment_provider/book_appointment_provider.dart';

class PayToBookScreen extends StatelessWidget {
  final DoctorModel doctor;
  final String selectedDate;
  final String selectedStartTime;
  final String selectedEndTime;
  final String appointmentType;
  final int slotId;

  const PayToBookScreen({
    super.key,
    required this.doctor,
    required this.selectedDate,
    required this.selectedStartTime,
    required this.selectedEndTime,
    required this.appointmentType,
    required this.slotId,
  });

  String formatDate(String date) {
    try {
      final parsed = DateTime.parse(date);
      return DateFormat('dd MMM yyyy, EEEE').format(parsed);
    } catch (_) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text("Confirm Appointment"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _doctorCard(isDark),
            const SizedBox(height: 24),

            _sectionTitle("Appointment Details"),
            const SizedBox(height: 12),

            _infoTile(
              icon: Icons.calendar_today,
              title: "Date",
              value: formatDate(selectedDate),
              isDark: isDark,
            ),

            _infoTile(
              icon: Icons.access_time,
              title: "Time Slot",
              value: "$selectedStartTime - $selectedEndTime",
              isDark: isDark,
            ),

            _infoTile(
              icon: Icons.local_hospital,
              title: "Type",
              value: appointmentType,
              isDark: isDark,
            ),

            const Divider(height: 32),

            _infoTile(
              icon: Icons.currency_rupee,
              title: "Consultation Fee",
              value: "₹500",
              isDark: isDark,
              isBold: true,
            ),

            const Spacer(),
          ],
        ),
      ),

      bottomNavigationBar: _bottomButton(context),
    );
  }

  Widget _doctorCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              imageUrl: doctor.image ?? "",
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => const Icon(Icons.person, size: 40),
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.name ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                doctor.speciality ?? "",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String title,
    required String value,
    required bool isDark,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Consumer<BookAppointmentProvider>(
        builder: (_, provider, __) {
          return SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed:
                  provider.isLoading
                      ? null
                      : () async {
                        final result = await provider.createAppointment(
                          context: context,
                          doctorId: doctor.id!,
                          slotId: slotId,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(result["message"]),
                            backgroundColor:
                                result["success"] ? Colors.green : Colors.red,
                          ),
                        );
                      },
              child:
                  provider.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                        "Pay & Book Appointment",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
            ),
          );
        },
      ),
    );
  }
}
