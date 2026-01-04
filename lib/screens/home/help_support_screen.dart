import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../surgery/surgery_booking_screen.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  Widget _buildTile(IconData icon, String title, String subtitle) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 26.sp, color: Colors.grey.shade800),
          SizedBox(height: 12.h),
          Text(
            title,
            maxLines: 1, // Prevent overflow in title
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6.h),
          Expanded( // Fix for subtitle overflow
            child: Text(
              subtitle,
              maxLines: 3, // Limit lines
              overflow: TextOverflow.ellipsis, // Add dots instead of overflow
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 11.sp,
                height: 1.3,
              ),
            ),
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
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Help & Support',
          style: TextStyle(color: Colors.white, fontSize: 17.sp),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 160.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/help_image.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 160.h,
                    padding: EdgeInsets.all(16.w),
                    decoration: const BoxDecoration(
                      color: Color(0x6200796B),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 45.h),
                        Text(
                          "Hey,",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "We are here to help you",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.all(18.w),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24.r,
                      backgroundColor: Colors.orange.shade100,
                      child: Icon(Icons.support_agent,
                          color: Colors.orange, size: 28.sp),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Lifeline Support",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Get instant support 24/7.",
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                color: Colors.grey.shade100,
                padding: EdgeInsets.all(18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Refund/Cancellation",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "You have 0 active refund/cancellation",
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("FAQs",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w700)),
                    SizedBox(height: 4.h),
                    Text(
                      "Get answers to the most frequently asked questions.",
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 18.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 1,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildTile(Icons.video_call_outlined, "Video Consultation",
                        "Steps for consult, Doctor or Prescription Related issues."),
                    _buildTile(Icons.science_outlined, "Lab Test Order",
                        "Delay in collection, Report Related, Order confirmation etc"),
                    _buildTile(Icons.date_range_outlined, "Clinic Appointment",
                        "Appointment cancellation, confirmation, rescheduling etc"),
                    _buildTile(Icons.medication_liquid_outlined,
                        "Medicines Order",
                        "Payment, Refund, Delivery or Order status related issues"),
                    _buildTile(Icons.card_membership_outlined,
                        "Membership Retail",
                        "Subscription benefits add or remove family members usage etc"),
                  ],
                ),
              ),

              SizedBox(height: 28.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SurgeryBookingScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff00796B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      "Chat With Us",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 35.h),
            ],
          ),
        ),
      ),
    );
  }
}
