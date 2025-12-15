import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});


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
          onPressed: () {},
        ),
        title: Text('Orders', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          // Order 1
          Card(
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: Icon(Icons.image, color: Colors.grey),
              ),
              title: Text('Delivery on Nov 03'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('FUBAR Medicine Relax Mind'),
                  SizedBox(height: 4),
                  buildRatingBar(0),
                  Text('Rate this product now', style: TextStyle(fontSize: 12)),
                ],
              ),
              trailing: Icon(Icons.chevron_right),
            ),
          ),

          // Order 2
          Card(
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: Icon(Icons.image, color: Colors.grey),
              ),
              title: Text('Delivery on Nov 03'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('FUBAR Medicine Relax Mind'),
                  SizedBox(height: 4),
                  buildRatingBar(5),
                  Text('Write a Review', style: TextStyle(fontSize: 12, color: Colors.blue)),
                ],
              ),
              trailing: Icon(Icons.chevron_right),
            ),
          ),

          // Order 3
          Card(
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: Icon(Icons.image, color: Colors.grey),
              ),
              title: Text('Delivery on Nov 03'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('FUBAR Medicine Relax Mind'),
                  SizedBox(height: 4),
                  buildRatingBar(0),
                  Text('Rate this product now', style: TextStyle(fontSize: 12)),
                ],
              ),
              trailing: Icon(Icons.chevron_right),
            ),
          ),

          // Order 4
          Card(
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: Icon(Icons.image, color: Colors.grey),
              ),
              title: Text('Delivery on Nov 03'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('FUBAR Medicine Relax Mind'),
                  SizedBox(height: 4),
                  buildRatingBar(0),
                  Text('Rate this product now', style: TextStyle(fontSize: 12)),
                ],
              ),
              trailing: Icon(Icons.chevron_right),
            ),
          ),

          // Order 5
          Card(
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: Icon(Icons.image, color: Colors.grey),
              ),
              title: Text('Delivery on Nov 03'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('FUBAR Medicine Relax Mind'),
                  SizedBox(height: 4),
                  buildRatingBar(0),
                  Text('Rate this product now', style: TextStyle(fontSize: 12)),
                ],
              ),
              trailing: Icon(Icons.chevron_right),
            ),
          ),

          // Order 6
          Card(
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: Icon(Icons.image, color: Colors.grey),
              ),
              title: Text('Delivery on Nov 03'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('FUBAR Medicine Relax Mind'),
                  SizedBox(height: 4),
                  buildRatingBar(0),
                  Text('Rate this product now', style: TextStyle(fontSize: 12)),
                ],
              ),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }
}