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

  // Sample network icons (placeholder service). Replace with your CDN links when ready.
  static final Map<String, String> topSpecialitiesImages = {
    "Mental\nWellness":
        "https://cdn-icons-png.flaticon.com/512/3475/3475728.png",
    "Gynae\ncolo": "https://cdn-icons-png.flaticon.com/512/10154/10154415.png",
    "General\nphysician":
        "https://cdn-icons-png.flaticon.com/512/3774/3774299.png",
    "Derma\ntology": "https://cdn-icons-png.flaticon.com/512/3468/3468053.png",
    "Ortho-\npedic": "https://cdn-icons-png.flaticon.com/512/4006/4006302.png",
    "Pediat\nrics": "https://cdn-icons-png.flaticon.com/512/9340/9340051.png",
    "Sexology": "https://cdn-icons-png.flaticon.com/512/11377/11377926.png",
    "View\nAll": "https://via.placeholder.com/120?text=All",
  };

  static final Map<String, String> commonIssuesImages = {
    "Stomach\npain": "https://cdn-icons-png.flaticon.com/512/5730/5730077.png",
    "Vertigo": "https://cdn-icons-png.flaticon.com/512/3997/3997779.png",
    "Acne": "https://cdn-icons-png.flaticon.com/512/2590/2590696.png",
    "PCOS": "https://via.placeholder.com/120?text=PCOS",
    "Thyroid": "https://cdn-icons-png.flaticon.com/512/10207/10207748.png",
    "Head\naches": "https://cdn-icons-png.flaticon.com/512/4843/4843993.png",
    "Fungal\nInfection":
        "https://cdn-icons-png.flaticon.com/512/8711/8711576.png",
    "Back Pain": "https://cdn-icons-png.flaticon.com/512/4986/4986231.png",
  };

  static final Map<String, String> gpImages = {
    "Fever": "https://cdn-icons-png.flaticon.com/512/6192/6192088.png",
    "High blood\npressure":
        "https://cdn-icons-png.flaticon.com/512/5015/5015609.png",
    "Dizziness": "https://cdn-icons-png.flaticon.com/512/6701/6701662.png",
    "Pneum\nonia": "https://cdn-icons-png.flaticon.com/512/7350/7350852.png",
  };

  @override
  Widget build(BuildContext context) {
    // screen width detection
    final double width = MediaQuery.of(context).size.width;

    // Responsive cross axis count: mobile 3, tablet/large 4
    final int crossAxisCount = width >= 600 ? 4 : 3;

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HelpSupportScreen(),
                    ),
                  );
                },
                child: Text(
                  "HELP",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // we can further tune sizes based on available height/width through constraints if needed
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Free follow-up card
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
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FollowUpScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Know More >",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 18.h),

                  // Search
                  Text(
                    "Search Health Problem/ symptoms",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
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

                  // Gridview 1 (Top Specialities)
                  buildResponsiveGrid(
                    context: context,
                    items: topSpecialitiesImages.keys.toList(),
                    imageMap: topSpecialitiesImages,
                    crossAxisCount: crossAxisCount,
                  ),

                  SizedBox(height: 24.h),

                  sectionHeading("Common Health Issues"),
                  buildResponsiveGrid(
                    context: context,
                    items: commonIssuesImages.keys.toList(),
                    imageMap: commonIssuesImages,
                    crossAxisCount: crossAxisCount,
                  ),

                  SizedBox(height: 24.h),

                  sectionHeading("General Physician"),
                  buildResponsiveGrid(
                    context: context,
                    items: gpImages.keys.toList(),
                    imageMap: gpImages,
                    crossAxisCount: crossAxisCount,
                  ),

                  SizedBox(height: 32.h),
                ],
              ),
            );
          },
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

  /// Generic responsive grid builder
  Widget buildResponsiveGrid({
    required BuildContext context,
    required List<String> items,
    required Map<String, String> imageMap,
    required int crossAxisCount,
  }) {
    // spacing tuned for ScreenUtil
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 15.h,
        crossAxisSpacing: 12.w,
        // childAspectRatio tuned so square-ish image + title fits
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final title = items[index];
        final imageUrl = imageMap[title] ?? imageMap.values.first;

        return SquareCategory(
          title: title,
          imageUrl: imageUrl,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DoctorFindConsultScreen()),
            );
          },
        );
      },
    );
  }
}

/// Square category widget (network image + title)
class SquareCategory extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback? onTap;

  const SquareCategory({
    super.key,
    required this.title,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double containerSize =
        (MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.width >= 600 ? 6.2 : 4.6))
            .clamp(56.0, 90.0);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: containerSize.w,
            height: containerSize.w,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: const Color(0xffF5F7FA),
              borderRadius: BorderRadius.circular(7.r),
              border: Border.all(color: const Color(0xffd1d1d1), width: 0.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 6.r,
                  offset: Offset(0, 2.r),
                ),
              ],
            ),
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 1.6),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}
