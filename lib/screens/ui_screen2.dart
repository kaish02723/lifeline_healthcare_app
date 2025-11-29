import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/screens/ui_screen3.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  Widget _buildTile(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 26, color: Colors.grey.shade800),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12, height: 1.3),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff00796B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Help & Support', style: TextStyle(color: Colors.white)),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOP BANNER
              Stack(
                children: [
// Background Image
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/help_image.png'), // your image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),


// Green overlay + text
                  Container(
                    width: double.infinity,
                    height: 150,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color(0x6200796B), // Transparent overlay
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 50),
                        Text(
                          "Hey,",
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "We are here to help you",
                          style: TextStyle(color: Colors.white, fontSize: 16, height: 1.3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // SUPPORT CARD
              Container(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.orange.shade100,
                      child: const Icon(Icons.support_agent, color: Colors.orange, size: 30),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Lifeline Support",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Get instant support 24/7.",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Refund Section
              Container(
                width: double.infinity,
                color: Colors.grey.shade100,
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Refund/Cancellation",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "You have 0 active refund/cancellation",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "FAQs",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Get answers to the most frequently asked questions.",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // GRID MENU
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildTile(Icons.video_call_outlined, "Video Consultation",
                        "Steps for consult, Doctor or Prescription Related issues."),

                    _buildTile(Icons.science_outlined, "Lab Test Order",
                        "Delay in collection, Report Related, Order confirmation etc"),

                    _buildTile(Icons.date_range_outlined, "Clinic Appointment",
                        "Appointment cancellation, confirmation, rescheduling etc"),

                    _buildTile(Icons.medication_liquid_outlined, "Medicines Order",
                        "Payment, Refund, Delivery or Order status related issues"),

                    _buildTile(Icons.card_membership_outlined, "Membership Retail",
                        "Subscription benefits add or remove family members usage etc"),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Chat Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SurgeryBookingScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff00796B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Chat With Us",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
