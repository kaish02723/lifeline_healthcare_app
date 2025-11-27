import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeline_healthcare_app/screens/doctor/find_doctor_screen.dart';
import 'package:lifeline_healthcare_app/screens/home/help_support_screen.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_know_more_screen.dart';
import '../doctor/doctor_find_consult_screen.dart';

class PatientConsultScreen extends StatelessWidget {
  const PatientConsultScreen({super.key});

  static const Color primary = Color(0xFF00796B);
  static const Color lightAccent = Color(0xFF009688);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(CupertinoIcons.back, size: 22.sp),
        ),
        backgroundColor: primary,
        elevation: 0,
        title: Text(
          "Consult a doctor",
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 14.w),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HelpSupportScreen()));
                },
                child: Text(
                  "HELP",
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Free follow-up card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F2F1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Free follow-up",
                      style: TextStyle(
                        color: primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "for 7 days with every consultation",
                      style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                    ),
                    SizedBox(height: 6.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FollowUpScreen()));
                      },
                      child: Text(
                        "Know More >",
                        style: TextStyle(color: Colors.black54, fontSize: 11.sp),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 18.h),

              /// Search
              Text(
                "Search Health Problem/ symptoms",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8.h),
              TextField(
                decoration: InputDecoration(
                  hintText: "Search symptoms..",
                  prefixIcon: Icon(Icons.search, size: 21.sp),
                  filled: true,
                  fillColor: const Color(0xfff1f1f1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: 22.h),

              sectionHeading("CHOOSE FROM TOP SPECIALITIES"),

              /// Gridview 1
              buildGrid([
                "Mental\nWellness", "Gynae\ncolo", "General\nphysician", "Derma\ntology",
                "Ortho-\npedic", "Pediat\nrics", "Sexology", "View\nAll",
              ], [
                "🧠", "🤰", "🩺", "🧴",
                "🦴", "🧒", "❤️", "ALL",
              ], context),

              SizedBox(height: 24.h),

              sectionHeading("Common Health Issues"),
              buildGrid([
                "Stomach\npain", "Vertigo", "Acne", "PCOS",
                "Thyroid", "Head\naches", "Fungal\nInfection", "Back Pain",
              ], [
                "🤢", "😵", "🌿", "🩺",
                "🧪", "🤕", "🍄", "🦴",
              ], context),

              SizedBox(height: 24.h),

              sectionHeading("General Physician"),
              buildGrid([
                "Fever", "High blood\npressure", "Dizziness", "Pneum\nonia",
              ], [
                "🤒", "❤️‍🩹", "😵‍💫", "🫁",
              ], context),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionHeading(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget buildGrid(List<String> titles, List<String> emojis, BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: titles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 18.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) => CircleCategory(
        title: titles[index],
        emoji: emojis[index],
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => DoctorFindConsultScreen()));
        },
      ),
    );
  }
}

/// Reusable circular category widget
class CircleCategory extends StatelessWidget {
  final String title;
  final String emoji;
  final VoidCallback? onTap;

  const CircleCategory({
    super.key,
    required this.title,
    required this.emoji,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(emoji, style: TextStyle(fontSize: 30.sp)),
          SizedBox(height: 4.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.sp),
          ),
        ],
      ),
    );
  }
}
