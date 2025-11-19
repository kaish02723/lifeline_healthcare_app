import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/physical_summary_screen.dart';

class PhysicalAppointmentScreen extends StatelessWidget {
  static const Color primary = Color(0xFF00796B);
  static const Color lightAccent = Color(0xFF009688);

  const PhysicalAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back, size: 23),
        ),
        title: Text('Find Doctors'),
        actions: [
          SizedBox(
            child: Row(
              children: [Text('Banglore'), Icon(Icons.arrow_drop_down)],
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: const [
                      CircleAvatar(
                        backgroundColor: Color(0xFFF0F0F0),
                        child: Icon(
                          Icons.question_mark,
                          color: Colors.black87,
                          size: 18,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Learn how to book an appointment",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey.shade600),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Symptoms/ Specialities",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                const Text(
                  "Most searched specialities",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),

                const SizedBox(height: 14),

                _gridSection(_topList1),

                const SizedBox(height: 16),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black87),
                  ),
                  child: const Center(
                    child: Text(
                      "View All Specialities",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Conditions that can treated through surgeries",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),

                const SizedBox(height: 6),
                const Text(
                  "Find top surgeons near you for your surgical procedure",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),

                const SizedBox(height: 16),

                _gridSection(_topList2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _gridSection(List<Map<String, dynamic>> list) {
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
            child: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE0F2F1),
              ),
              child: ClipOval(
                child: Image.network(item['img'], fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item['title'],
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      );
    },
  );
}

final List<Map<String, dynamic>> _topList1 = [
  {
    "title": "Stomach pain",
    "img": "https://cdn-icons-png.flaticon.com/512/706/706195.png",
  },
  {
    "title": "Vertigo",
    "img": "https://cdn-icons-png.flaticon.com/512/706/706164.png",
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
    "title": "Views All",
    "img": "https://cdn-icons-png.flaticon.com/512/565/565547.png",
  },
];
