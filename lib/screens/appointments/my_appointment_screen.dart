import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/providers/appointment_provider/book_appointment_provider.dart';
import 'package:lifeline_healthcare_app/providers/doctor_provider/doctor_provider.dart';
import 'package:lifeline_healthcare_app/widgets/animated_loader.dart';
import 'package:provider/provider.dart';
import '../../../config/color.dart';

class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({super.key});

  @override
  State<MyAppointmentScreen> createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookAppointmentProvider>().getBookAppointmentAll(context);
      context.read<DoctorProvider>().getAllDoctors();
    });
  }

  String _formatDate(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return "";
    final date = DateTime.parse(isoDate);
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer2<BookAppointmentProvider, DoctorProvider>(
      builder: (context, appointmentProvider, doctorProvider, child) {
        // Loading state
        if (appointmentProvider.isLoading || doctorProvider.isLoading) {
          return const Scaffold(body: Center(child: MedicalCrossLoader()));
        }

        // Empty list state
        if (appointmentProvider.bookAppointment.isEmpty) {
          return Scaffold(
            body: Center(
              child: Text(
                "No Appointments Found",
                style: TextStyle(fontSize: 18, color: AppColors.lightGreyText),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primary,
            title: Text('My Appointments'),
          ),
          backgroundColor:
              isDark ? AppColors.backgroundDark : AppColors.background,
          body: ListView.builder(
            itemCount: appointmentProvider.bookAppointment.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final data = appointmentProvider.bookAppointment[index];

              // Doctor info from provider
              final doctor =
                  doctorProvider.getDoctorById(data.doctorId) ?? null;
              final doctorImage =
                  doctor?.image ??
                  "https://i.pravatar.cc/150?img=47"; // fallback image
              final doctorName = doctor?.name ?? data.drName ?? "Doctor";
              final doctorSpeciality = doctor?.speciality ?? "Speciality";
              final doctorHospital = doctor?.hospital ?? "";

              final isCancelled =
                  (data.status?.toLowerCase() == 'cancelled') ||
                  (data.cancelReason?.isNotEmpty ?? false);

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _glassCard(
                  isDark,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Doctor image
                      CircleAvatar(
                        radius: 36,
                        backgroundImage: NetworkImage(doctorImage),
                      ),
                      const SizedBox(width: 14),

                      // Appointment info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _titleText(doctorName),
                            const SizedBox(height: 4),
                            _subText(doctorSpeciality),
                            _subText(doctorHospital),
                            const SizedBox(height: 8),

                            _statusBadge(
                              isCancelled
                                  ? "Cancelled"
                                  : data.paymentStatus == "Pending"
                                  ? "Booked"
                                  : "Confirmed",
                              isCancelled,
                            ),

                            const SizedBox(height: 12),
                            _iconRow(
                              Icons.calendar_month,
                              _formatDate(data.slotDate),
                            ),
                            _iconRow(
                              Icons.access_time,
                              "${data.startTime ?? ""} – ${data.endTime ?? ""}",
                            ),
                            _iconRow(Icons.timer, "15 Minutes"),

                            // Cancel reason
                            if (isCancelled &&
                                data.cancelReason!.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              _subText("Reason: ${data.cancelReason}"),
                            ],

                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor:
                                          isCancelled
                                              ? Colors.grey
                                              : AppColors.primary,
                                      minimumSize: const Size(
                                        double.infinity,
                                        44,
                                      ),
                                    ),
                                    onPressed:
                                        isCancelled
                                            ? null
                                            : () {
                                              // TODO: Join video call
                                            },
                                    child: const Text("Join"),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor:
                                          isCancelled
                                              ? Colors.grey
                                              : Colors.red,
                                      side: BorderSide(
                                        color:
                                            isCancelled
                                                ? Colors.grey
                                                : Colors.red,
                                      ),
                                      minimumSize: const Size(
                                        double.infinity,
                                        44,
                                      ),
                                    ),
                                    onPressed:
                                        isCancelled
                                            ? null
                                            : () {
                                              _showCancelDialog(
                                                context: context,
                                                appointmentId: data.id!,
                                              );
                                            },
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
              );
            },
          ),
        );
      },
    );
  }

  Widget _statusBadge(String text, bool cancelled) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: cancelled ? Colors.red.shade100 : Colors.green.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: cancelled ? Colors.red : Colors.green,
        ),
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
              BoxShadow(blurRadius: 12, color: Colors.black.withOpacity(0.12)),
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

  void _showCancelDialog({
    required BuildContext context,
    required int appointmentId,
  }) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Cancel Appointment"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Please tell us the reason for cancellation",
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: reasonController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Enter cancel reason",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Close"),
            ),
            TextButton(
              onPressed: () async {
                final reason = {"cancel_reason": reasonController.text};

                if (reason.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter cancel reason"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                Navigator.pop(ctx);

                final provider = context.read<BookAppointmentProvider>();

                final result = await provider.cancelAppointment(
                  context: context,
                  appointmentId: appointmentId,
                  cancelReason: reason,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(result["message"]),
                    backgroundColor:
                        result["success"] ? Colors.green : Colors.red,
                  ),
                );
              },
              child: Text(
                "Confirm Cancel",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
