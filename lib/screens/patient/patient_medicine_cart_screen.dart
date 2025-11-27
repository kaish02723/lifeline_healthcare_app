import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_medicine_list_screen.dart';

class MedicineCart extends StatefulWidget {
  const MedicineCart({super.key});

  @override
  State<MedicineCart> createState() => _MedicineCartState();
}

class _MedicineCartState extends State<MedicineCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),),
        title: Text("My cart",
            style: TextStyle(color: Colors.white, fontSize: 18.sp)),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8.w),
              children: [

                itemCard(
                    "https://cdn-icons-png.flaticon.com/256/4861/4861715.png",
                    "Celin 500mg Tablets",
                    "Glaxo Smithkline (4 unicorn)",
                    "₹43"
                ),

                20.verticalSpace,

                itemCard(
                    "https://cdn-icons-png.flaticon.com/256/4861/4861715.png",
                    "Dolo 250mg Pills",
                    "Glaxo Smithkline (4 unicorn)",
                    "₹43"
                ),

                20.verticalSpace,

                itemCard(
                    "https://cdn-icons-png.flaticon.com/256/4861/4861715.png",
                    "Kamzone U35 Tablets",
                    "Glaxo Smithkline (4 unicorn)",
                    "₹43"
                ),

                20.verticalSpace,

                itemCard(
                    "https://cdn-icons-png.flaticon.com/256/4861/4861715.png",
                    "Paracitamol 420",
                    "Glaxo Smithkline (4 unicorn)",
                    "₹43"
                ),

                25.verticalSpace,

                OutlinedButton(

                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AllMedicinesScreen(),));
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    side: const BorderSide(color: Colors.teal),
                  ),
                  child: Text("Add more items",
                      style: TextStyle(color: Colors.teal, fontSize: 15.sp)),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total: ₹172",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    Text("4 Items",
                        style:
                        TextStyle(fontSize: 15.sp, color: Colors.grey)),
                  ],
                ),

                12.verticalSpace,

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    gradient:
                    LinearGradient(colors: [Colors.teal, Colors.teal.shade700]),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text("Checkout",
                        style: TextStyle(color: Colors.white, fontSize: 17.sp)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemCard(String img, String title, String sub, String price) {
    return Row(
      children: [
        Container(
          height: 60.h,
          width: 55.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10.r),
            image: DecorationImage(image: NetworkImage(img),),
          ),
        ),

        14.horizontalSpace,

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
              4.verticalSpace,
              Text(sub, maxLines:2,style: TextStyle(fontSize: 11.sp, color: Colors.grey,
                overflow: TextOverflow.ellipsis,)),
              6.verticalSpace,
              Text(price,
                  style:
                  TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
            ],
          ),
        ),

        Container(
          height: 32.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.remove, size: 16.sp)),
              Text("2", style: TextStyle(fontSize: 14.sp)),
              IconButton(onPressed: () {}, icon: Icon(Icons.add, size: 16.sp)),
            ],
          ),
        ),
      ],
    );
  }
}
