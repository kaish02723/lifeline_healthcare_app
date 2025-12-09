import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/providers/labtest_provider/book_test_provider.dart';
import 'package:lifeline_healthcare_app/widgets/animated_loader.dart';
import 'package:provider/provider.dart';

class MyTestScreen extends StatefulWidget {
  const MyTestScreen({super.key});

  @override
  State<MyTestScreen> createState() => _MyTestScreenState();
}

class _MyTestScreenState extends State<MyTestScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<BookTestProvider>(context, listen: false).getTestStatus();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff00796B),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text("My Tests", style: TextStyle(color: Colors.white)),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.04,
            vertical: h * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----------------- Top Box -----------------
              Container(
                padding: EdgeInsets.all(w * 0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Colors.orange,
                      size: 30,
                    ),
                    SizedBox(width: w * 0.03),
                    Expanded(
                      child: Text(
                        "Your test status, bookings and prescription history.",
                        style: TextStyle(fontSize: w * 0.035),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: h * 0.03),

              Consumer<BookTestProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  if (value.myLabTestList.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 240),
                        child: MedicalHeartECGLoader(
                          width: 320,
                          color: Colors.teal.shade100,
                        ),
                      ),
                    );
                  }
                  return  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: value.myLabTestList.length,
                    itemBuilder: (context, index) {
                      var testData = value.myLabTestList[index];

                      return TestCard(
                        userName: testData.user_name.toString(),
                        testName: testData.test_name.toString(),
                        phone: testData.phone.toString(),
                        category: testData.category.toString(),
                        status: testData.status.toString(),
                        userId: testData.user_id.toString(),
                      );
                    },
                  );

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// --------------------------
/// REUSABLE TEST CARD
/// --------------------------

class TestCard extends StatelessWidget {
  final String userName;
  final String testName;
  final String phone;
  final String category;
  final String status;
  final String userId;    // ⬅ ADDED
  final VoidCallback? onCancel;
  final VoidCallback? onViewReport;
  final VoidCallback? onTrackStatus;

  const TestCard({
    super.key,
    required this.userName,
    required this.testName,
    required this.phone,
    required this.category,
    required this.status,
    required this.userId,   // ⬅ ADDED
    this.onCancel,
    this.onViewReport,
    this.onTrackStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xfffefefe),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              testName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
              ),
            ),

            const SizedBox(height: 14),

            // All Details
            _buildRich("User Name", userName),
            _buildRich("User ID", userId),     // ⬅ ADDED
            _buildRich("Phone", phone),
            _buildRich("Category", category),

            const SizedBox(height: 16),

            // Status Chip + Track
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statusChip(),
                InkWell(
                  onTap: onTrackStatus,
                  child: Row(
                    children: const [
                      Icon(Icons.track_changes, color: Colors.teal, size: 20),
                      SizedBox(width: 4),
                      Text(
                        "Track",
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildRich(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label: ",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: _getStatusColor().withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _getStatusColor(), width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, color: _getStatusColor(), size: 12),
          const SizedBox(width: 6),
          Text(
            status.toUpperCase(),
            style: TextStyle(
              color: _getStatusColor(),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    if (status.toLowerCase() == "pending") {
      return ElevatedButton.icon(
        onPressed: onCancel,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        icon: const Icon(Icons.cancel, color: Colors.white),
        label: const Text(
          "Cancel Test",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      );
    }

    if (status.toLowerCase() == "completed") {
      return ElevatedButton.icon(
        onPressed: onViewReport,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
        label: const Text(
          "View Report",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      );
    }

    return const SizedBox();
  }

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case "pending":
        return Colors.orange;
      case "approved":
        return Colors.blue;
      case "completed":
        return Colors.green;
      case "cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

