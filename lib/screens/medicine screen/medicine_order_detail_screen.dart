import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/providers/medicine_provider/medicine_order_provider.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MedicineOrderProvider>(context,listen: false).getMedicine();
  }

  // Rating Bar Method
  Widget buildRatingBar(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          size: 23,
          color: index < rating ? Colors.green : Colors.grey,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color(0xFF00897B),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Orders', style: TextStyle(color: Colors.white)),
      ),
      body: Consumer<MedicineOrderProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return ListView.builder(
            itemCount: value.ordersDetailList.length,
            itemBuilder: (context, index) {
              var order = value.ordersDetailList[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order Code + Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            order.orderCode ?? "ORD-XXXX",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            order.orderStatus ?? "Processing",
                            style: TextStyle(
                              color:
                                  order.orderStatus == "processing"
                                      ? Colors.orange
                                      : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      // Total Amount
                      Text(
                        "Total: ₹${order.totalAmount}",
                        style: const TextStyle(fontSize: 14),
                      ),

                      const SizedBox(height: 4),

                      // Delivery Date
                      Text(
                        "Delivery: ${order.deliveryDate?.toIso8601String().split("T")[0]}",
                        style: const TextStyle(fontSize: 14),
                      ),

                      const SizedBox(height: 6),

                      // Rating (optional)
                      Row(
                        children: [
                          const Text("Rating: "),
                          ...List.generate(
                            5,
                            (i) => Icon(
                              i < (order.rating?.toInt() ?? 0)
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.green,
                              size: 20,
                            ),
                          ),
                        ],
                      ),

                      // Optional Review
                      if ((order.review ?? "").isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            "Review: ${order.review}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
