// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:lifeline_healthcare_app/config/color.dart';
// import 'package:lifeline_healthcare_app/config/test_styles.dart';
// import '../../widgets/medicine_listCard.dart';
//
// class AllMedicinesScreen extends StatefulWidget {
//   const AllMedicinesScreen({super.key});
//
//   @override
//   State<AllMedicinesScreen> createState() => _AllMedicinesScreenState();
// }
//
// class _AllMedicinesScreenState extends State<AllMedicinesScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final iconColor = isDark ? Colors.white : Colors.black;
//
//     return Scaffold(
//       backgroundColor: isDark ? Colors.black : Colors.white,
//       appBar: AppBar(
//         backgroundColor: isDark ? Colors.black : Colors.white,
//         elevation: 0,
//         leading: InkWell(
//           onTap: () => Navigator.pop(context),
//           child: Icon(CupertinoIcons.arrow_left, size: 28, color: iconColor),
//         ),
//         actions: [
//           Icon(CupertinoIcons.search, color: iconColor, size: 26),
//           const SizedBox(width: 14),
//           Icon(CupertinoIcons.shopping_cart, color: iconColor, size: 26),
//           const SizedBox(width: 14),
//         ],
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// DELIVERY ADDRESS
//             Row(
//               children: [
//                 Text(
//                   "Deliver to - ",
//                   style: AppTextStyle.titleLarge.copyWith(
//                     fontSize: width * 0.045,
//                     color: iconColor,
//                   ),
//                 ),
//                 Text(
//                   "Saran",
//                   style: AppTextStyle.titleLarge.copyWith(
//                     fontWeight: FontWeight.bold,
//                     fontSize: width * 0.045,
//                     color: AppColors.colorText,
//                   ),
//                 ),
//                 Icon(
//                   CupertinoIcons.chevron_down,
//                   size: width * 0.05,
//                   color: AppColors.colorText,
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 14),
//
//             Text(
//               "All Products",
//               style: AppTextStyle.h3.copyWith(
//                 fontSize: width * 0.055,
//                 color: iconColor,
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             /// LIST PRODUCTS
//             Expanded(
//               child: ListView.separated(
//                 physics: const BouncingScrollPhysics(),
//                 itemCount: 2,
//                 separatorBuilder: (context, index) =>
//                     const SizedBox(height: 14),
//                 itemBuilder: (context, index) {
//                   return MedicineListCard(
//                     onTap: () {},
//                     image: Image.network(
//                       "https://cdn-icons-png.flaticon.com/256/4861/4861715.png",
//                       // IMPORTANT: Correct path
//                       fit: BoxFit.cover,
//                     ),
//                     title: "Centrum Multivitamin Tablets",
//                     subtitle: "Haleon India Ltd.",
//                     mrp: "MRP: ₹100",
//                     quantityBox: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 10,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         color: isDark
//                             ? Colors.grey.shade800
//                             : Colors.grey.shade200,
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: const [
//                           Icon(Icons.remove, size: 20),
//                           SizedBox(width: 8),
//                           Text("1"),
//                           SizedBox(width: 8),
//                           Icon(Icons.add, size: 20),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_medicine_cart_screen.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_medicine_details_screen.dart';

class AllMedicinesScreen extends StatefulWidget {
  const AllMedicinesScreen({super.key});

  @override
  State<AllMedicinesScreen> createState() => _AllMedicinesScreenState();
}

class _AllMedicinesScreenState extends State<AllMedicinesScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            CupertinoIcons.arrow_left,
            size: 26,
            color: Colors.black,
          ),
        ),
        actions: [
          const Icon(CupertinoIcons.search, size: 26, color: Colors.black),
          const SizedBox(width: 12),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MedicineCart(),));
          },
          icon: Icon(CupertinoIcons.cart, size: 26, color: Colors.black),),
          const SizedBox(width: 12),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Deliver Address Row
            Row(
              children: [
                Text(
                  "Deliver to - ",
                  style: TextStyle(
                      fontSize: width * 0.045, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Saran",
                  style: TextStyle(
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down, color: Colors.green),
              ],
            ),

            const SizedBox(height: 15),

            /// All Product Title
            Text(
              "All Products",
              style: TextStyle(
                fontSize: width * 0.050,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            /// PRODUCT LIST
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                separatorBuilder: (context, index) =>
                const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MedicineDetailsScreen(),));
                    },
                    child: Container(
                      padding: EdgeInsets.all(width * 0.03),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: isDark ? Colors.grey.shade900 : Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          /// PRODUCT IMAGE
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              "https://cdn-icons-png.flaticon.com/256/4861/4861715.png",
                              width: width * 0.18,
                              height: width * 0.18,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: width * 0.04),

                          /// DETAILS + BUTTON
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Centrum Multivitamin Tablets",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: width * 0.037,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Haleon India Ltd.",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: width * 0.033,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: width * 0.02),
                               Row(children: [
                                 Text(
                                   "MRP:- 100",
                                   style: TextStyle(
                                     fontSize: width * 0.035,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.black,
                                   ),
                                 ),
                                 SizedBox(width: width * 0.11),

                                 /// ADD TO CART BUTTON
                                 Container(
                                   padding: EdgeInsets.symmetric(
                                     horizontal: width * 0.05,
                                     vertical: width * 0.015,
                                   ),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                     border:
                                     Border.all(color: Colors.black, width: 1),
                                   ),
                                   child: Text(
                                     "Add to Cart",
                                     style: TextStyle(
                                       fontSize: width * 0.033,
                                       color: Colors.black,
                                     ),
                                   ),
                                 )
                               ],)
                              ],
                            ),
                          )
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
    );
  }
}
