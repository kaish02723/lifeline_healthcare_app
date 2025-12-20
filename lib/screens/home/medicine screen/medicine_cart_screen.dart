import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/app_theme_colors.dart';
import '../../../config/color.dart';
import '../../../providers/medicine_provider/medicineCart_provider.dart';
import 'medicine_checkout_screen.dart';

class MedicineCart extends StatelessWidget {
  const MedicineCart({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("My Cart"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),

      bottomNavigationBar:
          cart.items.isEmpty
              ? null
              : SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.cardDark : AppColors.card,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        color: Colors.black.withOpacity(0.12),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MedicineCheckoutScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Place Order",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

      body:
          cart.items.isNotEmpty
              ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    cart.items.isNotEmpty
                        ? _glassCard(
                          context,
                          child: ListTile(
                            leading: Icon(
                              Icons.location_on_outlined,
                              color:
                                  isDark ? AppColors.iconDark : AppColors.icon,
                            ),
                            title: Text(
                              "Deliver to",
                              style: TextStyle(
                                color:
                                    isDark
                                        ? AppColors.textDark
                                        : AppColors.text,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              "MD Jahir\nHouse 12, Delhi NCR\nPhone: 9123456789",
                              style: TextStyle(
                                color:
                                    isDark
                                        ? AppColors.lightGreyTextDark
                                        : AppColors.lightGreyText,
                              ),
                            ),
                            trailing: TextButton(
                              onPressed: () {},
                              child: Text(
                                "EDIT",
                                style: TextStyle(color: AppColors.secondary),
                              ),
                            ),
                          ),
                        )
                        : SizedBox(),

                    const SizedBox(height: 20),

                    /// 🛒 Cart Items
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cart.items.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (_, index) {
                        final item = cart.items[index];

                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item.product.medImage ?? '',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            item.product.medName ?? '',
                            style: TextStyle(
                              color:
                                  isDark ? AppColors.textDark : AppColors.text,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            item.product.medBrandName ?? '',
                            style: TextStyle(
                              color:
                                  isDark
                                      ? AppColors.lightGreyTextDark
                                      : AppColors.lightGreyText,
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "₹${item.product.medPrice}",
                                style: TextStyle(
                                  color: AppColors.golden,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              _qtyControl(context, cart, item),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              )
              : _emptyCart(context),
    );
  }

  Widget _qtyControl(BuildContext context, CartProvider cart, item) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color:
            isDark
                ? AppColors.primaryDark.withOpacity(0.15)
                : AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _qtyBtn(
            icon: Icons.remove,
            onTap: () => cart.decreaseQuantity(item.product.medId!),
            isDark: isDark,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              "${item.quantity}",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.textDark : AppColors.text,
              ),
            ),
          ),
          _qtyBtn(
            icon: Icons.add,
            onTap: () => cart.increaseQuantity(item.product.medId!),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _qtyBtn({
    required IconData icon,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        width: 22,
        height: 22,
        child: Icon(
          icon,
          size: 14,
          color: isDark ? AppColors.iconDark : AppColors.icon,
        ),
      ),
    );
  }

  Widget _glassCard(BuildContext context, {required Widget child}) {
    final theme = Theme.of(context);
    final glass = theme.extension<AppThemeColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: glass.glassBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: glass.borderColor),
              boxShadow: [BoxShadow(blurRadius: 12, color: glass.cardShadow)],
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _emptyCart(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 70,
            color: isDark ? AppColors.iconDark : AppColors.icon,
          ),
          const SizedBox(height: 16),
          Text(
            "Your cart is empty",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textDark : AppColors.text,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Add medicines to place your order",
            style: TextStyle(
              fontSize: 14,
              color:
                  isDark
                      ? AppColors.lightGreyTextDark
                      : AppColors.lightGreyText,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.pop(context); // or go to medicine list
            },
            child: const Text(
              "Browse Medicines",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
