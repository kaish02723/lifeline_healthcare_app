import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/providers/appointment_provider/book_appointment_provider.dart';
import 'package:provider/provider.dart';
import '../../models/doctors/doctor_model.dart';
import '../../providers/doctor_provider/doctor_provider.dart';

class PhysicalSummaryScreen extends StatefulWidget {
  const PhysicalSummaryScreen({super.key});

  @override
  State<PhysicalSummaryScreen> createState() => _PhysicalSummaryScreenState();
}

class _PhysicalSummaryScreenState extends State<PhysicalSummaryScreen> {
  DoctorModel? selectedDoctor; // <-- Selected doctor
  String selectedLanguage = "English";

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DoctorProvider>().getAllDoctors();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xff121212) : const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        title: Text(
          'Summary',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            CupertinoIcons.back,
            size: 23,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ),
      body: ListView(
        children: [
          _topBox(isDark, w, h),
          const SizedBox(height: 7),
          _languageBox(isDark, w),
          const SizedBox(height: 15),
          _dataAndPrivacyBox(isDark, w),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: Consumer2<BookAppointmentProvider, DoctorProvider>(
        builder: (context, appointmentProvider, doctorProvider, _) {
          return Container(
            height: 120,
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[900] : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      isDark
                          ? Colors.black.withOpacity(0.35)
                          : Colors.grey.withOpacity(0.20),
                  offset: const Offset(0, -2),
                  blurRadius: 8,
                ),
              ],
              border: Border(
                top: BorderSide(
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                  width: 0.8,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Pay with: UPI, GooglePay, PhonePay etc.',
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            isDark
                                ? Colors.grey.shade300
                                : Colors.grey.shade500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Secure Payment',
                      style: TextStyle(
                        fontSize: 14,
                        color:
                            isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                _gradientButton(
                  Theme.of(context),
                  color: isDark ? Colors.white : CupertinoColors.white,
                  title:
                      selectedDoctor != null
                          ? '₹499 | Pay & Consult'
                          : 'Select a Doctor',
                  onTap:
                      selectedDoctor != null
                          ? () {
                            appointmentProvider.createAppointment(
                              doctorId: selectedDoctor!.id ?? 0,
                              slotId: 4,
                              // Replace with selected slot
                              slotDate: '',
                              // Replace with selected date
                              startTime: selectedDoctor!.timing?.start ?? '',
                              endTime: selectedDoctor!.timing?.end ?? '',
                              type: selectedDoctor!.speciality ?? '', context: context,
                            );
                          }
                          : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _topBox(bool isDark, double w, double h) {
    return Padding(
      padding: EdgeInsets.all(w * 0.04),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.all(w * 0.04),
            decoration: BoxDecoration(
              color: isDark ? Colors.white12 : Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      isDark
                          ? Colors.black.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Consultation for\nPsychological Counselling',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                    Image.network(
                      'https://cdn-icons-png.flaticon.com/512/3475/3475363.png',
                      width: 60,
                      height: 60,
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Divider(color: Colors.grey.shade400, thickness: 0.5),
                const SizedBox(height: 20),
                Text(
                  'WE WILL ASSIGN YOU A TOP DOCTOR FROM BELOW',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'View our doctors currently online',
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.white54 : Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 20),
                _doctorList(isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _doctorList(bool isDark) {
    return Consumer<DoctorProvider>(
      builder: (context, provider, _) {
        final doctors = provider.filteredDoctorsList;

        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.teal,
              strokeWidth: 3,
            ),
          );
        }

        if (doctors.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "No doctors available for this speciality",
              style: TextStyle(color: isDark ? Colors.redAccent : Colors.red),
            ),
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                doctors.map((doctor) {
                  final isSelected = selectedDoctor == doctor;
                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedDoctor = doctor);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border:
                            isSelected
                                ? Border.all(color: Colors.teal, width: 2)
                                : null,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                              doctor.image ?? "https://via.placeholder.com/150",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                doctor.name ?? "",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                doctor.speciality ?? "",
                                style: TextStyle(
                                  color:
                                      isDark
                                          ? Colors.white70
                                          : const Color(0xff555555),
                                ),
                              ),
                              Text(
                                doctor.experience ?? "",
                                style: TextStyle(
                                  color:
                                      isDark
                                          ? Colors.white70
                                          : const Color(0xff555555),
                                ),
                              ),
                              Text(
                                "${doctor.totalConsult ?? 0} consultations",
                                style: TextStyle(
                                  color:
                                      isDark
                                          ? Colors.white70
                                          : const Color(0xff555555),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
        );
      },
    );
  }

  Widget _languageBox(bool isDark, double w) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.all(w * 0.04),
            decoration: BoxDecoration(
              color: isDark ? Colors.white12 : Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      isDark
                          ? Colors.black.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose your preferred language',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'We will try to find doctors who can speak the language.',
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.white70 : Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 15),
                Wrap(
                  spacing: 12,
                  children: [
                    _languageChip("English", isDark),
                    _languageChip("हिन्दी", isDark),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dataAndPrivacyBox(bool isDark, double w) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.all(w * 0.04),
            decoration: BoxDecoration(
              color: isDark ? Colors.white12 : Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      isDark
                          ? Colors.black.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lock, size: 18, color: Colors.grey.shade600),
                    const SizedBox(width: 5),
                    Text(
                      'Data and Privacy',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'The contents of your consultations are private and confidential. Lifeline Healthcare`s medical team may carry out routine anonymised audits to improve service quality.',
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? Colors.white70 : Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'By proceeding to avail a consultation, you agree to ',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? Colors.white70 : Colors.grey.shade600,
                        ),
                      ),
                      TextSpan(
                        text: 'Lifeline Healthcare`s Terms of use.',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? Colors.white70 : Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 7),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _languageChip(String label, bool isDark) {
    final selected = selectedLanguage == label;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: Colors.white,
      backgroundColor: Colors.white,
      showCheckmark: false,
      labelStyle: TextStyle(
        color: selected ? const Color(0xFF21887D) : Colors.grey.shade700,
      ),
      onSelected: (_) {
        setState(() => selectedLanguage = label);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: selected ? const Color(0xFF21887D) : Colors.grey.shade400,
        ),
      ),
    );
  }
}

Widget _gradientButton(
  ThemeData theme, {
  required Color color,
  required String title,
  required VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 47,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xff26A69A), Color(0xff00796B)],
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}
