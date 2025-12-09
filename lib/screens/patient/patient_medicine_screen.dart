import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeline_healthcare_app/config/color.dart';
import 'package:lifeline_healthcare_app/config/test_styles.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_medicine_details_screen.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_medicine_list_screen.dart';
import '../../widgets/medicineCard.dart';

class MedicineHomeScreen extends StatelessWidget {
  const MedicineHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Color(0xff121212) : Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark ? Colors.black : Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            CupertinoIcons.back,
            color: isDark ? Colors.white : AppColors.black,
            size: 26.sp,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllMedicinesScreen()),
              );
            },
            icon: Icon(
              CupertinoIcons.shopping_cart,
              color: isDark ? Colors.white : AppColors.black,
              size: 26.sp,
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h),
                // Deliver to
                Row(
                  children: [
                    Text(
                      "Deliver to -",
                      style: AppTextStyle.titleLarge.copyWith(
                        color: isDark ? Colors.white70 : AppColors.black,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      "Saran",
                      style: AppTextStyle.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.colorText,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      CupertinoIcons.chevron_down,
                      size: 18.sp,
                      color: isDark ? Colors.white70 : AppColors.colorText,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                // Search Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(40.r),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      color: isDark
                          ? Colors.white.withOpacity(0.05)
                          : Colors.white.withOpacity(0.8),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search Medicines",
                          hintStyle: AppTextStyle.titleLarge.copyWith(
                            fontWeight: FontWeight.w300,
                            color: isDark ? Colors.white54 : AppColors.greyText,
                          ),
                          icon: Icon(
                            Icons.search,
                            color: isDark ? Colors.white54 : AppColors.greyText,
                            size: 22.sp,
                          ),
                        ),
                        cursorColor: Color(0xff00796B),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 22.h),
                // Title
                Text(
                  "Shop Health Products & Medicines",
                  style: AppTextStyle.h3.copyWith(
                    fontSize: 20.sp,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                SizedBox(height: 18.h),
                // Banner Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.network(
                    "https://sfotechnologies.net/images/innerslider/slide-healthcare-slide1.jpg",
                    height: 130.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 22.h),
                // Medicines Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18.h,
                    crossAxisSpacing: 14.w,
                    childAspectRatio: 0.70,
                  ),
                  itemBuilder: (context, index) {
                    return MedicineCard(
                      icon: CupertinoIcons.shopping_cart,
                      title: "MuscleBlaze Whey Protein for gym",
                      subtitle: "₹1400",
                      imagePath:
                          "https://m.media-amazon.com/images/I/71Kg39130xL.jpg",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MedicineDetailsScreen(),
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
