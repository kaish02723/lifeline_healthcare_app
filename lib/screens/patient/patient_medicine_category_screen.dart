// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class MedicineCategoryScreen extends StatelessWidget {
//   MedicineCategoryScreen({super.key});
//
//   final TextEditingController searchController = TextEditingController();
//
//   final List<Map<String, String>> categories = [
//     {
//       "name": "Covid Essentials",
//       "image": "https://cdn-icons-png.flaticon.com/512/9284/9284053.png",
//     },
//     {"name": "Skin Care", "image": "https://i.imgur.com/72pT0Aa.png"},
//     {
//       "name": "Vitamins and Minerals",
//       "image": "https://i.imgur.com/eVE8T0j.png",
//     },
//     {"name": "Sexual Wellness", "image": "https://i.imgur.com/0ZpG3uS.png"},
//     {
//       "name": "Health Food & Drinks",
//       "image": "https://i.imgur.com/lvg6T1o.png",
//     },
//     {"name": "Baby Care", "image": "https://i.imgur.com/TlSUB4P.png"},
//     {"name": "Pain Relief", "image": "https://i.imgur.com/cUrP2q7.png"},
//     {"name": "Diabetic Care", "image": "https://i.imgur.com/5xz8rST.png"},
//     {
//       "name": "Protein & Supplements",
//       "image": "https://i.imgur.com/olM0ZjE.png",
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(CupertinoIcons.back, color: Colors.black87),
//         ),
//         title: const Text(
//           "Lifeline Pharmacy",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
//         ),
//         actions: const [
//           Icon(Icons.shopping_cart_outlined, color: Colors.black),
//           SizedBox(width: 16),
//         ],
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 10),
//
//             //  Search Bar (Glassy)
//             _buildSearchBar(),
//
//             const SizedBox(height: 25),
//
//             const Text(
//               "Shop Health Products By\nCategories",
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black,
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             Expanded(
//               child: GridView.builder(
//                 itemCount: categories.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: width < 350 ? 2 : 3, // responsive
//                   crossAxisSpacing: 15,
//                   mainAxisSpacing: 20,
//                   childAspectRatio: 0.82,
//                 ),
//                 itemBuilder: (context, index) {
//                   return _buildCategoryCard(
//                     context,
//                     categories[index]["name"]!,
//                     categories[index]["image"]!,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSearchBar() {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(15),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//         child: Container(
//           height: 50,
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.55),
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(color: Colors.black12),
//           ),
//           child: Row(
//             children: [
//               const Icon(Icons.search, color: Colors.black54),
//
//               const SizedBox(width: 10),
//
//               Expanded(
//                 child: TextField(
//                   controller: searchController,
//                   cursorColor: Colors.black,
//                   style: const TextStyle(
//                     fontSize: 15,
//                     color: Colors.black87,
//                     fontWeight: FontWeight.w500,
//                   ),
//                   decoration: const InputDecoration(
//                     hintText: "Search Medicines & Health Products",
//                     hintStyle: TextStyle(color: Colors.black54, fontSize: 15),
//                     border: InputBorder.none,
//                   ),
//                   onChanged: (value) {
//                     print("Searching: $value"); // ← later filter yaha hoga
//                   },
//                 ),
//               ),
//
//               // Clear button
//               if (searchController.text.isNotEmpty)
//                 GestureDetector(
//                   onTap: () {
//                     searchController.clear();
//                   },
//                   child: const Icon(
//                     Icons.close,
//                     size: 18,
//                     color: Colors.black45,
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ------------------------------------------------------
//   //  Glass Category Card
//   Widget _buildCategoryCard(
//     BuildContext context,
//     String title,
//     String imageUrl,
//   ) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => MedicineCategoryScreen()),
//         );
//       },
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.5),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: Colors.black12),
//               boxShadow: [
//                 BoxShadow(
//                   blurRadius: 10,
//                   color: Colors.black12,
//                   offset: Offset(2, 3),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.network(imageUrl, height: 55, fit: BoxFit.contain),
//                 const SizedBox(height: 12),
//                 Text(
//                   title,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 14.5,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ------------------------------------------------------
// //  Category → Medicines List Filter Screen
// class CategoryMedicineListScreen extends StatelessWidget {
//   final String categoryName;
//
//   const CategoryMedicineListScreen({super.key, required this.categoryName});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(categoryName)),
//       body: Center(child: Text("Filter medicines for: $categoryName")),
//     );
//   }
// }
