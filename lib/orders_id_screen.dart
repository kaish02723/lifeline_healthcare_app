import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrdersIdScreen extends StatefulWidget {
  const OrdersIdScreen({super.key});

  @override
  State<OrdersIdScreen> createState() => _OrdersIdScreenState();
}

class _OrdersIdScreenState extends State<OrdersIdScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back, color: Colors.white),

          title: Text(
            "Order ID: 543234",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          backgroundColor: Colors.teal,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  "Help",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),

        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(Icons.local_hospital_sharp, color: Colors.teal),
                      ),
                      SizedBox(width: 12),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order placed with Lifeline healthCare",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Dec 06, 12:36 pm",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.home, size: 30, color: Colors.grey.shade500),

                      SizedBox(width: 12),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "HOME",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "Patna, Patna, Bihar, India",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Delivery By Dec 08",
                            style: TextStyle(color: Colors.grey.shade900),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment Details",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(height: 16),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Expanded(
                        child: Text(
                          ". 1 x DETTOL ANTISEPTIC LIQUID 250ML",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),


                      Text("₹ 159.38", style: TextStyle(fontSize: 14)),
                    ],
                  ),


                  SizedBox(height: 12),


                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          ". 7 x ZINCOVIT TABLET\nCovid_essentials 15'S",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Text("₹ 102.15", style: TextStyle(fontSize: 14)),
                    ],
                  ),

                  SizedBox(height: 12),
                  Divider(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total MRP", style: TextStyle(fontSize: 14)),
                      Text("₹ 261.53", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("To Pay", style: TextStyle(fontSize: 14)),
                      Text("₹ 874.43", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Container(
                padding: EdgeInsets.only(left: 20,right: 15,top: 10,bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Pay ₹ 874.43 cash to our delivery partner on receiving your medicines.",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Icon(Icons.receipt_long_rounded, size: 25, color: Colors.red),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
