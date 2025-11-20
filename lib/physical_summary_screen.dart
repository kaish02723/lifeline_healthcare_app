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
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Summary',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back, size: 23),
        ),
      ),

      body: ListView(
        children: [
          // ---------------- TOP BOX ----------------
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // header text and image
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 17),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Consultation for\nPsychological Counselling',
                          style: TextStyle(fontSize: 20, color: Colors.black87),
                        ),
                      ),
                      Image.network(
                        'https://cdn-icons-png.flaticon.com/512/3475/3475363.png',
                        width: 60,
                        height: 60,
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 17),
                  child: Container(
                    height: 0.5,
                    width: MediaQuery.of(context).size.width * 0.9,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                const Padding(
                  padding: EdgeInsets.only(left: 17),
                  child: Text(
                    'WE WILL ASSIGN YOU A TOP DOCTOR FROM BELOW',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 3),

                Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: Text(
                    'View our doctors currently online',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ),

                // DOCTOR LIST
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // Doctor 1
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 17),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                            'https://www.shutterstock.com/image-photo/close-head-shot-portrait-preppy-600nw-1433809418.jpg',
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(height: 25),
                          Text(
                            'Ms. Bipasha',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Counselling Psychologist',
                            style: TextStyle(color: Color(0xff555555)),
                          ),
                          Text(
                            '18 years experience',
                            style: TextStyle(color: Color(0xff555555)),
                          ),
                          Text(
                            '9054 consultations',
                            style: TextStyle(color: Color(0xff555555)),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 40, top: 5),
                        child: Container(
                          width: 0.5,
                          height: 100,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(width: 15),

                      // Doctor 2
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/cheerful-indian-businessman-smiling-closeup-portrait-jobs-career-campaign_53876-129417.jpg?semt=ais_hybrid&w=740&q=80',
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(height: 25),
                          Text(
                            'Mr. Ramesh',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Counselling Psychologist',
                            style: TextStyle(color: Color(0xff555555)),
                          ),
                          Text(
                            '11 years experience',
                            style: TextStyle(color: Color(0xff555555)),
                          ),
                          Text(
                            '4120 consultations',
                            style: TextStyle(color: Color(0xff555555)),
                          ),
                        ],
                      ),

                      const SizedBox(width: 20),
                    ],
                  ),
                ),
                SizedBox(height: 15,)
              ],
            ),
          ),

          const SizedBox(height: 7),

          // ---------------- LANGUAGE BOX ----------------
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose your preferred language',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 3),
                Text(
                  'We will try to find doctors who can speak the language.',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),

                const SizedBox(height: 15),

                // ----------- CHOICE CHIPS -----------
                Wrap(
                  spacing: 12,
                  children: [
                    // English Chip
                    ChoiceChip(
                      label: const Text("English"),
                      selected: selectedLanguage == "English",
                      selectedColor: Colors.white,
                      backgroundColor: Colors.white,
                      showCheckmark: false,
                      labelStyle: TextStyle(
                        color:
                        selectedLanguage == "English"
                            ? Color(0xFF21887D)
                            : Colors.grey,
                      ),
                      onSelected: (value) {
                        setState(() {
                          selectedLanguage = "English";
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color:
                          selectedLanguage == "English"
                              ? const Color(0xFF21887D)
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),

                    // Hindi Chip
                    ChoiceChip(
                      label: const Text(" हिन्दी "),
                      selected: selectedLanguage == "हिन्दी",
                      selectedColor: Colors.white,
                      backgroundColor: Colors.white,
                      showCheckmark: false,
                      labelStyle: TextStyle(
                        color:
                        selectedLanguage == "हिन्दी"
                            ? Color(0xFF21887D)
                            : Colors.grey,
                      ),
                      onSelected: (value) {
                        setState(() {
                          selectedLanguage = "हिन्दी";
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color:
                          selectedLanguage == "हिन्दी"
                              ? const Color(0xFF21887D)
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 7),

          Container(height: 150, color: Colors.white),
        ],
      ),
    );
  }
}
