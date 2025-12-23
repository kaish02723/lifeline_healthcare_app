import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline_healthcare_app/providers/rating_provider/submit_rating_provider.dart';
import 'package:lifeline_healthcare_app/providers/user_detail/get_userdetail_provider.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD:lib/screens/test/patient_book_test_screen.dart
import '../../providers/user_detail/auth_provider.dart';
=======

import '../../models/labtest_models/popular_test_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/labtest_provider/book_test_provider.dart';
import '../home/dashboard_screen.dart';
>>>>>>> dc42de5c0a28d2d5e355c77b180911aace99f633:lib/screens/patient/patient_book_test_screen.dart

class BookTestFormScreen extends StatefulWidget {
  final TestDataModel test;

  const BookTestFormScreen({super.key, required this.test});

  @override
  State<BookTestFormScreen> createState() => _BookTestFormScreenState();
}

class _BookTestFormScreenState extends State<BookTestFormScreen> {
  @override
  @override
  void initState() {
    super.initState();

    final bookTestProvider = Provider.of<BookTestProvider>(
      context,
      listen: false,
    );
    final userProvider = Provider.of<GetUserDetailProvider>(
      context,
      listen: false,
    );
    final userName = userProvider.user?.name;

    bookTestProvider.testNameController.text = userName!;
  }

  void showTestSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => StatefulBuilder(
            builder:
                (context, setState) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  content: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 350),
                    child: SingleChildScrollView(
                      child: Consumer<SubmitRatingProvider>(
                        builder: (BuildContext context, value, Widget? child) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 70,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                "Test Booked Successfully 🎉",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                widget.test.name ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                widget.test.category ?? "",
                                style: const TextStyle(color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "Rate your experience",
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 6),

                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 3,
                                children: List.generate(
                                  5,
                                  (index) => IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () {
                                      value.labtestSelectedRatingCount(index);
                                    },
                                    icon: Icon(
                                      Icons.star,
                                      color:
                                          index < value.labtestRating
                                              ? const Color(0xFFFFC107)
                                              : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => DashboardScreen(),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookTestProvider = Provider.of<BookTestProvider>(context);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xff121212) : Colors.grey[100],
      appBar: AppBar(
        title: const Text("Book Test"),
        backgroundColor: const Color(0xff00796B),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color:
                        isDark
                            ? Colors.white.withOpacity(0.05)
                            : Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color:
                          isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                      width: 0.6,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            isDark
                                ? Colors.black26
                                : Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.test.name ?? "Unknown Test",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.test.description ?? "No description available",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: isDark ? Colors.grey[400] : Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _InfoRow(
                        icon: Icons.category,
                        text: widget.test.category ?? "General",
                        isDark: isDark,
                      ),
                      const SizedBox(height: 8),
                      _InfoRow(
                        icon: Icons.info_outline,
                        text:
                            widget.test.preparation ??
                            "No preparation required",
                        isDark: isDark,
                      ),
                      const SizedBox(height: 7),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            Form(
              key: bookTestProvider.testFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User Name",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: bookTestProvider.testNameController,
                    validator: (v) => v!.isEmpty ? "Name required" : null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your name',
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Phone Number",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: bookTestProvider.testPhoneController,
                    keyboardType: TextInputType.phone,
                    validator:
                        (v) => v!.length != 10 ? "Enter valid number" : null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter phone no',
                    ),
                  ),

                  const SizedBox(height: 30),

                  GestureDetector(
                    onTap: () async {
                      if (bookTestProvider.testFormKey.currentState!
                          .validate()) {
                        final payload = {
                          "user_id": auth.userId,
                          "user_name":
                              bookTestProvider.testNameController.text.trim(),
                          "test_id": widget.test.id,
                          "test_name": widget.test.name,
                          "category": widget.test.category,
                          "price": widget.test.price,
                          "phone":
                              bookTestProvider.testPhoneController.text.trim(),
                        };

                        bool success = await bookTestProvider.bookTest(payload);

                        if (success)
                          showTestSuccessDialog();
                        else
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Booking failed")),
                          );
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                          colors: [Color(0xff26A69A), Color(0xff00796B)],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '₹${widget.test.price} | ',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Pay & Book",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isDark;

  const _InfoRow({
    required this.icon,
    required this.text,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: isDark ? Colors.grey[400] : Colors.grey[700],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: isDark ? Colors.grey[400] : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
