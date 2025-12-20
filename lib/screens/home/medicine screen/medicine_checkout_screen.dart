import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/medicine_provider/medicineCart_provider.dart';

class MedicineCheckoutScreen extends StatefulWidget {
  const MedicineCheckoutScreen({super.key});

  @override
  State<MedicineCheckoutScreen> createState() =>
      _MedicineCheckoutScreenState();
}

class _MedicineCheckoutScreenState extends State<MedicineCheckoutScreen> {
  String selectedPayment = 'COD';

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () {
              // 🔥 FINAL ORDER API
              // provider.placeOrder(...)
            },
            child: Text(
              selectedPayment == 'COD'
                  ? "Place Order"
                  : "Pay & Place Order",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// 📍 Address
          _glassCard(
            isDark,
            child: ListTile(
              title: const Text("Delivery Address"),
              subtitle: const Text(
                "MD Jahir\nHouse 12, Delhi NCR\nPhone: 9123456789",
              ),
              trailing: TextButton(
                onPressed: () {},
                child: const Text("CHANGE"),
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// 📦 Order Summary
          _glassCard(
            isDark,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Order Summary",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Divider(),
                ...cart.items.map(
                      (e) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${e.product.medName} x${e.quantity}"),
                      Text("₹${e.product.medPrice}"),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total"),
                    Text(
                      "₹${cart.totalAmount}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// 💳 Payment
          _glassCard(
            isDark,
            child: Column(
              children: [
                RadioListTile(
                  value: 'COD',
                  groupValue: selectedPayment,
                  title: const Text("Cash on Delivery"),
                  onChanged: (v) => setState(() => selectedPayment = v!),
                ),
                RadioListTile(
                  value: 'ONLINE',
                  groupValue: selectedPayment,
                  title: const Text("Online Payment"),
                  onChanged: (v) => setState(() => selectedPayment = v!),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassCard(bool isDark, {required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
          ),
          child: child,
        ),
      ),
    );
  }
}
