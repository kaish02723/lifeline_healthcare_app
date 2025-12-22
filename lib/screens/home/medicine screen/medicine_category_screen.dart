import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/color.dart';
import '../../../providers/CartProvider.dart';
import '../../../providers/medicine_provider/product_provider.dart';
import 'medicine_cart_screen.dart';
import 'medicine_list_screen.dart';

class MedicineCategoryScreen extends StatefulWidget {
  const MedicineCategoryScreen({super.key});

  @override
  State<MedicineCategoryScreen> createState() =>
      _MedicineCategoryScreenState();
}

class _MedicineCategoryScreenState extends State<MedicineCategoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> trendingSearches = [
    "Paracetamol",
    "Vitamin C",
    "Pain Relief",
    "Cold & Cough",
  ];

  List<String> recentSearches = [];

  @override
  void initState() {
    super.initState();

    context.read<ProductProvider>().fetchAllMedicines();
    context.read<CartDataProvider>().loadCart(); // 🔥 SQFLite cart load

    _loadRecentSearches();
  }

  /// 🔎 Search submit
  void _onSearchSubmit(String value) {
    final query = value.trim();
    if (query.isEmpty) return;

    final provider = context.read<ProductProvider>();
    provider.searchMedicine(query);

    _saveRecentSearch(query);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AllMedicinesScreen()),
    );
  }

  /// 🔄 Load recent search
  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    recentSearches = prefs.getStringList('recent_searches') ?? [];
    setState(() {});
  }

  /// 💾 Save recent search
  Future<void> _saveRecentSearch(String value) async {
    final prefs = await SharedPreferences.getInstance();

    recentSearches.remove(value);
    recentSearches.insert(0, value);

    if (recentSearches.length > 6) {
      recentSearches = recentSearches.sublist(0, 6);
    }

    await prefs.setStringList('recent_searches', recentSearches);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 1,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),

        /// 🔍 Search box
        title: Container(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: _searchController,
            textInputAction: TextInputAction.search,
            onSubmitted: _onSearchSubmit,
            decoration: const InputDecoration(
              hintText: "Search medicine...",
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
            ),
          ),
        ),

        /// 🛒 CART ICON (SQFLITE)
        actions: [
          Consumer<CartDataProvider>(
            builder: (_, cart, __) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MedicineCart(),
                        ),
                      );
                    },
                  ),

                  if (cart.items.isNotEmpty)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          cart.items.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView(
          children: [
            /// 🕘 Recent searches
            if (recentSearches.isNotEmpty) ...[
              _sectionTitle("Recent Searches"),
              _horizontalChips(recentSearches),
              20.verticalSpace,
            ],

            /// 🔥 Trending
            _sectionTitle("Trending Searches"),
            _horizontalChips(trendingSearches),
            24.verticalSpace,

            /// 📂 Categories
            _sectionTitle("Categories"),
            12.verticalSpace,
            _categoryList(productProvider),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
    );
  }

  Widget _horizontalChips(List<String> items) {
    return SizedBox(
      height: 42.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => 10.horizontalSpace,
        itemBuilder: (_, index) {
          return ActionChip(
            label: Text(items[index]),
            onPressed: () => _onSearchSubmit(items[index]),
          );
        },
      ),
    );
  }

  Widget _categoryList(ProductProvider provider) {
    final categories = provider.availableCategories;

    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => 14.horizontalSpace,
        itemBuilder: (_, index) {
          final category = categories[index];
          final image = provider.getCategoryImage(category);

          return GestureDetector(
            onTap: () {
              provider.selectCategory(category);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AllMedicinesScreen(),
                ),
              );
            },
            child: Container(
              width: 100.w,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: image == null
                        ? const Icon(Icons.medical_services)
                        : Image.network(image, fit: BoxFit.contain),
                  ),
                  6.verticalSpace,
                  Text(
                    category.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
