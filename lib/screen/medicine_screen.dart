import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare/screen/theme/color.dart';
import 'package:lifeline_healthcare/screen/theme/text_styles.dart';

import '../widget/medicineCard.dart';
import 'all_medicines_screen.dart';


class MedicineHomeScreen extends StatelessWidget {
  const MedicineHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(CupertinoIcons.arrow_left,color: AppColors.black,size: 30,),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AllMedicinesScreen(),));
                    },
                    icon: Icon(CupertinoIcons.shopping_cart,color: AppColors.black,size: 30, )
                  )
                ],
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text("Deliver to -",
                              style: AppTextStyle.titleLarge.copyWith(
                                color: AppColors.text
                              )
                          ),
                          const SizedBox(width: 5,),
                          Text("Saran",
                            style: AppTextStyle.titleLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.colorText
                            )
                          ),
                          const SizedBox(width: 5,),
                          Icon(CupertinoIcons.chevron_down,size:20,color: AppColors.colorText,)
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Medicines",
                            hintStyle: AppTextStyle.titleLarge.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.greyText
                            ),
                            icon: Icon(Icons.search,
                                color: AppColors.greyText
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "Shop Health Products By Categories",
                        style: AppTextStyle.h3.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.greyText
                        ),
                      ),

                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                        child: Image(image: AssetImage("asset/images/big_medicine.png"),fit: BoxFit.fill,),
                      ),
                      const SizedBox(height: 10,),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.95,
                        ),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return MedicineCard(
                            image: Image.asset("asset/images/img.png"),
                            icon: CupertinoIcons.shopping_cart,
                            title: "Vitamins & supl",
                            subtitle: "₹400",
                            onTap:() {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>AllMedicinesScreen()));
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
