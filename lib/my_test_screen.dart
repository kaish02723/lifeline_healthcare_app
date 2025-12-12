import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTestScreen extends StatefulWidget {
  const MyTestScreen({super.key});

  @override
  State<MyTestScreen> createState() => _MyTestScreenState();
}

class _MyTestScreenState extends State<MyTestScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(

          backgroundColor: Colors.teal,
          leading: Icon(Icons.arrow_back, color: Colors.white),
          title: Text(
            "My Test",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            blurRadius: 5,offset: Offset(0, 3)
                        )
                      ]
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.help_outline, color: Colors.orange),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Your test status and prescriptions",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Card(
                  elevation: 3,//shadow dene ke liy
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          "Test Name : Depression & Stress Assessment",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),
                        Text("User Name : Arbind Kumar"),
                        Text("Test Name : CBC"),
                        Text("Category : Blood Test"),
                        Text("Booking Date : 01/01/2025"),
                        Text("Test ID : CBC0101"),

                        SizedBox(height: 10),

                        Row(
                          children: [
                            Text(
                              "Status : ",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Icon(Icons.circle, color: Colors.orange, size: 14),
                            SizedBox(width: 6),
                            Text(
                              "Pending",
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                Card(
                  elevation: 3,//shadow dene ke liy
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          "Test Name : Depression & Stress Assessment",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),
                        Text("User Name : Arbind Kumar"),
                        Text("Test Name : CBC"),
                        Text("Category : Blood Test"),
                        Text("Booking Date : 01/01/2025"),
                        Text("Test ID : CBC0101"),

                        SizedBox(height: 10),

                        Row(
                          children: [
                            Text(
                              "Status : ",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Icon(Icons.circle, color: Colors.green, size: 14),
                            SizedBox(width: 6),
                            Text(
                              "Approved",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  elevation: 3,//shadow dene ke liy
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          "Test Name : Depression & Stress Assessment",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),
                        Text("User Name : Arbind Kumar"),
                        Text("Test Name : CBC"),
                        Text("Category : Blood Test"),
                        Text("Booking Date : 01/01/2025"),
                        Text("Test ID : CBC0101"),

                        SizedBox(height: 10),

                        Row(
                          children: [
                            Text(
                              "Status : ",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Icon(Icons.circle, color: Colors.red, size: 14),
                            SizedBox(width: 6),
                            Text(
                              "Cancelled",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
