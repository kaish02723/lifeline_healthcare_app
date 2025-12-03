import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../patient/patient_medicine_cart_screen.dart';

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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(CupertinoIcons.back)),
        backgroundColor: const Color(0xFF00796B),
        title: const Text("Find Doctors", style: TextStyle(color: Colors.white)),
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
              Row(
                children: [
                  Icon(Icons.arrow_back, size: w * 0.07),
                  SizedBox(width: w * 0.03),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
              ),

              SizedBox(height: h * 0.02),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: h * 0.015),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00796B),
                        borderRadius: BorderRadius.circular(w * 0.05),
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
                        color: Colors.white,
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
              ),

              SizedBox(height: h * 0.02),

              const Text(
                "Results Offering Prime benefits",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),

              SizedBox(height: h * 0.02),

              ...List.generate(
                3,
                    (index) => MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MedicineCart()),
                    // );
                  },
                  child: _doctorCard(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _doctorCard(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(w * 0.04),
      margin: EdgeInsets.only(bottom: h * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.04),
        border: Border.all(color: Colors.grey.shade300),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(w * 0.25),
                // child: Image.asset(
                //   "assets/image/ak.jpg",
                //   height: h * 0.08,
                //   width: h * 0.08,
                //   fit: BoxFit.cover,
                // ),
                child: Image.network("https://assets.bucketlistly.blog/sites/5adf778b6eabcc00190b75b1/content_entry5adf77af6eabcc00190b75b6/6075185986d092000b192d0a/files/best-free-travel-images-main-image-hd-op.webp",width: 100.w,),
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
                      ),
                    ),
                    SizedBox(height: h * 0.005),
                    const Text("General Physician"),
                    SizedBox(height: h * 0.005),
                    Text(
                      "22 years experience overall",
                      style: TextStyle(color: Colors.grey, fontSize: w * 0.035),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: h * 0.015),

          Row(
            children: [
              _infoTag(
                icon: Icons.thumb_up,
                text: "60%",
                w: w,
                h: h,
              ),
              SizedBox(width: w * 0.03),
              _infoTag(
                icon: Icons.star,
                text: "4.2",
                w: w,
                h: h,
              ),
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
                  child: const Center(child: Text("Contact Hospital")),
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
    );
  }

  Widget _infoTag({
    required IconData icon,
    required String text,
    required double w,
    required double h,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: w * 0.03, vertical: h * 0.008),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2F1),
        borderRadius: BorderRadius.circular(w * 0.02),
      ),
      child: Row(
        children: [
          Icon(icon, size: w * 0.045, color: Colors.teal),
          SizedBox(width: w * 0.02),
          Text(text),
        ],
      ),
    );
  }
}
