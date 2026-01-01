import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/providers/medicine_provider/medicine_order_provider.dart';
import 'package:provider/provider.dart';

import '../../config/color.dart';
import '../../models/medicine_models/medicine_order_modal.dart';

class OrderDetailScreen extends StatefulWidget {
  final MedicineOrderModal order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: const Text("Order Details"),
        backgroundColor: isDark ? AppColors.primaryDark : AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _medicineList(isDark),
          const SizedBox(height: 16),
          _orderHeader(isDark),
          const SizedBox(height: 16),

          _orderSummary(isDark),
          const SizedBox(height: 24),
          if (_canCancelOrder()) _cancelOrderButton(context, isDark),
        ],
      ),
    );
  }

  Widget _orderHeader(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.card,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order #${widget.order.orderCode ?? ""}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDark ? AppColors.textDark : AppColors.text,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Ordered on ${widget.order.orderedAt?.toLocal().toString().split(" ")[0]}",
                style: TextStyle(
                  fontSize: 12,
                  color:
                      isDark
                          ? AppColors.lightGreyTextDark
                          : AppColors.lightGreyText,
                ),
              ),
            ],
          ),
          _statusChip(),
        ],
      ),
    );
  }

  Widget _statusChip() {
    Color color;
    switch (widget.order.orderStatus) {
      case "processing":
        color = Colors.orange;
        break;
      case "delivered":
        color = Colors.green;
        break;
      case "cancelled":
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        widget.order.orderStatus?.toUpperCase() ?? "",
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _medicineList(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Medicines",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDark ? AppColors.textDark : AppColors.text,
          ),
        ),
        const SizedBox(height: 8),
        ...widget.order.items!.map(
          (item) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : AppColors.card,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    imageUrl: item.image ?? "",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.textDark : AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "₹${item.price} × ${item.quantity}",
                        style: TextStyle(
                          fontSize: 13,
                          color:
                              isDark
                                  ? AppColors.lightGreyTextDark
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
      ],
    );
  }

  Widget _orderSummary(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.card,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Summary",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isDark ? AppColors.textDark : AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          _summaryRow("Total Amount", "₹${widget.order.totalAmount}", isDark),
          _summaryRow(
            "Payment Status",
            widget.order.paymentStatus ?? "",
            isDark,
          ),
          _summaryRow(
            "Delivery Date",
            widget.order.deliveryDate?.toString().split(" ")[0] ?? "",
            isDark,
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color:
                  isDark
                      ? AppColors.lightGreyTextDark
                      : AppColors.lightGreyText,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textDark : AppColors.text,
            ),
          ),
        ],
      ),
    );
  }

  bool _canCancelOrder() {
    return widget.order.orderStatus == "processing";
  }

  Widget _cancelOrderButton(BuildContext context, bool isDark) {
    return Consumer<MedicineOrderProvider>(
      builder: (BuildContext context, orderProvider, Widget? child) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: () {
            if (widget.order.orderId == null) return;

            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Cancel Order"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Please enter reason for cancelling the order:",
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: orderProvider.reasonController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Enter reason...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () async {
                        final reason =
                            orderProvider.reasonController.text.trim();
                        if (reason.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter a reason"),
                            ),
                          );
                          return;
                        }

                        Navigator.pop(context);

                        try {
                          await orderProvider.cancelOrder(
                            context,
                            widget.order.orderId!,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Order cancelled successfully"),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Failed to cancel order: $e"),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Cancel Order",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text(
            "Cancel Order",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        );
      },
    );
  }
}
