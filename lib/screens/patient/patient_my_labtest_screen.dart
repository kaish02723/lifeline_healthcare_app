import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline_healthcare_app/providers/labtest_provider/book_test_provider.dart';
import 'package:lifeline_healthcare_app/providers/labtest_provider/cancel_test_provider.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_lab_test_screen.dart';
import 'package:lifeline_healthcare_app/widgets/animated_loader.dart';
import 'package:provider/provider.dart';

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
      Provider.of<BookTestProvider>(
        context,
        listen: false,
      ).getTestStatus(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xff0E0E0E) : Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff00796B),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text("My Tests", style: TextStyle(color: Colors.white)),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.04,
            vertical: h * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -------------------- TOP BOX ---------------------
              Container(
                padding: EdgeInsets.all(w * 0.05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: LinearGradient(
                    colors:
                        isDark
                            ? [
                              Colors.white.withOpacity(0.08),
                              Colors.white.withOpacity(0.04),
                            ]
                            : [
                              Colors.white.withOpacity(0.90),
                              Colors.white.withOpacity(0.70),
                            ],
                  ),
                  border: Border.all(
                    color:
                        isDark
                            ? Colors.white.withOpacity(0.12)
                            : Colors.black12,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          isDark
                              ? Colors.black.withOpacity(0.6)
                              : Colors.black12,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Colors.orange,
                      size: 28,
                    ),
                    SizedBox(width: w * 0.03),
                    Expanded(
                      child: Text(
                        "Your test status, bookings and prescription history.",
                        style: TextStyle(
                          fontSize: w * 0.035,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: h * 0.03),

              // -------------------- TEST LIST ---------------------
              Consumer<BookTestProvider>(
                builder: (context, value, child) {
                  if (value.myLabTestList.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 240),
                        child: MedicalHeartECGLoader(
                          width: 320,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.myLabTestList.length,
                    itemBuilder: (context, index) {
                      var testData = value.myLabTestList[index];

                      return Consumer<CancelTestProvider>(
                        builder: (BuildContext context, value, Widget? child) {
                          return TestCard(
                            userName: testData.user_name.toString(),
                            testName: testData.test_name.toString(),
                            phone: testData.phone.toString(),
                            category: testData.category.toString(),
                            status: testData.status.toString(),
                            onCancel: () {
                              showCancelDialog(
                                context,
                                onConfirm: () {
                                  value.cancelLabTest(context, index);
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff00796B),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PatientLabTestScreen()),
          );
        },
        child: Icon(Icons.add),
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
                        "Please provide a reason for canceling this test.",
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

                      /// Cancel Reason TextField
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
