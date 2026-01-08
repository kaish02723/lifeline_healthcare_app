import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/providers/CartProvider.dart';
import 'package:lifeline_healthcare_app/providers/payment_provider/payment_provider.dart';
import 'package:lifeline_healthcare_app/widgets/animated_loader.dart';
import 'package:provider/provider.dart';

import '../../../config/color.dart';
import '../../../config/app_theme_colors.dart';
import '../../providers/medicine_provider/medicine_order_provider.dart';
import '../../providers/user_detail/User_profile_provider.dart';
import 'medicine_order_detail_screen.dart';

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
    final razorpay=Provider.of<PaymentProvider>(context,listen: false);

    return Stack(
      children: [
        Scaffold(
          backgroundColor:
              isDark ? AppColors.backgroundDark : AppColors.background,
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
                                      isDark
                                          ? AppColors.textDark
                                          : AppColors.text,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          isDark ? AppColors.primaryDark : AppColors.primary,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: orderProvider.isCreatingOrder ? null : () async {
                          if (cart.items.isEmpty) return;

                          /// DEBUG
                          for (var e in cart.items) {
                            debugPrint("====== CART ITEM ======");
                            debugPrint("medId      => ${e.product.medId}");
                            debugPrint("name       => ${e.product.medName}");
                            debugPrint("price      => ${e.product.medPrice}");
                            debugPrint("quantity   => ${e.quantity}");
                          }
                          /// 🟢 CASE 1 : CASH ON DELIVERY
                          /// ================================
                          if (orderProvider.selectedPayment == "COD") {
                            try {
                              final orderId= await orderProvider.createFullOrder(
                                order: {
                                  "total_amount": cart.totalAmount,
                                  "payment_status": "pending",   // COD
                                  "order_status": "processing",
                                  "delivery_date": DateTime.now()
                                      .add(const Duration(days: 3))
                                      .toIso8601String()
                                      .split('T')
                                      .first,
                                },
                                items: cart.items.map((e) => {
                                  "medicine_id": e.product.medId,
                                  "name": e.product.medName,
                                  "quantity": e.quantity,
                                  "price": e.product.medPrice,
                                  "image": e.product.medImage,
                                }).toList(),
                                context: context,
                              );
                              razorpay.startPayment(
                                  context,
                                  "medicine",              // service_type
                                  orderId.toString(),      // ✅ REAL service_id
                                  cart.totalAmount.toInt(),
                                  "COD",
                                  //
                                  ()async{
                                    await cart.clearCart();
                                    if (!mounted) return;

                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      '/my-order',
                                          (route) => false,
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Congratulations! Order placed Cash On Delivery")),);
                                  },
                                  /// ❌ PAYMENT FAILED
                                    (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error)),
                                  );
                                },
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Order failed: $e")),
                              );
                            }
                          }
                          /// CASE 2 : ONLINE PAYMENT
                          else {
                            try {
                              /// 1️⃣ STEP: Create order FIRST (payment pending)
                              final int orderId = await orderProvider.createFullOrder(
                                order: {
                                  "total_amount": cart.totalAmount,
                                  "payment_status": "pending", //  important
                                  "order_status": "processing",
                                  "payment_method": "Online", // ✅ FIX (THIS WAS MISSING)
                                },
                                items: cart.items.map((e) {
                                  return {
                                    "medicine_id": e.product.medId,
                                    "name": e.product.medName,
                                    "quantity": e.quantity,
                                    "price": e.product.medPrice,
                                    "image": e.product.medImage,
                                  };
                                }).toList(),
                                context: context,
                              );

                              /// 2️⃣ STEP: Start Razorpay using SAME orderId
                              razorpay.startPayment(
                                context,
                                "medicine",              // service_type
                                orderId.toString(),      // ✅ REAL service_id
                                cart.totalAmount.toInt(),
                                "Online",
                                /// ✅ PAYMENT SUCCESS
                                    () async {
                                  await cart.clearCart();
                                  if (!mounted) return;

                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/my-order',
                                        (route) => false,
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Payment & Order successful"),
                                    ),
                                  );
                                },
                                /// ❌ PAYMENT FAILED
                                    (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error)),
                                  );
                                },
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Order failed: $e")),
                              );
                            }
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
                      )

                      // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor:
                          //         isDark
                          //             ? AppColors.primaryDark
                          //             : AppColors.primary,
                          //     minimumSize: const Size(double.infinity, 50),
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(14),
                          //     ),
                          //   ),
                          //   onPressed: orderProvider.isCreatingOrder ? null : () async {
                          //             if (cart.items.isEmpty) return;
                          //             try {
                          //               await orderProvider.createFullOrder(
                          //                 order: {
                          //                   "total_amount": cart.totalAmount,
                          //                   "payment_status":
                          //                       orderProvider.selectedPayment ==
                          //                               "COD"
                          //                           ? "pending"
                          //                           : "paid",
                          //                   "order_status": "processing",
                          //                   "delivery_date":
                          //                       DateTime.now()
                          //                           .add(
                          //                             const Duration(days: 3),
                          //                           )
                          //                           .toIso8601String()
                          //                           .split('T')
                          //                           .first,
                          //                 },
                          //                 items:
                          //                     cart.items.map((e) {
                          //                       return {
                          //                         "medicine_id":
                          //                             e.product.medId,
                          //                         "name": e.product.medName,
                          //                         "quantity": e.quantity,
                          //                         "price": e.product.medPrice,
                          //                         "image": e.product.medImage,
                          //                       };
                          //                     }).toList(),
                          //                 context: context,
                          //               );
                          //               await cart.clearCart();
                          //               await Future.delayed(
                          //                 const Duration(milliseconds: 300),
                          //               );
                          //               if (!mounted) return;
                          //               Navigator.pushNamedAndRemoveUntil(
                          //                 context,
                          //                 '/dashboard',
                          //                 (route) => false,
                          //               );
                          //               ScaffoldMessenger.of(
                          //                 context,
                          //               ).showSnackBar(
                          //                 SnackBar(
                          //                   backgroundColor:
                          //                       Colors.green.shade900,
                          //                   showCloseIcon: true,
                          //                   closeIconColor: Colors.white,
                          //                   behavior: SnackBarBehavior.floating,
                          //                   content: const Text(
                          //                     "Order placed successfully",
                          //                   ),
                          //                 ),
                          //               );
                          //             } catch (e) {
                          //               if (!mounted) return;
                          //               ScaffoldMessenger.of(
                          //                 context,
                          //               ).showSnackBar(
                          //                 SnackBar(
                          //                   showCloseIcon: true,
                          //                   closeIconColor: Colors.white,
                          //                   behavior: SnackBarBehavior.floating,
                          //                   backgroundColor:
                          //                       Colors.red.shade900,
                          //                   content: Text("Order failed: $e"),
                          //                 ),
                          //               );
                          //             }
                          //           },
                          //   child: Text(
                          //     orderProvider.selectedPayment == 'COD'
                          //         ? "Place Order"
                          //         : "Pay & Place Order",
                          //     style: const TextStyle(
                          //       fontSize: 16,
                          //       color: AppColors.white,
                          //     ),
                          //   ),
                          // ),

                        ],
                      ),
                    ),
                  ),

          body: ListView(padding: const EdgeInsets.all(16),
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
                            isDark
                                ? AppColors.secondaryDark
                                : AppColors.secondary,
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
        ),
        Consumer<MedicineOrderProvider>(
          builder: (context, orderProvider, _) {
            if (!orderProvider.isCreatingOrder) return const SizedBox();

            return Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                  child: Center(child: MedicalCrossLoader()),
                ),
              ),
            );
          },
        ),
      ],
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
