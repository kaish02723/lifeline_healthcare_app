import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../providers/doctor_provider.dart';
import '../../widgets/doctor_category_card.dart';
import '../doctor/doctor_find_consult_screen.dart';
import '../home/help_support_screen.dart';
import '../patient/patient_know_more_screen.dart';

class PatientConsultScreen extends StatelessWidget {
  const PatientConsultScreen({super.key});

  static const Color primary = Color(0xFF00796B);

  // SAME DATA
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
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width >= 600 ? 4 : 3;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xff121212) : Colors.grey[100],
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text("Consult a doctor"),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HelpSupportScreen()),
              );
            },
            child: const Text("HELP", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionHeading("CHOOSE FROM TOP SPECIALITIES", isDark),
            buildGrid(
              context,
              topSpecialitiesImages,
              crossAxisCount,
              isDark,
              onTap: (title) {
                final provider =
                Provider.of<DoctorProvider>(context, listen: false);

                if (title == "View\nAll") {
                  provider.filterBySpeciality("All");
                } else {
                  provider.filterBySpeciality(
                    specialityMapper(title),
                  );
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DoctorFindConsultScreen(),
                  ),
                );
              },
            ),

            sectionHeading("Common Health Issues", isDark),
            buildGrid(
              context,
              commonIssuesImages,
              crossAxisCount,
              isDark,
              onTap: (title) {
                final provider =
                Provider.of<DoctorProvider>(context, listen: false);

                provider.filterBySpeciality(
                  issueToSpeciality(title),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DoctorFindConsultScreen(),
                  ),
                );
              },
            ),

            sectionHeading("General Physician", isDark),
            buildGrid(
              context,
              gpImages,
              crossAxisCount,
              isDark,
              onTap: (_) {
                final provider =
                Provider.of<DoctorProvider>(context, listen: false);

                provider.filterBySpeciality("General Physician");

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DoctorFindConsultScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ---------- HELPERS (NO UI CHANGE)

  Widget sectionHeading(String text, bool isDark) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : Colors.black,
      ),
    ),
  );

  Widget buildGrid(
      BuildContext context,
      Map<String, String> data,
      int crossAxisCount,
      bool isDark, {
        required Function(String) onTap,
      }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (_, index) {
        final title = data.keys.elementAt(index);
        return SquareCategory(
          title: title,
          imageUrl: data[title]!,
          isDark: isDark,
          onTap: () => onTap(title),
        );
      },
    );
  }
}

// ---------------- MAPPERS ----------------

String specialityMapper(String title) {
  switch (title) {
    case "Pediat\nrics":
      return "Paediatrics & Neonatology";
    case "Gynae\ncolo":
      return "Obstetrics & Gynaecology";
    case "General\nphysician":
      return "General"; // match API
    case "Derma\ntology":
      return "Dermatologist";
    case "Ortho-\npedic":
      return "Orthopedic";
    case "Mental\nWellness":
      return "Psychiatrist";
    default:
      return "General";
  }
}


String issueToSpeciality(String issue) {
  switch (issue) {
    case "Acne":
    case "Fungal\nInfection":
      return "Dermatologist";
    case "PCOS":
      return "Gynecologist";
    case "Back Pain":
      return "Orthopedic";
    case "Head\naches":
      return "Neurologist";
    case "Stomach\npain":
      return "Gastroenterologist";
    default:
      return "General Physician";
  }
}
