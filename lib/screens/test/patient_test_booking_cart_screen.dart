// import 'package:flutter/cupertino.dart' show CupertinoIcons;
// import 'package:flutter/material.dart';
//
// class TestBookingCart extends StatefulWidget {
//   const TestBookingCart({super.key});
//
//   @override
//   State<TestBookingCart> createState() => _TestBookingCartState();
// }
//
// class _TestBookingCartState extends State<TestBookingCart> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         foregroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(CupertinoIcons.back, size: 25),
//         ),
//         title: Text("Your test booking", style: TextStyle(color: Colors.white)),
//       ),
//
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.all(16),
//               children: [
//                 Text(
//                   "Selected tests (2)",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//                 SizedBox(height: 20),
//
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("1. "),
//                     SizedBox(width: 6),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Thyroid Profile",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             "Known as Thyroid Profile Total Blood",
//                             style: TextStyle(fontSize: 12, color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Text(
//                       "₹ 500",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 Divider(height: 30),
//
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("2. "),
//                     SizedBox(width: 6),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Liver Function Test",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             "Known as Thyroid Profile Total Blood",
//                             style: TextStyle(fontSize: 12, color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Text(
//                       "₹ 720",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: 40),
//
//                 OutlinedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   style: OutlinedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(vertical: 14),
//                     side: BorderSide(color: Colors.teal),
//                   ),
//                   child: Text(
//                     "Add more Tests",
//                     style: TextStyle(color: Colors.teal),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade100,
//               border: Border(top: BorderSide(color: Colors.grey.shade300)),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Total:"),
//                     Text(
//                       "₹1220.00",
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.teal,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.teal,
//                     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: Text(
//                     "Continue",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
