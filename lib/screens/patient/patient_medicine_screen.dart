import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeline_healthcare_app/config/color.dart';
import 'package:lifeline_healthcare_app/config/test_styles.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_medicine_list_screen.dart';

import '../../widgets/medicineCard.dart';

class MedicineHomeScreen extends StatelessWidget {
  const MedicineHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            CupertinoIcons.back,
            color: AppColors.black,
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
              color: AppColors.black,
              size: 26.sp,
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---------- Scroll content ----------
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.h),

                      /// ================= LOCATION =================
                      Row(
                        children: [
                          Text("Deliver to -", style: AppTextStyle.titleLarge),
                          SizedBox(width: 6.w),
                          Text(
                            "Saran",
                            style: AppTextStyle.titleLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.colorText,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Icon(
                            CupertinoIcons.chevron_down,
                            size: 20.sp,
                            color: AppColors.colorText,
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h),

                      /// ================= SEARCH BAR =================
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Medicines",
                            hintStyle: AppTextStyle.titleLarge.copyWith(
                              fontWeight: FontWeight.w300,
                              color: AppColors.greyText,
                            ),
                            icon: Icon(
                              Icons.search,
                              color: AppColors.greyText,
                              size: 22.sp,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 18.h),

                      /// ================= CATEGORY TITLE =================
                      Text(
                        "Shop Health Products & Medicines",
                        style: AppTextStyle.h3.copyWith(fontSize: 20.sp),
                      ),

                      SizedBox(height: 18.h),

                      /// ================= BANNER =================
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Image.network(
                          "https://sfotechnologies.net/images/innerslider/slide-healthcare-slide1.jpg",
                          height: 160.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      SizedBox(height: 18.h),

                      /// ================= GRID ITEMS =================
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 18.h,
                          crossAxisSpacing: 12.w,
                          childAspectRatio: 0.72,
                        ),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return MedicineCard(
                            icon: CupertinoIcons.shopping_cart,
                            title: "Vitamins & supl",
                            subtitle: "₹400",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllMedicinesScreen(),
                                ),
                              );
                            },
                            imagePath:
                            "https://i.pinimg.com/474x/15/a6/82/15a6820f94afb8267af39a9dd3c7f07d.jpg",
                          );
                        },
                      ),

                      SizedBox(height: 14.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
