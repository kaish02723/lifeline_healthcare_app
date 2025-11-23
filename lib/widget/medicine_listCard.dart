import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare/screen/theme/color.dart';
import 'package:lifeline_healthcare/screen/theme/text_styles.dart';

class MedicineListCard extends StatelessWidget{
  final VoidCallback onTap;
  final Image image;
  final String title;
  final String subtitle;
  final String mrp;
  final Container quantityBox;
  const MedicineListCard({super.key, required this.onTap, required this.image, required this.title, required this.subtitle, required this.mrp, required this.quantityBox});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
       width: double.infinity,
       padding: const EdgeInsets.all(12),
       decoration: BoxDecoration(
         border: Border.all(width: 0.3),
         borderRadius: BorderRadius.circular(16),
           color: isDark ? Colors.grey[200] : Colors.grey[700],
           boxShadow: [
           BoxShadow(
             color: Colors.black12,
             offset: Offset(0, 3),
             blurRadius: 6,
             spreadRadius: 1,
           ),
         ]
       ),
       child:Row(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           ClipRRect(
             borderRadius: BorderRadius.circular(12),
             child: Image(
               image: image.image,
               width: 80,
               height: 80,
               fit: BoxFit.cover,
               alignment:Alignment(10, 10) ,
             ),
           ),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                  Text(
                    title,
                    style: AppTextStyle.titleLarge.copyWith(
                      color: AppColors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                 Text(
                    subtitle,
                    style: AppTextStyle.titleMedium.copyWith(
                      color: AppColors.greyText,

                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                 ),
                 const SizedBox(height: 5),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(
                       mrp,
                       style: AppTextStyle.h3.copyWith(
                         color: AppColors.black,
                       ),
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                     ),
                     quantityBox,
                   ],
                 ),
                 const SizedBox(height: 10),
               ],
             ),
           )
         ],
       ),
      ),
    );
  }}