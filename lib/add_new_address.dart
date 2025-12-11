import 'package:flutter/material.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  String selectedTag = "HOME";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(leading: Icon(Icons.arrow_back),
          backgroundColor:  Color(0xFF00796B),
          foregroundColor: Colors.white,
          title:  Text("Add new address"),
        ),
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Delivery address",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Delivery Container
                Container(
                  padding:  EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "Delivery address",
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      //SizedBox(height: 12),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Icon(Icons.location_on_outlined, color: Colors.grey),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Patna, Patna, Bihar, India",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "CHANGE LOCATION",
                                  style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      TextField(
                        decoration:  InputDecoration(
                          hintText: "House number / Building name",
                        ),
                      ),
                      SizedBox(height: 10),

                      TextField(
                        decoration:  InputDecoration(
                          hintText: "Street Address",
                        ),
                      ),
                      SizedBox(height: 10),

                      TextField(
                        decoration:  InputDecoration(
                          hintText: "Enter delivery pincode",
                        ),
                      ),
                      SizedBox(height: 10),

                      TextField(
                        decoration:  InputDecoration(
                          hintText: "Contact number",
                        ),
                      ),
                      SizedBox(height: 20),

                      Text(
                        "Tag address as",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: "HOME",
                            groupValue: selectedTag,
                            onChanged: (v) => setState(() => selectedTag = v!),
                          ),
                          Text("Home"),
                          Radio(
                            value: "OFFICE",
                            groupValue: selectedTag,
                            onChanged: (v) => setState(() => selectedTag = v!),
                          ),
                          Text("Office"),
                          Radio(
                            value: "OTHER",
                            groupValue: selectedTag,
                            onChanged: (v) => setState(() => selectedTag = v!),
                          ),
                          Text("Other"),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Invoice Container
                Container(
                  padding:  EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Invoice details",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        decoration:  InputDecoration(hintText: "Name"),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xFF00897B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child:  Text(
                      "Book Appointment",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
