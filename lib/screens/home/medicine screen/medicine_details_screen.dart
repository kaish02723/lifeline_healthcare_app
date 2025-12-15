import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/color.dart';
import '../../../config/test_styles.dart';
import '../../../providers/medicine_provider/medicineCart_provider.dart';
import '../../../providers/medicine_provider/product_provider.dart';
import 'med_image-view.dart';
import 'medicine_cart_screen.dart';

class MedicineDetailsScreen extends StatefulWidget {
  final int productId;

  const MedicineDetailsScreen({
    super.key,
    required this.productId,
  });

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
    final cart = context.watch<CartProvider>();

    final product = provider.getProductById(widget.productId);
    final isInCart = cart.isInCart(widget.productId);
    final viewedProducts = provider.viewedProducts;

    if (product == null) {
      return const Scaffold(
        body: Center(child: Text("Product not found")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Product Details"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MedicineCart()),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// IMAGE (CLICK → ZOOM)
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FullImageView(
                        imageUrl: product.medImage ?? '',
                      ),
                    ),
                  );
                },
                child: Image.network(
                  product.medImage ?? '',
                  height: 220,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// NAME
            Text(
              product.medName ?? '',
              style: AppTextStyle.h1,
            ),

            /// BRAND
            Text(
              product.medBrandName ?? '',
              style: AppTextStyle.bodyLarge.copyWith(color: Colors.grey),
            ),

            const SizedBox(height: 10),

            /// RATING ⭐
            Row(
              children: [
                RatingBarIndicator(
                  rating: provider.rating(product),
                  itemBuilder: (_, __) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20,
                ),
                const SizedBox(width: 6),
                Text("${product.medRating ?? 0}"),
              ],
            ),

            const SizedBox(height: 16),

            /// PRICE + DISCOUNT
            Row(
              children: [
                Text(
                  "₹${product.medPrice}",
                  style: AppTextStyle.h1,
                ),
                const SizedBox(width: 10),
                Text(
                  "${product.medDiscountPercentage ?? 0}% OFF",
                  style: AppTextStyle.h3.copyWith(color: AppColors.secondary),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// ADD / GO TO CART
            ElevatedButton(
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

            const SizedBox(height: 30),

            /// PRODUCT INFO
            sectionTitle("Product Information"),
            sectionText(product.medInformationManufacture ?? ''),

            const SizedBox(height: 20),

            sectionTitle("Know More"),
            sectionText(product.medKnowMore ?? ''),

            const SizedBox(height: 30),

            /// RECENTLY VIEWED PRODUCTS
            if (viewedProducts.isNotEmpty) ...[
              sectionTitle("Recently Viewed"),
              const SizedBox(height: 12),

              SizedBox(
                height: 170,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: viewedProducts.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final item = viewedProducts[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MedicineDetailsScreen(
                              productId: item.medId!,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 120,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.network(
                                item.medImage ?? '',
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item.medName ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
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

  Widget sectionTitle(String title) {
    return Text(title, style: AppTextStyle.h2);
  }

  Widget sectionText(String text) {
    return Text(
      text,
      style: AppTextStyle.bodyMedium.copyWith(height: 1.5),
    );
  }
}
