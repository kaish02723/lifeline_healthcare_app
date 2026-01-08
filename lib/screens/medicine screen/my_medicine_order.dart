import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/widgets/animated_loader.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme_colors.dart';
import '../../../config/color.dart';
import '../../../providers/medicine_provider/medicine_order_provider.dart';
import '../../../models/medicine_models/medicine_order_modal.dart';
import 'medicine_order_detail_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MedicineOrderProvider>(
      context,
      listen: false,
    ).getMedicine(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final glass = theme.extension<AppThemeColors>()!;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: const Text("My Orders"),
        centerTitle: true,
        backgroundColor: isDark ? AppColors.primaryDark : AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: Consumer<MedicineOrderProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return SizedBox(child: Center(child: MedicalCrossLoader()));
          }
          if (provider.ordersDetailList.isEmpty) {
            return const Center(child: Text("No orders found"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: provider.ordersDetailList.length,
            itemBuilder: (context, index) {
              final order = provider.ordersDetailList[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderDetailScreen(order: order),
                    ),
                  );
                },
                child: _glassCard(
                  glass: glass,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "#${order.orderCode ?? ""}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  isDark ? AppColors.textDark : AppColors.text,
                            ),
                          ),
                          _statusChip(order.orderStatus, isDark),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Items preview
                      ...order.items!
                          .take(2)
                          .map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      imageUrl: item.image ?? "",
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color:
                                                isDark
                                                    ? AppColors.textDark
                                                    : AppColors.text,
                                          ),
                                        ),
                                        Text(
                                          "₹${item.price} × ${item.quantity}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                isDark
                                                    ? AppColors
                                                        .lightGreyTextDark
                                                    : AppColors.lightGreyText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                      if (order.items!.length > 2)
                        Text(
                          "+ ${order.items!.length - 2} more items",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.secondary,
                          ),
                        ),

                      const Divider(height: 20),

                      // Footer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total: ₹${order.totalAmount}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  isDark
                                      ? AppColors.goldenDark
                                      : AppColors.golden,
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 14),
                        ],
                      ),
                    ],
                  ),
                  context: context,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _glassCard({
    required BuildContext context,
    required AppThemeColors glass,
    required Widget child,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: glass.glassBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color:
                    isDark ? glass.borderColor : Colors.black.withOpacity(0.08),
                width: 1,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _statusChip(String? status, bool isDark) {
    final color =
        status == "processing"
            ? Colors.orange
            : status == "cancelled"
            ? Colors.red
            : Colors.green;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status ?? "",
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
