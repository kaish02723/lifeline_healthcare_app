import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline_healthcare_app/providers/labtest_provider/book_test_provider.dart';
import 'package:lifeline_healthcare_app/screens/labtest/patient_lab_test_screen.dart';
import 'package:lifeline_healthcare_app/providers/labtest_provider/cancel_test_provider.dart';
import 'package:lifeline_healthcare_app/widgets/animated_loader.dart';
import 'package:provider/provider.dart';

import '../../config/color.dart';
import '../../widgets/my_labtest_card.dart';

class MyTestScreen extends StatefulWidget {
  const MyTestScreen({super.key});

  @override
  State<MyTestScreen> createState() => _MyTestScreenState();
}

class _MyTestScreenState extends State<MyTestScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<BookTestProvider>(context, listen: false)
          .getTestStatus(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
      isDark ? AppColors.backgroundDark : AppColors.background,

      appBar: AppBar(
        backgroundColor:
        isDark ? AppColors.primaryDark : AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text("My Lab Tests"),
        leading: BackButton(color: Colors.white),
      ),

      body: Consumer<BookTestProvider>(
        builder: (context, value, _) {
          if (value.isLoading) {
            return const Center(child: MedicalCrossLoader());
          }

          if (value.myLabTestList.isEmpty) {
            return Center(
              child: Text(
                "No lab tests booked yet",
                style: TextStyle(
                  color: isDark
                      ? AppColors.lightGreyTextDark
                      : AppColors.greyText,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(w * 0.04),
            itemCount: value.myLabTestList.length,
            itemBuilder: (context, index) {
              final data = value.myLabTestList[index];

              return Consumer<CancelTestProvider>(
                builder: (context, cancelProvider, _) {
                  return _ModernLabTestCard(
                    isDark: isDark,
                    userName: data.user_name.toString(),
                    testName: data.test_name.toString(),
                    category: data.category.toString(),
                    phone: data.phone.toString(),
                    status: data.status.toString(),
                    bookedAt: data.booking_date.toString(),
                    onCancel: () {
                      showCancelDialog(
                        context,
                        onConfirm: () {
                          cancelProvider.cancelLabTest(context, index);
                        },
                        onCancel: () {},
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor:
        isDark ? AppColors.primaryDark : AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("Book Test"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const PatientLabTestScreen(),
            ),
          );
        },
      ),
    );
  }
}

class _ModernLabTestCard extends StatelessWidget {
  final bool isDark;
  final String userName;
  final String testName;
  final String category;
  final String phone;
  final String status;
  final String bookedAt;
  final VoidCallback onCancel;

  const _ModernLabTestCard({
    required this.isDark,
    required this.userName,
    required this.testName,
    required this.category,
    required this.phone,
    required this.status,
    required this.bookedAt,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.06),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.4)
                : Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.science_outlined,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  testName,
                  style: TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                    color:
                    isDark ? AppColors.textDark : AppColors.text,
                  ),
                ),
              ),
              _StatusChip(status: status),
            ],
          ),

          const SizedBox(height: 14),

          /// Info rows
          _infoRow(Icons.person_outline, userName, isDark),
          _infoRow(Icons.category_outlined, category, isDark),
          _infoRow(Icons.phone_outlined, phone, isDark),
          _infoRow(
            Icons.schedule_outlined,
            "Booked on: ${formatBookedDate(bookedAt)}",
            isDark,
          ),


          const SizedBox(height: 10),

          /// Action
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onCancel,
              style: TextButton.styleFrom(
                foregroundColor: Colors.redAccent,
              ),
              child: const Text(
                "Cancel Test",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            icon,
            size: 17,
            color: isDark
                ? AppColors.iconDark
                : AppColors.icon,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: isDark
                    ? AppColors.lightGreyTextDark
                    : AppColors.greyText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;

    switch (status.toLowerCase()) {
      case "completed":
        color = Colors.green;
        break;
      case "cancelled":
        color = Colors.red;
        break;
      default:
        color = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}


void showCancelDialog(
  BuildContext context, {
  required VoidCallback onConfirm,
  required VoidCallback onCancel,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Consumer<CancelTestProvider>(
              builder: (BuildContext context, value, Widget? child) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color:
                        isDark
                            ? Colors.white.withOpacity(0.07)
                            : Colors.white.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color:
                          isDark
                              ? Colors.white.withOpacity(0.15)
                              : Colors.black.withOpacity(0.10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            isDark
                                ? Colors.black26
                                : Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 50,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(height: 12),

                      /// Title
                      Text(
                        "Cancel Test?",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),

                      /// Subtitle
                      Text(
                        "Please provide a reason for canceling this labtest.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color:
                              isDark
                                  ? Colors.white70
                                  : Colors.black.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 16),

                      TextField(
                        controller: value.cancelReasonController,
                        maxLines: 2,
                        style: GoogleFonts.poppins(
                          color: isDark ? Colors.white : Colors.black87,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter reason...",
                          hintStyle: GoogleFonts.poppins(
                            color: isDark ? Colors.white54 : Colors.grey[600],
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor:
                              isDark
                                  ? Colors.white.withOpacity(0.05)
                                  : Colors.grey.withOpacity(0.15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      /// Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade500,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                onCancel();
                              },
                              child: Text(
                                "No",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                onConfirm();
                              },
                              child: Text(
                                "Yes, Cancel",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
  );
}

String formatBookedDate(String isoDate) {
  try {
    final dateTime = DateTime.parse(isoDate).toLocal();

    return "${dateTime.day.toString().padLeft(2, '0')} "
        "${_monthName(dateTime.month)} "
        "${dateTime.year}, "
        "${_formatTime(dateTime)}";
  } catch (e) {
    return isoDate; // fallback (agar parsing fail ho)
  }
}

String _monthName(int month) {
  const months = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ];
  return months[month - 1];
}

String _formatTime(DateTime dateTime) {
  final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final period = dateTime.hour >= 12 ? "PM" : "AM";
  return "$hour:$minute $period";
}
