import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeline_healthcare_app/providers/CartProvider.dart';
import 'package:provider/provider.dart';

import '../../../providers/medicine_provider/medicineCart_provider.dart';
import '../../../providers/medicine_provider/product_provider.dart';
import '../../../config/app_theme_colors.dart';
import 'med_image-view.dart';
import 'medicine_cart_screen.dart';

class MedicineDetailsScreen extends StatefulWidget {
  final int productId;

  const MedicineDetailsScreen({super.key, required this.productId});

  @override
  State<MedicineDetailsScreen> createState() => _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  @override
  void initState() {
    super.initState();

    /// SAVE VIEWED PRODUCT
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ProductProvider>();
      final product = provider.getProductById(widget.productId);
      if (product != null) {
        provider.addViewedProduct(product.medId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final cart = context.watch<CartDataProvider>();
    final theme = Theme.of(context);
    final colors = theme.extension<AppThemeColors>()!;

    final product = provider.getProductById(widget.productId);
    final isInCart = cart.isInCart(widget.productId);

    final viewedProducts =
        provider.viewedProducts
            .where((p) => p.medId != widget.productId)
            .toList();

    if (product == null) {
      return const Scaffold(body: Center(child: Text("Product not found")));
    }

    return Scaffold(
      backgroundColor:
          theme.brightness == Brightness.light ? Color(0xfff5f5f5) : null,
      appBar: AppBar(
        backgroundColor:
            theme.brightness == Brightness.light ? Color(0xfff5f5f5) : null,
        title: const Text("Medicine Details"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => FullImageView(imageUrl: product.medImage ?? ''),
                  ),
                );
              },
              child: Center(
                child: Container(
                  width: double.infinity,
                  height: 240.h,
                  color: Colors.white,
                  child: Image.network(
                    product.medImage ?? '',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            Text(
              product.medName ?? '',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              product.medBrandName ?? '',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.hintColor,
              ),
            ),

            SizedBox(height: 12.h),

            Row(
              children: [
                RatingBarIndicator(
                  rating: provider.rating(product),
                  itemBuilder:
                      (_, __) => const Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 18.sp,
                ),
                SizedBox(width: 6.w),
                Text("${product.medRating ?? 0}"),
              ],
            ),

            SizedBox(height: 16.h),

            Row(
              children: [
                Text(
                  "₹${product.medPrice}",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  "${product.medDiscountPercentage ?? 0}% OFF",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            /// ADD TO CART
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
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
                child: Text(isInCart ? "Go to Cart" : "Add to Cart"),
              ),
            ),

            SizedBox(height: 28.h),

            glassCard(
              colors,
              Column(
                children: [
                  infoRow("Category", product.categoryString ?? "-", theme),
                  infoRow("Type", product.medType ?? "-", theme),
                  infoRow("Pack Size", product.medPackSize ?? "-", theme),
                  infoRow(
                    "Return Policy",
                    product.medReturnPolicy ?? "-",
                    theme,
                  ),
                ],
              ),
            ),

            glassCard(
              colors,
              columnSection("Description", product.medDescription ?? "", theme),
            ),

            glassCard(
              colors,
              columnSection(
                "Product Information",
                product.medInformationManufacture ?? "",
                theme,
              ),
            ),

            glassCard(
              colors,
              columnSection("Know More", product.medKnowMore ?? "", theme),
            ),

            if (viewedProducts.isNotEmpty) ...[
              SizedBox(height: 24.h),
              Text(
                "Recently Viewed",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),

              SizedBox(
                height: 170.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: viewedProducts.length,
                  separatorBuilder: (_, __) => SizedBox(width: 12.w),
                  itemBuilder: (_, index) {
                    final item = viewedProducts[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => MedicineDetailsScreen(
                                  productId: item.medId!,
                                ),
                          ),
                        );
                      },
                      child: glassCard(
                        colors,
                        SizedBox(
                          width: 120.w,
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.network(
                                  item.medImage ?? '',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                item.medName ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// ---------- GLASS CARD ----------
  Widget glassCard(AppThemeColors colors, Widget child) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.glassBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.borderColor),
        boxShadow: [BoxShadow(color: colors.cardShadow, blurRadius: 12)],
      ),
      child: child,
    );
  }

  Widget infoRow(String title, String value, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(value, style: theme.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget columnSection(String title, String text, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(text, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
