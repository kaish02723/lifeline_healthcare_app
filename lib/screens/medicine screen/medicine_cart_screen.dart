import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme_colors.dart';
import '../../../config/color.dart';
import '../../../providers/CartProvider.dart';
import '../../providers/user_detail/User_profile_provider.dart';
import 'medicine_checkout_screen.dart';

class MedicineCart extends StatefulWidget {
  const MedicineCart({super.key});

  @override
  State<MedicineCart> createState() => _MedicineCartState();
}

class _MedicineCartState extends State<MedicineCart> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CartDataProvider>().loadCart(); // SQLite se GET
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartDataProvider>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    var provider = Provider.of<UserProfileProvider>(context);
    var userData = provider.user;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("My Cart"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      bottomNavigationBar: cart.items.isEmpty
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '₹${cart.totalAmount.toStringAsFixed(2)}  |  ',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "Order now",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: cart.items.isNotEmpty
          ? SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 12),

            // Delivery Address Section
            _glassCard(
              context,
              child: ListTile(
                leading: Icon(
                  Icons.location_on_outlined,
                  color: isDark ? AppColors.iconDark : AppColors.icon,
                ),
                title: Text(
                  "Deliver to",
                  style: TextStyle(
                    color: isDark ? AppColors.textDark : AppColors.text,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "${userData?.name}\nHouse 12, Delhi NCR\nPhone: **********",
                  style: TextStyle(
                    color: isDark
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
            ),

            const SizedBox(height: 20),

            // 🛒 Cart Items
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];

                return AnimatedContainer(
                  // key: ValueKey(item.product.medId),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[850] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Medicine Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.product.medImage ?? '',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Medicine Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.product.medName ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.product.medBrandName ?? '',
                              style: TextStyle(
                                color: isDark ? Colors.grey[400] : Colors.grey[700],
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "₹${item.product.medPrice}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Quantity + Remove Button
                      Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () => cart.decreaseQuantity(item.product.medId!),
                                color: Colors.orange,
                              ),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                transitionBuilder: (child, anim) =>
                                    ScaleTransition(scale: anim, child: child),
                                child: Text(
                                  '${item.quantity}',
                                  key: ValueKey(item.quantity),
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () => cart.increaseQuantity(item.product.medId!),
                                color: Colors.green,
                              ),
                            ],
                          ),
                          TextButton.icon(
                            onPressed: () async {
                              // Safely remove item
                              WidgetsBinding.instance.addPostFrameCallback((_) async {
                                await cart.decreaseQuantity(item.product.medId!);
                                if (item.quantity == 1) {
                                  await cart.decreaseQuantity(item.product.medId!);
                                }
                              });
                            },
                            icon: const Icon(Icons.delete, color: Colors.red, size: 18),
                            label: const Text(
                              "Remove",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
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

  Widget _qtyControl(BuildContext context, CartDataProvider cart, item,
      {required Key key}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      key: key,
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: isDark
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
              color: isDark
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
              Navigator.pop(context); // go back to medicine list
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
