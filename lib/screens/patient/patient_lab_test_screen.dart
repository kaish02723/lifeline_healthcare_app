import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline_healthcare_app/providers/labtest_provider/popular_test_provider.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_book_test_screen.dart';
import 'package:lifeline_healthcare_app/widgets/animated_loader.dart';
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
    var theme = Theme.of(context);
    var isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Color(0xff121212) : Colors.grey[100],
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
                width: MediaQuery.of(context).size.width * 0.91,
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
                    fillColor: isDark
                        ? Colors.white.withOpacity(0.05)
                        : Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 25, bottom: 15),
            child: Text(
              'Top Booked Diagnostic Tests',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: provider.isLoading
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: MedicalHeartECGLoader(
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                    ),
                  )

                : MasonryGridView.count(
                    itemCount: provider.popularDataList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 15,
                    itemBuilder: (context, index) {
                      var listData = provider.popularDataList[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withOpacity(0.05)
                                  : Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isDark
                                    ? Colors.grey.shade800
                                    : Colors.grey.shade300,
                                width: 0.5,
                              ),


                              boxShadow: [
                                BoxShadow(
                                  color: isDark
                                      ? Colors.black26
                                      : Colors.grey.withOpacity(0.2),
                                  blurRadius: 6,
                                  offset: Offset(2, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          listData.name ?? '',
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis,
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          listData.description ?? '',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: isDark
                                                ? Colors.grey[400]
                                                : Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          listData.category ?? '',
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: isDark
                                                ? Colors.grey[400]
                                                : Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          '₹${listData.price}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    HapticFeedback.mediumImpact();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BookTestFormScreen(
                                              testName: listData.name
                                                  .toString(),
                                              category: listData.category
                                                  .toString(),
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      border: Border(
                                        top: BorderSide(
                                          color: isDark
                                              ? Colors.grey.shade800
                                              : Colors.grey.shade300,
                                          width: 0.5,
                                        ),
                                      ),
                                      color: isDark
                                          ? Color(0xff00796B).withOpacity(0.9)
                                          : Color(0xff00BFA5).withOpacity(0.9),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Book Test',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.white,
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
                    },
                    crossAxisCount: 2,
                  ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
