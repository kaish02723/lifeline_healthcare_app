import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeline_healthcare_app/screens/home/help_support_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/doctor_provider.dart';
import '../doctor/doctor_find_consult_screen.dart';
import '../medicine screen/patient_know_more_screen.dart';

class PatientConsultScreen extends StatefulWidget {
  const PatientConsultScreen({super.key});

  static const Color primary = Color(0xFF00796B);

  // Sample network icons
  static final Map<String, String> topSpecialitiesImages = {
    "Mental\nWellness": "https://cdn-icons-png.flaticon.com/512/3475/3475728.png",
    "Gynae\ncolo": "https://cdn-icons-png.flaticon.com/512/10154/10154415.png",
    "General\nphysician": "https://cdn-icons-png.flaticon.com/512/3774/3774299.png",
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
    "Fungal\nInfection": "https://cdn-icons-png.flaticon.com/512/8711/8711576.png",
    "Back Pain": "https://cdn-icons-png.flaticon.com/512/4986/4986231.png",
  };

  static final Map<String, String> gpImages = {
    "Fever": "https://cdn-icons-png.flaticon.com/512/6192/6192088.png",
    "High blood\npressure": "https://cdn-icons-png.flaticon.com/512/5015/5015609.png",
    "Dizziness": "https://cdn-icons-png.flaticon.com/512/6701/6701662.png",
    "Pneum\nonia": "https://cdn-icons-png.flaticon.com/512/7350/7350852.png",
  };

  @override
  State<PatientConsultScreen> createState() => _PatientConsultScreenState();
}

class _PatientConsultScreenState extends State<PatientConsultScreen> {
  String specialityMapper(String title) {
    switch (title) {
      case "Mental\nWellness":
        return "Psychiatry";

      case "Gynae\ncolo":
        return "Gynecology";

      case "General\nphysician":
        return "General Physician";

      case "Derma\ntology":
        return "Dermatology";

      case "Ortho-\npedic":
        return "Orthopaedics";

      case "Pediat\nrics":
        return "Pediatrics";

      case "Sexology":
        return "Sexology";

      default:
        return "All";
    }
  }

  String issueToSpeciality(String issue) {
    switch (issue) {
      case "Stomach\npain":
        return "Gastroenterology";
      case "Vertigo":
      case "Head\naches":
        return "Neurology";
      case "Acne":
      case "Fungal\nInfection":
        return "Dermatology";
      case "PCOS":
        return "Gynecology";
      case "Thyroid":
        return "Endocrinology";
      case "Back Pain":
        return "Orthopaedics";
      default:
        return "General Physician";
    }
  }
  final TextEditingController _searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width >= 600 ? 4 : 3;
    var doctorProvider=Provider.of<DoctorProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? Color(0xff121212) : Colors.grey[100],
      appBar: AppBar(
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(CupertinoIcons.back, size: 22.sp),
        ),
        backgroundColor: PatientConsultScreen.primary,
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
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Free follow-up card (glassy)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(14.r),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withOpacity(0.05)
                              : Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Free follow-up",
                              style: TextStyle(
                                color: PatientConsultScreen.primary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "for 7 days with every consultation",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: isDark ? Colors.white70 : Colors.black87,
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
                                  color: isDark ? Colors.white54 : Colors.black54,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 18.h),

                  // Search
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: isDark
                            ? Colors.white.withOpacity(0.05)
                            : Colors.white.withOpacity(0.8),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            Provider.of<DoctorProvider>(
                              context,
                              listen: false,
                            ).searchDoctors(value);
                          },
                          onSubmitted: (value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const DoctorFindConsultScreen(),
                              ),
                            );
                          },
                          decoration: InputDecoration(
                            hintText: "Search symptoms..",
                            prefixIcon: Icon(Icons.search, size: 21.sp),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _searchController.clear();
                                Provider.of<DoctorProvider>(
                                  context,
                                  listen: false,
                                ).searchDoctors("");
                              },
                            )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 22.h),

                  sectionHeading("CHOOSE FROM TOP SPECIALITIES", isDark),
                  buildResponsiveGrid(
                    context: context,
                    items: PatientConsultScreen.topSpecialitiesImages.keys.toList(),
                    imageMap: PatientConsultScreen.topSpecialitiesImages,
                    crossAxisCount: crossAxisCount,
                    isDark: isDark,
                  ),

                  SizedBox(height: 24.h),

                  sectionHeading("Common Health Issues", isDark),
                  buildResponsiveGrid(
                    context: context,
                    items: PatientConsultScreen.commonIssuesImages.keys.toList(),
                    imageMap: PatientConsultScreen.commonIssuesImages,
                    crossAxisCount: crossAxisCount,
                    isDark: isDark,
                  ),

                  SizedBox(height: 24.h),

                  sectionHeading("General Physician", isDark),
                  buildResponsiveGrid(
                    context: context,
                    items: PatientConsultScreen.gpImages.keys.toList(),
                    imageMap: PatientConsultScreen.gpImages,
                    crossAxisCount: crossAxisCount,
                    isDark: isDark,
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

  Widget sectionHeading(String text, bool isDark) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
    );
  }

  Widget buildResponsiveGrid({
    required BuildContext context,
    required List<String> items,
    required Map<String, String> imageMap,
    required int crossAxisCount,
    required bool isDark,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 15.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final title = items[index];
        final imageUrl = imageMap[title] ?? imageMap.values.first;

        return SquareCategory(
          title: title,
          imageUrl: imageUrl,
          isDark: isDark,
          onTap: () {
            final provider =
            Provider.of<DoctorProvider>(context, listen: false);

            if (title == "View\nAll") {
              provider.filterBySpeciality("All");
            } else if (PatientConsultScreen.commonIssuesImages.containsKey(title)) {
              provider.filterBySpeciality(issueToSpeciality(title));
            } else {
              provider.filterBySpeciality(specialityMapper(title));
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const DoctorFindConsultScreen(),
              ),
            );
          },

        );
      },
    );
  }
}

class SquareCategory extends StatelessWidget {
  final String title;
  final String imageUrl;
  final bool isDark;
  final VoidCallback? onTap;

  const SquareCategory({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.isDark,
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
          ClipRRect(
            borderRadius: BorderRadius.circular(7.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: containerSize.w,
                height: containerSize.w,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.05)
                      : Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(7.r),
                  border: Border.all(
                    color: isDark ? Colors.grey.shade800 : const Color(0xffd1d1d1),
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black26
                          : Colors.grey.withOpacity(0.15),
                      blurRadius: 6.r,
                      offset: Offset(2, 3),
                    ),
                  ],
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
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
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
