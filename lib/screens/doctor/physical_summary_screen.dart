import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhysicalSummaryScreen extends StatefulWidget {
  const PhysicalSummaryScreen({super.key});

  @override
  State<PhysicalSummaryScreen> createState() => _PhysicalSummaryScreenState();
}

class _PhysicalSummaryScreenState extends State<PhysicalSummaryScreen> {
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: isDark ? Color(0xff121212) : Color(0xffF5F5F5),
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
          icon: Icon(CupertinoIcons.back, size: 23, color: isDark ? Colors.white : Colors.black87),
        ),
      ),
      body: ListView(
        children: [
          _topBox(isDark, w, h),
          const SizedBox(height: 7),
          _languageBox(isDark, w),
          const SizedBox(height: 7),
          _placeholderBox(isDark),
        ],
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
                  color: isDark ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.2),
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
                SizedBox(height: 25),
                Divider(color: Colors.grey.shade400, thickness: 0.5),
                SizedBox(height: 20),
                Text(
                  'WE WILL ASSIGN YOU A TOP DOCTOR FROM BELOW',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'View our doctors currently online',
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.white54 : Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 20),
                _doctorList(isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _doctorList(bool isDark) {
    final doctors = [
      {
        "name": "Ms. Bipasha",
        "role": "Counselling Psychologist",
        "experience": "18 years experience",
        "consultations": "9054 consultations",
        "img": "https://www.shutterstock.com/image-photo/close-head-shot-portrait-preppy-600nw-1433809418.jpg",
      },
      {
        "name": "Mr. Ramesh",
        "role": "Counselling Psychologist",
        "experience": "11 years experience",
        "consultations": "4120 consultations",
        "img": "https://img.freepik.com/free-photo/cheerful-indian-businessman-smiling-closeup-portrait-jobs-career-campaign_53876-129417.jpg?semt=ais_hybrid&w=740&q=80",
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: doctors.map((doctor) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(doctor['img']!),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      doctor['name']!,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: isDark ? Colors.white : Colors.black87),
                    ),
                    SizedBox(height: 5),
                    Text(
                      doctor['role']!,
                      style: TextStyle(color: isDark ? Colors.white70 : Color(0xff555555)),
                    ),
                    Text(
                      doctor['experience']!,
                      style: TextStyle(color: isDark ? Colors.white70 : Color(0xff555555)),
                    ),
                    Text(
                      doctor['consultations']!,
                      style: TextStyle(color: isDark ? Colors.white70 : Color(0xff555555)),
                    ),
                  ],
                ),
                Container(
                  width: 0.5,
                  height: 100,
                  margin: const EdgeInsets.only(left: 20),
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          );
        }).toList(),
      ),
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
                Text(
                  'Choose your preferred language',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: isDark ? Colors.white : Colors.black87),
                ),
                const SizedBox(height: 3),
                Text(
                  'We will try to find doctors who can speak the language.',
                  style: TextStyle(fontSize: 13, color: isDark ? Colors.white70 : Colors.grey.shade600),
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

  Widget _languageChip(String label, bool isDark) {
    final selected = selectedLanguage == label;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: Colors.white,
      backgroundColor: Colors.white,
      showCheckmark: false,
      labelStyle: TextStyle(
        color: selected ? Color(0xFF21887D) : Colors.grey.shade700,
      ),
      onSelected: (_) {
        setState(() => selectedLanguage = label);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: selected ? Color(0xFF21887D) : Colors.grey.shade400,
        ),
      ),
    );
  }

  Widget _placeholderBox(bool isDark) {
    return Container(
      height: 150,
      color: isDark ? Colors.white12 : Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
