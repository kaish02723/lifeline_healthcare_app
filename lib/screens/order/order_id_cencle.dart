import 'package:flutter/material.dart';

class OrderIdTrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: Icon(Icons.arrow_back, color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order ID: 1597662",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              "View Details",
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Text(
                            "Help",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 20),

                          /// Support Button
                          SizedBox(
                            width: double.infinity,

                            child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor:Colors.teal),
                              onPressed: () {
                                Navigator.pop(context);
                                // Yaha apna support screen navigate karna
                                // Navigator.push(context, MaterialPageRoute(builder: (_) => SupportPage()));
                              },
                              child: Text("Help & Support",style: TextStyle(fontSize: 17,color: Colors.white),),
                            ),
                          ),

                          SizedBox(height: 10),

                          /// Cancel Button
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(style: ElevatedButton.styleFrom(backgroundColor:Colors.teal),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(" Order Cancel",style: TextStyle(fontSize: 17,color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Center(
                child: Text(
                  "Help",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],

      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Order delivery by Dec 08, 10:00 P.M",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "ON TIME",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              /// TIMELINE
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.green,
                        child: Text(
                          "DONE",
                          style: TextStyle(fontSize: 8, color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 2,
                        color: Colors.grey.shade400,
                      ),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.green,
                        child: Text(
                          "DONE",
                          style: TextStyle(fontSize: 8, color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 2,
                        color: Colors.grey.shade400,
                      ),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.deepPurple,
                        child: Text(
                          "NOW",
                          style: TextStyle(fontSize: 8, color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 2,
                        color: Colors.grey.shade400,
                      ),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.grey.shade300,
                        child: Text(
                          "NEXT",
                          style: TextStyle(fontSize: 8, color: Colors.black),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payment successful",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "You choose the payment mode as cash on delivery. Pay ₹874.43 to the delivery partner.",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        SizedBox(height: 35),

                        Text(
                          "Order verified",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 80),

                        Text(
                          "We are sourcing medicines",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 70),

                        Text(
                          "Out for Delivery",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
