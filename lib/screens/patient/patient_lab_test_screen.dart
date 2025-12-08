import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline_healthcare_app/providers/labtest_provider/popular_test_provider.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_book_test_screen.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_test_booking_cart_screen.dart';
import 'package:provider/provider.dart';

class PatientLabTestScreen extends StatefulWidget {
  const PatientLabTestScreen({super.key});

  @override
  State<PatientLabTestScreen> createState() => _PatientLabTestScreenState();
}

class _PatientLabTestScreenState extends State<PatientLabTestScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PopularTestProvider>(
      context,
      listen: false,
    ).getPopularLabTest();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PopularTestProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('LabTest'),
        backgroundColor: Color(0xff00796B),
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 22),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 25),
          Row(
            children: [
              SizedBox(width: 15),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.82,
                child: TextField(
                  controller: provider.searchLabTestController,
                  onChanged: (value) {
                    provider.filterSearch(value);
                  },
                  cursorColor: Color(0xff00796B),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      size: 23,
                      color: Colors.grey.shade600,
                    ),
                    suffixIcon: provider.isSearchedLabTest
                        ? IconButton(
                            onPressed: () {
                              provider.clearSearch();
                            },
                            icon: Icon(CupertinoIcons.multiply),
                          )
                        : null,
                    hintText: 'Search for test..',
                    isDense: true,
                    filled: true,
                    fillColor: Color(0x74d5d5d5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TestBookingCart()),
                  );
                },
                icon: Icon(CupertinoIcons.cart),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 25, bottom: 15),
            child: Text(
              'Top Booked Diagnostic Tests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: provider.popularDataList.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: CircularProgressIndicator(
                        color: Colors.teal,
                        strokeWidth: 3,
                      ),
                    ),
                  )
                : GridView.builder(
                    itemCount: provider.popularDataList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 20,
                      mainAxisExtent: 210,
                    ),
                    itemBuilder: (context, index) {
                      var listData = provider.popularDataList[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey, width: 0.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 170,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                  top: 12,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      listData.name ?? '',
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      listData.description ?? '',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                      ),
                                    ),

                                    SizedBox(height: 15),
                                    Text(
                                      listData.category ?? '',
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      '₹${listData.price}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                Navigator.push(context, MaterialPageRoute(builder: (context) => BookTestFormScreen(testName: 'testName', category: 'category'),));
                              },
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                  border: Border(
                                    top: BorderSide(
                                      color: Colors.grey,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Book Test',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Color(0xff00BFA5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              SizedBox(height: 15),
              Row(
                children: [
                  Text('Total: ', style: TextStyle(fontSize: 18)),
                  Text(
                    '₹687',
                    style: TextStyle(fontSize: 18, color: Color(0xff26A69A)),
                  ),
                  Spacer(),
                  Text('4 Tests', style: TextStyle(fontSize: 18)),
                ],
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TestBookingCart()),
                  );
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF26A69A), Color(0xFF00796B)],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "View Cart",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
