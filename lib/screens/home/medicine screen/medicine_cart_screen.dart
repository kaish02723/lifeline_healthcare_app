import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeline_healthcare_app/providers/user_detail/user_detail_provider.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/medicine_provider/medicineCart_provider.dart';
import '../../../providers/medicine_provider/medicine_order_provider.dart';
import 'medicine_list_screen.dart';

class MedicineCart extends StatelessWidget {
  const MedicineCart({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final medicineOrderProvider = Provider.of<MedicineOrderProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
        ),
        title: Text(
          "My Cart",
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child:
                cart.items.isEmpty
                    ? const Center(child: Text("Cart is empty"))
                    : ListView.builder(
                      padding: EdgeInsets.all(8.w),
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        final item = cart.items[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: Row(
                            children: [
                              /// IMAGE
                              Container(
                                height: 60.h,
                                width: 55.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      item.product.medImage ?? '',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              14.horizontalSpace,

                              /// DETAILS
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.medName ?? '',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      item.product.medBrandName ?? '',
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      "₹${item.product.medPrice}",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// QUANTITY
                              Container(
                                height: 32.h,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        cart.decreaseQuantity(
                                          item.product.medId!,
                                        );
                                      },
                                    ),
                                    Text("${item.quantity}"),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        cart.increaseQuantity(
                                          item.product.medId!,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
          ),

          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total: ₹${cart.totalAmount}",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${cart.itemCount} Items",
                      style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                    ),
                  ],
                ),

                12.verticalSpace,

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    minimumSize: Size(double.infinity, 48.h),
                  ),
                  onPressed: () {
                    final cart = context.read<CartProvider>();
                    final auth = context.read<AuthProvider>();
                    final userDetail = context.read<UserDetailProvider>();
                    final orderProvider = context.read<MedicineOrderProvider>();

                    // Order object
                    final order = {
                      "order_code": orderProvider.generateOrderCode(),
                      "user_id": int.parse(auth.userId??''),
                      "name": userDetail.nameController.text, // optional
                      "total_amount": cart.totalAmount,
                      "payment_status": "paid",
                      "order_status": "processing",
                      "delivery_date":
                          DateTime.now()
                              .add(const Duration(days: 3))
                              .toIso8601String()
                              .split("T")[0],
                    };

                    // Items array
                    final items =
                        cart.items.map((item) {
                          return {
                            "medicine_id": item.product.medId,
                            "quantity": item.quantity,
                            "price": item.product.medPrice,
                          };
                        }).toList();

                    // FINAL API CALL
                    orderProvider.createFullOrder(order: order, items: items);
                  },
                  child: Text(
                    "Checkout",
                    style: TextStyle(color: Colors.white, fontSize: 17.sp),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
