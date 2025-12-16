import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/screens/doctor/physical_summary_screen.dart';

class PhysicalAppointmentScreen extends StatelessWidget {
  static const Color primary = Color(0xFF00796B);

  const PhysicalAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Color(0xff121212) : Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(CupertinoIcons.back, size: 23),
        ),
        title: Text('Find Doctors'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Text('Bangalore', style: TextStyle(color: Colors.white)),
                Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              // Info Card
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withOpacity(0.05)
                          : Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: isDark
                              ? Colors.white12
                              : Color(0xFFF0F0F0),
                          child: Icon(
                            Icons.question_mark,
                            color: isDark ? Colors.white : Colors.black87,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Learn how to book an appointment",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: 16, color: isDark ? Colors.white54 : Colors.black54),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Search bar
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withOpacity(0.05)
                          : Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search,
                            color: isDark ? Colors.white54 : Colors.grey.shade600),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search Symptoms/ Specialities",
                              hintStyle: TextStyle(
                                  color: isDark ? Colors.white54 : Colors.grey.shade600),
                            ),
                            style: TextStyle(
                                color: isDark ? Colors.white : Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              Text(
                "Most searched specialities",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),

              const SizedBox(height: 14),
              _gridSection(_topList1, isDark),

              const SizedBox(height: 16),

              // // View All Specialities
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(12),
              //   child: BackdropFilter(
              //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              //     child: Container(
              //       width: double.infinity,
              //       padding: const EdgeInsets.symmetric(vertical: 14),
              //       decoration: BoxDecoration(
              //         color: isDark
              //             ? Colors.white.withOpacity(0.05)
              //             : Colors.white.withOpacity(0.8),
              //         borderRadius: BorderRadius.circular(12),
              //         border: Border.all(
              //           color: isDark ? Colors.grey.shade800 : Colors.black87,
              //         ),
              //       ),
              //       child: Center(
              //         child: Text(
              //           "View All Specialities",
              //           style: TextStyle(
              //             fontWeight: FontWeight.w600,
              //             fontSize: 15,
              //             color: isDark ? Colors.white : Colors.black87,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              const SizedBox(height: 20),

              Text(
                "Conditions that can be treated through surgeries",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "Find top surgeons near you for your surgical procedure",
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white54 : Colors.black54,
                ),
              ),

              const SizedBox(height: 16),
              _gridSection(_topList2, isDark),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _gridSection(List<Map<String, dynamic>> list, bool isDark) {
  return GridView.builder(
    itemCount: list.length,
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      crossAxisSpacing: 12,
      mainAxisSpacing: 20,
      childAspectRatio: 0.74,
    ),
    itemBuilder: (context, index) {
      final item = list[index];
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhysicalSummaryScreen(),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withOpacity(0.05)
                        : Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                        color: isDark ? Colors.grey.shade800 : Colors.grey, width: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black26
                            : Colors.grey.withOpacity(0.2),
                        blurRadius: 6,
                        offset: Offset(2, 3),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: item['img'],
                      fit: BoxFit.contain,
                      placeholder: (context, url) => const Center(
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 1.5),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.broken_image,
                        color: isDark ? Colors.white54 : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item['title'],
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      );
    },
  );
}

final List<Map<String, dynamic>> _topList1 = [
  {
    "title": "Stomach pain",
    "img": "https://cdn-icons-png.flaticon.com/512/5730/5730048.png",
  },
  {
    "title": "Vertigo",
    "img": "https://cdn-icons-png.flaticon.com/512/2727/2727743.png",
  },
  {
    "title": "Acne",
    "img": "https://cdn-icons-png.flaticon.com/512/706/706198.png",
  },
  {
    "title": "PCOS",
    "img": "https://cdn-icons-png.flaticon.com/512/706/706192.png",
  },
  {
    "title": "Thyroid",
    "img": "https://cdn-icons-png.flaticon.com/512/706/706193.png",
  },
  {
    "title": "Head aches",
    "img": "https://cdn-icons-png.flaticon.com/512/706/706171.png",
  },
  {
    "title": "Fungal Infection",
    "img": "https://cdn-icons-png.flaticon.com/512/706/706168.png",
  },
  {
    "title": "Back Pain",
    "img": "https://cdn-icons-png.flaticon.com/512/706/706186.png",
  },
];

final List<Map<String, dynamic>> _topList2 = [
  {
    "title": "Mental Wellness",
    "img": "https://cdn-icons-png.flaticon.com/512/706/706180.png",
  },
  {
    "title": "Gynae colo",
    "img": "https://cdn-icons-png.flaticon.com/512/706/706200.png",
  },
  {
    "title": "General physician",
    "img": "https://cdn-icons-png.flaticon.com/512/706/706167.png",
  },
  {
    "title": "Dermatology",
    "img": "https://cdn-icons-png.flaticon.com/512/706/706162.png",
  },
  {
    "title": "Ortho-pedic",
    "img": "https://cdn-icons-png.flaticon.com/512/706/706187.png",
  },
  {
    "title": "Pediatrics",
    "img": "https://cdn-icons-png.flaticon.com/512/706/706173.png",
  },
  {
    "title": "Sexology",
    "img": "https://cdn-icons-png.flaticon.com/512/706/706185.png",
  },
  {
    "title": "View All",
    "img": "https://cdn-icons-png.flaticon.com/512/565/565547.png",
  },
];
