import 'dart:ui';
import 'package:flutter/material.dart';

import '../patient/patient_medicine_details_screen.dart';

class SurgeryBookingScreen extends StatefulWidget {
  const SurgeryBookingScreen({super.key});

  @override
  State<SurgeryBookingScreen> createState() => _SurgeryBookingScreenState();
}

class _SurgeryBookingScreenState extends State<SurgeryBookingScreen> {
  String? selectedAilment;
  String? selectedCity;

  List<String> ailments = ["Heart", "Lungs", "Kidney", "Eyes"];
  List<String> cities = ["Mumbai", "Delhi", "Kolkata", "Patna"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6F8),

      /// ---------------- APPBAR WITH GRADIENT ----------------
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff009688), Color(0xff00796B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Book for surgery",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ---------------- HEADER ROW ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text("LifeLine ",
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    Text("HealthCare",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xffFFB956),
                            fontWeight: FontWeight.w700)),
                  ],
                ),

                /// CALL NOW BUTTON
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: const Color(0xff009688), width: 1.4),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          children: const [
                            Icon(Icons.call, size: 16, color: Color(0xff009688)),
                            SizedBox(width: 6),
                            Text("Call Now",
                                style: TextStyle(
                                    color: Color(0xff009688),
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 20),

            /// ---------------- FORM CARD ----------------
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 15,
                      offset: const Offset(0, 6))
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Book an appointment with the best doctors\nfor your health needs.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        height: 1.4),
                  ),

                  const SizedBox(height: 25),

                  /// ---------------- DROPDOWN ----------------
                  _premiumDropdown(
                    hint: "Select Ailment*",
                    value: selectedAilment,
                    items: ailments,
                    onChanged: (v) => setState(() => selectedAilment = v),
                  ),

                  const SizedBox(height: 14),

                  /// ---------------- NAME FIELD ----------------
                  _premiumTextField("Enter your name"),

                  const SizedBox(height: 14),

                  /// ---------------- PHONE FIELD ----------------
                  _premiumTextField("Phone Number",
                      keyboard: TextInputType.phone),

                  const SizedBox(height: 14),

                  /// ---------------- CITY DROPDOWN ----------------
                  _premiumDropdown(
                    hint: "City",
                    value: selectedCity,
                    items: cities,
                    onChanged: (v) => setState(() => selectedCity = v),
                  ),

                  const SizedBox(height: 22),

                  /// ---------------- BOOK BUTTON ----------------
                  _gradientButton(
                    title: "Book Appointment",
                    icon: Icons.phone,
                    onTap: () {},
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "By submitting this form, you agree to LifeLine HealthCare’s T&C",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// ---------------- DOCTOR GLASS CARD ----------------
            _glassDoctorCard(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// ----------------------------------------------------------------------
  /// PREMIUM TEXT FIELD
  /// ----------------------------------------------------------------------
  Widget _premiumTextField(String hint, {TextInputType keyboard = TextInputType.text}) {
    return Container(
      decoration: _inputDecoration(),
      child: TextField(
        keyboardType: keyboard,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade500),
        ),
      ),
    );
  }

  /// ----------------------------------------------------------------------
  /// PREMIUM DROPDOWN
  /// ----------------------------------------------------------------------
  Widget _premiumDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: _inputDecoration(),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          hint: Text(hint, style: TextStyle(color: Colors.grey.shade600)),
          value: value,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  /// ----------------------------------------------------------------------
  /// SOFT NEUMORPHIC DECORATION
  /// ----------------------------------------------------------------------
  BoxDecoration _inputDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3)),
      ],
    );
  }

  /// ----------------------------------------------------------------------
  /// GRADIENT BUTTON
  /// ----------------------------------------------------------------------
  Widget _gradientButton({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [Color(0xff009688), Color(0xff00796B)],
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.20),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  /// ----------------------------------------------------------------------
  /// GLASSMORPHISM DOCTOR CARD
  /// ----------------------------------------------------------------------
  Widget _glassDoctorCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.55),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                  color: Colors.black.withOpacity(0.01))
            ],
          ),
          child: Column(
            children: [
              /// Images
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                      radius: 26,
                      backgroundImage: AssetImage("assets/images/doctor1.png")),
                  SizedBox(width: 12),
                  CircleAvatar(
                      radius: 26,
                      backgroundImage: AssetImage("assets/images/doctor3.png")),
                  SizedBox(width: 12),
                  CircleAvatar(
                      radius: 26,
                      backgroundImage: AssetImage("assets/images/doctor2.png")),
                ],
              ),

              const SizedBox(height: 18),

              const Text(
                "Our top surgeons are ready to help you.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 4),

              const Text(
                "Available now to answer all your queries",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),

              const SizedBox(height: 16),

              /// CALL NOW BUTTON
              _gradientButton(
                title: "Call Now",
                icon: Icons.call,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MedicineDetailsScreen(),));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}





