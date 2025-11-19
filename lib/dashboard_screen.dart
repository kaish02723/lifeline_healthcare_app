import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/physical_appointment_screen.dart';
import 'package:lifeline_healthcare_app/setting_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'instant_video_consult_screen.dart';
import 'lab_test_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _offerController = PageController();
  String selectedLanguage = "English";
  int _offerPage = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      languageBottomSheet();
    });
  }

  @override
  void dispose() {
    _offerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuNhTZJTtkR6b-ADMhmzPvVwaLuLdz273wvQ&s',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 13, top: 45),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Md kaish',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'View and edit profile',
                          style: TextStyle(fontSize: 16, color: Colors.black45),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.navigate_next, color: Colors.black),
                  ),
                ],
              ),
            ),
            const ListTile(leading: Icon(Icons.person), title: Text('Profile')),
            const ListTile(
              leading: Icon(Icons.light_mode),
              title: Text('Theme'),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: const Color(0xff00796B),
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => _scaffoldKey.currentState!.openDrawer(),
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                'https://i.pinimg.com/736x/62/01/0d/62010d848b790a2336d1542fcda51789.jpg',
              ),
            ),
          ),
        ),
        title: const Text('UserName', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingScreen()),
              );
            },
            icon: const Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),

      body: ListView(
        children: [
          const SizedBox(height: 20),

          /// Appointment cards row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InstantVideoConsult(),
                    ),
                  );
                },
                child: Container(
                  width: 160,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xffF5F7FA),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xffD2D2D2),
                      width: 0.5,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 10),
                        child: Text(
                          'Instant Video Consult',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 37, left: 10),
                        child: Text(
                          'From home',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 40,
                        top: 35,
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            'https://www.dotcominfoway.com/wp-content/uploads/2020/05/online-consultation-apps-development-services-img1.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhysicalAppointmentScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 160,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xffF5F7FA),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xffD2D2D2),
                      width: 0.5,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 10),
                        child: Text(
                          'Physical Appointment',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 37, left: 10),
                        child: Text(
                          'At home',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 35,
                        top: 35,
                        child: SizedBox(
                          width: 120,
                          height: 100,
                          child: Image.network(
                            'https://static.vecteezy.com/system/resources/thumbnails/019/994/556/small/doctor-and-patient-graphic-clipart-design-free-png.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.only(left: 15, top: 25),
            child: Text(
              'Services',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),

          const SizedBox(height: 15),

          /// Horizontal Services Scroll
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Row(
              children: [
                const SizedBox(width: 14),
                ...List.generate(5, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _buildServiceCard(index),
                  );
                }),
              ],
            ),
          ),

          /// Best Offers header
          const Padding(
            padding: EdgeInsets.only(left: 15, top: 25, bottom: 10),
            child: Text(
              'Best Offers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),

          /// Bordered container wrapping PageView + indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xffBEBEBE),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 6,
                        spreadRadius: 2,
                        offset: const Offset(2, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      height: 150,
                      child: PageView(
                        controller: _offerController,
                        onPageChanged: (index) {
                          setState(() => _offerPage = index);
                        },
                        children: [
                          _buildOfferBanner(
                            'https://www.thehitavada.com/Encyc/2025/6/8/Renowned-Pune-Ayurvedic_202506081035455705_H@@IGHT_626_W@@IDTH_1200.jpg',
                          ),
                          _buildOfferBanner(
                            'https://medinova-pharmaceuticals.com/wp-content/uploads/2024/05/3.jpg',
                          ),
                          _buildOfferBanner(
                            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiw_lTQ-OnS77ccIFEDyiR2At9c15u8RwTb6xO5i9mZFQFHp82hAGweFpSGF2Ob30Ms9FXo2wgBsEL9g-TuZplHtl5jYxXE_eyS-vaFG7DZtv7rOA8CUHzRJvRMiugMLv7vUc8_gXy1euvP/s1600/APRHS30.jpg',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Smooth indicator dots
                SmoothPageIndicator(
                  controller: _offerController,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Color(0xff00796B),
                    dotColor: Color(0xffBEBEBE),
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 6,
                    expansionFactor: 3,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15, top: 25, bottom: 15),
            child: Text(
              'Find a doctor for your health problem',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 200,
            child: GridView.builder(
              itemCount: 8,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xffF5F7FA),
                        borderRadius: BorderRadius.circular(7),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.15),
                        //     offset: Offset(2, 0),
                        //     blurRadius: 4,
                        //     spreadRadius: 3,
                        //   ),
                        // ],
                        border: Border.all(
                          color: Color(0xffd1d1d1),
                          width: 0.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('Skin & Hair', style: TextStyle(fontSize: 12)),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 30),

          Container(
            height: 280,
            width: double.infinity,
            color: Color(0xfff5fafa),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Image.asset('images/logo.png', width: 100, height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Crafted with  ',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Image.network(
                      'https://pngimg.com/d/plus_PNG68.png',
                      width: 15,
                      height: 15,
                    ),
                    Text(
                      '  in India',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 7),
                Text(
                  'Powered by',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                SizedBox(height: 5),
                Text(
                  'Lifeline Healthcare',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 15),
                Text(
                  'Our vision is to help mankind live healthier,  longer lives by making quality healthcare,    accessible, affordable and convenient.',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Service Card helper
  Widget _buildServiceCard(int index) {
    return InkWell(
      onTap: () {
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LabTestScreen()),
          );
        }
      },
      child: Container(
        width: 90,
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffBEBEBE), width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.20),
              blurRadius: 6,
              spreadRadius: 2,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: 16,
              top: 15,
              child: SizedBox(
                width: 55,
                height: 55,
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/256/4861/4861715.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Positioned(
              bottom: 10,
              left: 8,
              right: 8,
              child: Text(
                'Medicines',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Offer Banner helper
  Widget _buildOfferBanner(String url) {
    return Image.network(url, fit: BoxFit.cover);
  }

  void languageBottomSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        String tempSelected = selectedLanguage;

        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              height: 330,
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 45,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Center(
                    child: Text(
                      "Choose Language",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff00796B),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ENGLISH
                  RadioListTile(
                    title: Text("English"),
                    value: "English",
                    groupValue: tempSelected,
                    activeColor: Color(0xff00796B),
                    onChanged: (value) {
                      setSheetState(() => tempSelected = value.toString());
                    },
                  ),

                  /// HINDI
                  RadioListTile(
                    title: Text("Hindi"),
                    value: "Hindi",
                    groupValue: tempSelected,
                    activeColor: Color(0xff00796B),
                    onChanged: (value) {
                      setSheetState(() => tempSelected = value.toString());
                    },
                  ),

                  /// BENGALI
                  RadioListTile(
                    title: Text("Bengali"),
                    value: "Bengali",
                    groupValue: tempSelected,
                    activeColor: Color(0xff00796B),
                    onChanged: (value) {
                      setSheetState(() => tempSelected = value.toString());
                    },
                  ),

                  const SizedBox(height: 10),

                  /// Continue Button
                  GestureDetector(
                    onTap: () {
                      setState(() => selectedLanguage = tempSelected);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [Color(0xff00796B), Color(0xff26A69A)],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
