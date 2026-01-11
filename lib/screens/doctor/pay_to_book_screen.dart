import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/config/color.dart';
import 'package:lifeline_healthcare_app/config/test_styles.dart';
import 'package:provider/provider.dart';

import '../../models/doctors/doctor_model.dart';
import '../../providers/appointment_provider/book_appointment_provider.dart';

class PayToBookScreen extends StatefulWidget {
  final DoctorModel doctor;
  final selectedStartTime;
  final selectedEndTime;
  final selectedDate;
  final appointmentType;

  const PayToBookScreen({
    super.key,
    required this.doctor,
    required this.appointmentType,
    required this.selectedDate,
    required this.selectedEndTime,
    required this.selectedStartTime,
  });

  @override
  State<PayToBookScreen> createState() => _PayToBookScreenState();
}

class _PayToBookScreenState extends State<PayToBookScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor:
            isDark ? AppColors.backgroundDark : AppColors.background,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: isDark ? AppColors.primaryDark : AppColors.primary,
          title: Text("Pay To Book Appointment"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(w * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "your Selected Doctor",
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 10),
                _doctorCard(isDark, context),
                const SizedBox(height: 20),
                _sectionTitle("Selected Date", isDark),
                const SizedBox(height: 20),
                _sectionTitle("Selected Slot", isDark),
                const SizedBox(height: 20),
                _sectionTitle("Appointment Type", isDark),
                const SizedBox(height: 20),
                _sectionTitle("Payment Method", isDark),
                const SizedBox(height: 20),
                _sectionTitle("Consultation Fee", isDark),
                const SizedBox(height: 20),
                _bookButton(isDark, widget.doctor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// card
Widget _doctorCard(bool isDark, dynamic widget) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: isDark ? AppColors.cardDark : AppColors.card,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: Colors.grey.shade200,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: widget.doctor.image ?? "",
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              placeholder:
                  (context, url) => Center(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
              errorWidget:
                  (context, url, error) =>
                      Icon(Icons.person, size: 32, color: Colors.grey),
            ),
          ),
        ),

        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doctor.name ?? "",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textDark : AppColors.text,
              ),
            ),
            Text(
              widget.doctor.speciality ?? "",
              style: TextStyle(
                color:
                    isDark
                        ? AppColors.lightGreyTextDark
                        : AppColors.lightGreyText,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _sectionTitle(String title, bool isDark) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: isDark ? AppColors.textDark : AppColors.text,
      ),
    ),
  );
}

Widget _bookButton(bool isDark, dynamic widget) {
  return Consumer<BookAppointmentProvider>(
    builder: (context, provider, _) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.all(16),
          ),
          onPressed:
              provider.isLoading
                  ? null
                  : () async {
                    final result = await provider.createAppointment(
                      context: context,
                      doctorId: widget.doctor.id!,
                      slotId: widget.selectedSlotId,
                      slotDate: widget.selectedDate,
                      startTime: widget.selectedStartTime,
                      endTime: widget.selectedEndTime,
                      type: widget.appointmentType,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        showCloseIcon: true,
                        closeIconColor: Colors.white,
                        content: Text(result["message"]),
                        backgroundColor:
                            result["success"]
                                ? Colors.green.shade800
                                : Colors.red.shade800,
                      ),
                    );
                  },
          child:
              provider.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                    "Pay And Book",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
        ),
      );
    },
  );
}
