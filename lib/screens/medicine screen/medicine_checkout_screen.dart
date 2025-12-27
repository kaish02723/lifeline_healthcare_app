import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/providers/CartProvider.dart';
import 'package:lifeline_healthcare_app/providers/user_detail/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../config/color.dart';
import '../../../config/app_theme_colors.dart';
import '../../../providers/medicine_provider/medicineCart_provider.dart';
import '../../providers/medicine_provider/medicine_order_provider.dart';
import '../../providers/user_detail/User_profile_provider.dart';
import '../../services/medicine_order_service.dart';

class MedicineCheckoutScreen extends StatefulWidget {
  const MedicineCheckoutScreen({super.key});

  @override
  State<MedicineCheckoutScreen> createState() => _MedicineCheckoutScreenState();
}

class _MedicineCheckoutScreenState extends State<MedicineCheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartDataProvider>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final glass = theme.extension<AppThemeColors>()!;
    var provider = Provider.of<UserProfileProvider>(context);
    var userData = provider.user;
    final orderProvider = Provider.of<MedicineOrderProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,

      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        backgroundColor: isDark ? AppColors.primaryDark : AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
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
                      BoxShadow(blurRadius: 14, color: glass.cardShadow),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(
                              color:
                                  isDark
                                      ? AppColors.lightGreyTextDark
                                      : AppColors.lightGreyText,
                            ),
                          ),
                          Text(
                            "₹${cart.totalAmount}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color:
                                  isDark ? AppColors.textDark : AppColors.text,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isDark
                                  ? AppColors.primaryDark
                                  : AppColors.primary,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () async {
                          if (cart.items.isEmpty) return;

                          final authProvider = Provider.of<AuthProvider>(
                            context,
                            listen: false,
                          );
                          final userId = authProvider.userId;

                          print("USER DATA: $userData");
                          print("USER NAME: ${userData?.name}");

                          try {
                            final orderCode = orderProvider.generateOrderCode();

                            await orderProvider.createFullOrder(
                              order: {
                                "order_code": orderCode,
                                "user_id": userId,
                                "total_amount": cart.totalAmount,
                                "payment_status":
                                    orderProvider.selectedPayment == "COD"
                                        ? "pending"
                                        : "paid",
                                "order_status": "processing",
                                "delivery_date":
                                    DateTime.now()
                                        .add(const Duration(days: 3))
                                        .toIso8601String()
                                        .split('T')
                                        .first,
                              },
                              items:
                                  cart.items.map((e) {
                                    return {
                                      "medicine_id": e.product.medId,
                                      "name": e.product.medName,
                                      "quantity": e.quantity,
                                      "price": e.product.medPrice,
                                    };
                                  }).toList(),
                              context: context,
                            );

                            await cart.clearCart();

                            await orderProvider.getMedicine();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green.shade900,
                                showCloseIcon: true,
                                behavior: SnackBarBehavior.floating,
                                closeIconColor: Colors.white,
                                content: Text(
                                  "Order placed successfully",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );

                            Navigator.pushReplacementNamed(
                              context,
                              '/dashboard',
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red.shade900,
                                showCloseIcon: true,
                                behavior: SnackBarBehavior.floating,
                                closeIconColor: Colors.white,
                                content: Text(
                                  "Order failed: $e",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }
                        },

                        child: Text(
                          orderProvider.selectedPayment == 'COD'
                              ? "Place Order"
                              : "Pay & Place Order",
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _glassCard(
            context,
            child: ListTile(
              leading: Icon(
                Icons.location_on_outlined,
                color: isDark ? AppColors.iconDark : AppColors.icon,
              ),
              title: Text(
                "Delivery Address",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.textDark : AppColors.text,
                ),
              ),
              subtitle: Text(
                "${userData?.name}\nHouse 12, Delhi NCR\nPhone: **********",
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
                  "CHANGE",
                  style: TextStyle(
                    color:
                        isDark ? AppColors.secondaryDark : AppColors.secondary,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          _glassCard(
            context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Summary",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textDark : AppColors.text,
                  ),
                ),
                const SizedBox(height: 12),
                ...cart.items.map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${e.product.medName} x${e.quantity}",
                            style: TextStyle(
                              color:
                                  isDark
                                      ? AppColors.greyTextDark
                                      : AppColors.greyText,
                            ),
                          ),
                        ),
                        Text(
                          "₹${e.product.medPrice}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color:
                                isDark
                                    ? AppColors.goldenDark
                                    : AppColors.golden,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        color: isDark ? AppColors.textDark : AppColors.text,
                      ),
                    ),
                    Text(
                      "₹${cart.totalAmount}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          _glassCard(
            context,
            child: Column(
              children: [
                RadioListTile(
                  value: 'COD',
                  groupValue: orderProvider.selectedPayment,
                  activeColor:
                      isDark ? AppColors.primaryDark : AppColors.primary,
                  title: Text(
                    "Cash on Delivery",
                    style: TextStyle(
                      color: isDark ? AppColors.textDark : AppColors.text,
                    ),
                  ),
                  onChanged: (value) {
                    orderProvider.changePaymentMethod(value!);
                  },
                ),
                RadioListTile(
                  value: 'ONLINE',
                  groupValue: orderProvider.selectedPayment,
                  activeColor:
                      isDark ? AppColors.primaryDark : AppColors.primary,
                  title: Text(
                    "Online Payment",
                    style: TextStyle(
                      color: isDark ? AppColors.textDark : AppColors.text,
                    ),
                  ),
                  onChanged: (value) {
                    orderProvider.changePaymentMethod(value!);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassCard(BuildContext context, {required Widget child}) {
    final theme = Theme.of(context);
    final glass = theme.extension<AppThemeColors>()!;
    final isDark = theme.brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: glass.glassBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: glass.borderColor),
          ),
          child: child,
        ),
      ),
    );
  }
}
