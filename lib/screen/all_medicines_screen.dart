import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare/screen/theme/color.dart';
import 'package:lifeline_healthcare/screen/theme/text_styles.dart';
import 'package:lifeline_healthcare/widget/medicine_listCard.dart';

class AllMedicinesScreen extends StatefulWidget {
  const AllMedicinesScreen({super.key});

  @override
  State<AllMedicinesScreen> createState() => _AllMedicinesScreenState();
}

class _AllMedicinesScreenState extends State<AllMedicinesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          leading: Icon(
            CupertinoIcons.arrow_left,
            color: AppColors.black,
            size: 30,
          ),
          actions: [
            Icon(CupertinoIcons.search, color: AppColors.black, size: 30),
            const SizedBox(width: 5),
            Icon(
              CupertinoIcons.shopping_cart,
              color: AppColors.black,
              size: 30,
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(height: 16),
                  Text("Deliver to -", style: AppTextStyle.titleLarge),
                  const SizedBox(width: 5),
                  Text(
                    "Saran",
                    style: AppTextStyle.titleLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.colorText,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    CupertinoIcons.chevron_down,
                    size: 20,
                    color: AppColors.colorText,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text("All Products", style: AppTextStyle.h3),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: 10,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return MedicineListCard(
                      onTap: () {},
                      image: Image.asset("asset/images/img.png"),
                      title: "Centrum Multivitamin Tablets",
                      subtitle: "Haleon India Ltd.",
                      mrp: "MRP:- 100",
                      quantityBox: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.grey.shade200,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.remove, size: 20),
                            SizedBox(width: 6),
                            Text("1"),
                            SizedBox(width: 6),
                            Icon(Icons.add, size: 20),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
