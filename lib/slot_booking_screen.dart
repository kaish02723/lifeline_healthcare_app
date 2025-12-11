import 'package:flutter/material.dart';

class SlotBookingScreen extends StatefulWidget {
  @override
  State<SlotBookingScreen> createState() => _SlotBookingScreenState();
}

class _SlotBookingScreenState extends State<SlotBookingScreen> {
  int selectedDate = 0;
  String selectedSlot = "";

  List<String> dates = [
    "Today, 10 Dec",
    "Tomorrow, 11 Dec",
    "Fri, 12 Dec"
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;  // responsive width

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// HEADER
            Container(
              padding: EdgeInsets.all(15),
              width: w,
              color: Colors.teal,
              child: Row(
                children: [
                  Icon(Icons.arrow_back, color: Colors.white),
                  SizedBox(width: 10),
                  CircleAvatar(
                    // backgroundImage: AssetImage("assets/user.jpg"),
                    radius: 20,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Dr. Veena Yagna",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      Text(
                        "LifeLine healthcare Hospital, patna ",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
            ),

            /// BODY SCROLL PART
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),

                    /// Title
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Icon(Icons.home, color: Colors.teal),
                        SizedBox(width: 10),
                        Text(
                          "Clinic Visit Slots",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),

                    SizedBox(height: 20),


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Purpose of visit",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade700)),
                          SizedBox(height: 5),
                          Text("Consultation",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    /// DATE SELECTOR
                    Container(
                      height: 80,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        children: [
                          dateTile(0, "Today, 10 Dec", "9 slots available"),
                          dateTile(1, "Tomorrow, 11 Dec", "16 slots available"),
                          dateTile(2, "Fri, 12 Dec", "18 slots available"),
                        ],
                      ),
                    ),

                    SizedBox(height: 15),
                    Center(
                      child: Text(
                        dates[selectedDate],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),


                    SizedBox(height: 20),

                    /// Morning SECTION
                    sectionTitle(Icons.wb_sunny_outlined, "Morning 2 slots"),

                    slotGrid([
                      "09:30 AM",
                      "10:45 AM",
                      "11:45 AM",
                    ], w),

                    SizedBox(height: 20),

                    /// AFTERNOON SECTION
                    sectionTitle(Icons.nights_stay, "Afternoon 7 slots"),

                    slotGrid([
                      "04:00 PM",
                      "04:15 PM",
                      "04:30 PM",
                      "04:45 PM",
                      "05:00 PM",
                      "05:15 PM",
                      "05:30 PM",
                    ], w),

                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// SECTION TITLE
  Widget sectionTitle(icon, title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 5),
          Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  /// DATE TILE
  Widget dateTile(int index, String date, String slots) {
    bool isSelected = selectedDate == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDate = index;
        });
      },
      child: Container(
        width: 160,
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal[100] : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.green : Colors.black)),
            SizedBox(height: 5),
            Text(
              slots,
              style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.green : Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }

  /// SLOT GRID RESPONSIVE
  Widget slotGrid(List<String> slotList, double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: slotList.map((slot) {
          bool isSelected = selectedSlot == slot;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedSlot = slot;
              });
            },
            child: Container(
              width: width * 0.20, // RESPONSIVE WIDTH
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: isSelected ? Colors.teal : Colors.blueAccent),
                color: isSelected ? Colors.teal.shade50 : Colors.white,
              ),
              child: Text(
                slot,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
