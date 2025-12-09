import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorFindConsultScreen extends StatefulWidget {
  const DoctorFindConsultScreen({super.key});

  @override
  State<DoctorFindConsultScreen> createState() =>
      _DoctorFindConsultScreenState();
}

class _DoctorFindConsultScreenState extends State<DoctorFindConsultScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Color(0xff121212) : Color(0xFFF2F2F2),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(CupertinoIcons.back, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF00796B),
        title: const Text(
          "Find Doctors",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: w * 0.04),
            child: const Center(
              child: Text("Bangalore", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(w * 0.04),
          child: Column(
            children: [
              _searchBar(w),
              SizedBox(height: h * 0.02),
              _toggleOptions(w, h, isDark),
              SizedBox(height: h * 0.02),
              _sectionTitle("Results Offering Prime benefits", isDark),
              SizedBox(height: h * 0.02),
              ...List.generate(3, (index) => _doctorCard(context, isDark)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar(double w) {
    return Row(
      children: [
        Icon(Icons.search, size: w * 0.07),
        SizedBox(width: w * 0.03),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(w * 0.03),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Dermatologist..",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _toggleOptions(double w, double h, bool isDark) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: h * 0.015),
            decoration: BoxDecoration(
              color: const Color(0xFF00796B),
              borderRadius: BorderRadius.circular(w * 0.05),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "Physical Appointment",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(width: w * 0.03),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: h * 0.015),
            decoration: BoxDecoration(
              color: isDark ? Colors.white12 : Colors.white,
              borderRadius: BorderRadius.circular(w * 0.05),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: const Center(
              child: Text(
                "Video Consult",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title, bool isDark) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white70 : Colors.black87,
        ),
      ),
    );
  }

  Widget _doctorCard(BuildContext context, bool isDark) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(w * 0.04),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: EdgeInsets.all(w * 0.04),
            margin: EdgeInsets.only(bottom: h * 0.02),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(w * 0.04),
              border: Border.all(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withOpacity(0.3)
                      : Colors.grey.withOpacity(0.2),
                  blurRadius: 6,
                  offset: Offset(2, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(w * 0.25),
                      child: Image.network(
                        "https://assets.bucketlistly.blog/sites/5adf778b6eabcc00190b75b1/content_entry5adf77af6eabcc00190b75b6/6075185986d092000b192d0a/files/best-free-travel-images-main-image-hd-op.webp",
                        width: 100.w,
                        height: 100.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: w * 0.04),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dr. Vijay Kumar",
                            style: TextStyle(
                              fontSize: w * 0.045,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          SizedBox(height: h * 0.005),
                          Text(
                            "General Physician",
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          SizedBox(height: h * 0.005),
                          Text(
                            "22 years experience overall",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: w * 0.035,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: h * 0.015),
                Row(
                  children: [
                    _infoTag(icon: Icons.thumb_up, text: "60%", w: w, h: h),
                    SizedBox(width: w * 0.03),
                    _infoTag(icon: Icons.star, text: "4.2", w: w, h: h),
                  ],
                ),
                SizedBox(height: h * 0.02),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: h * 0.018),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(w * 0.03),
                        ),
                        child: Center(
                          child: Text(
                            "Contact Hospital",
                            style: TextStyle(
                                color: isDark ? Colors.white70 : Colors.black87),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: w * 0.03),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: h * 0.018),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00796B),
                          borderRadius: BorderRadius.circular(w * 0.03),
                        ),
                        child: const Center(
                          child: Text(
                            "Book appointment",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoTag({
    required IconData icon,
    required String text,
    required double w,
    required double h,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.008),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2F1).withOpacity(0.7),
        borderRadius: BorderRadius.circular(w * 0.02),
      ),
      child: Row(
        children: [
          Icon(icon, size: w * 0.045, color: Colors.teal),
          SizedBox(width: w * 0.02),
          Text(text, style: TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }
}
