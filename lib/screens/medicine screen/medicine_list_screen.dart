import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/config/color.dart';
import 'package:lifeline_healthcare_app/config/test_styles.dart';
import 'package:provider/provider.dart';

import '../../../providers/medicine_provider/medicineCart_provider.dart';
import '../../../providers/medicine_provider/product_provider.dart';
import '../../../widgets/medicine_listCard.dart';
import '../../models/medicine_models/medicine_product_model.dart';
import 'medicine_cart_screen.dart';
import 'medicine_category_screen.dart';
import 'medicine_details_screen.dart';

class AllMedicinesScreen extends StatelessWidget {
  const AllMedicinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final provider = context.watch<ProductProvider>();
    final Category? selectedCategory = provider.selectedCategory;
    final products = provider.filteredProducts;
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,

      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.arrow_left,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MedicineCategoryScreen(),));
          }, icon: Icon(
            CupertinoIcons.search,
            size: 26,
            color: isDark ? Colors.white : Colors.black,
          ),),

          const SizedBox(width: 12),
          IconButton(
            icon: Icon(
              CupertinoIcons.cart,
              size: 26,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MedicineCart(),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// DELIVERY
            Row(
              children: [
                Icon(Icons.location_on, size: 20),
                SizedBox(width: 6),
                Text(
                  "Deliver to - ",
                  style: AppTextStyle.h4.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.white : AppColors.black,
                  ),
                ),
                Text(
                  "Saran",
                  style: AppTextStyle.h4.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: AppColors.secondary),
              ],
            ),

            const SizedBox(height: 16),

            /// CATEGORY TITLE (CORRECT WAY)
            Text(
              categoryValues.reverse[selectedCategory] ?? "All Medicines",
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),

            const SizedBox(height: 16),

            /// PRODUCT LIST
            Expanded(
              child: provider.isLoading
                  ? const Center(child: CupertinoActivityIndicator())
                  : products.isEmpty
                  ? const Center(child: Text("No medicines found"))
                  : ListView.separated(
                itemCount: products.length,
                separatorBuilder: (_, __) =>
                const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final isInCart = cart.isInCart(product.medId!);
                    return MedicineListCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MedicineDetailsScreen(
                              productId: product.medId!.toInt(),
                            ),
                          ),
                        );
                      },
                      imageUrl: product.medImage ?? '',
                      title: product.medName ?? '',
                      subtitle: product.medBrandName ?? '',
                      rating: provider.rating(product).toString(),
                      price: "${provider.price(product)}",
                      discount: "${provider.discount(product)}",
                      actionButton:ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isInCart
                              ? Colors.white
                              : AppColors.secondary,
                          side: BorderSide(color: AppColors.secondary),
                        ),
                        onPressed: () {
                          if (isInCart) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const MedicineCart()),
                            );
                          } else {
                            cart.addToCart(product);
                          }
                        },
                        child: Text(
                          isInCart ? "Go to Cart" : "Add to Cart",
                          style: TextStyle(
                            color: isInCart ? AppColors.secondary : Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
