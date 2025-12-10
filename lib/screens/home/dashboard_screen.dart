import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline_healthcare_app/screens/appointments/appointment_surgery_booking_screen.dart';
import 'package:lifeline_healthcare_app/screens/doctor/find_doctor_screen.dart';
import 'package:lifeline_healthcare_app/screens/home/setting_screen.dart';
import 'package:lifeline_healthcare_app/screens/home/user_profile_screen.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_consult_screen.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_lab_test_screen.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_medicine_screen.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_my_labtest_screen.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_physical_screen.dart';
import 'package:lifeline_healthcare_app/widgets/dashboard_widgets/dashboard_service_item.dart';
import 'package:lifeline_healthcare_app/widgets/dashboard_widgets/offer_banner.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../providers/user_detail/get_userdetail_provider.dart';
import '../../widgets/dashboard_widgets/dashboard_find_doctor_card.dart';
import '../../widgets/dashboard_widgets/top_feature_card.dart';
import 'notification_screen.dart';

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

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   languageBottomSheet();
    // });
    Provider.of<GetUserDetailProvider>(
      context,
      listen: false,
    ).getUserDetail(context);
  }

  @override
  void dispose() {
    _offerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GetUserDetailProvider>(context);
    var userData = provider.user;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Color(0xffefefef)
          : Colors.black,
      key: _scaffoldKey,
      drawer: Drawer(
        // backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                // color: Color(0xfffefefe)
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(),
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuNhTZJTtkR6b-ADMhmzPvVwaLuLdz273wvQ&s',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 13, top: 45),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData?.name ?? '',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'View and edit profile',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Icon(Icons.navigate_next),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Appointments'),
              onTap: () {
                HapticFeedback.selectionClick();
              },
            ),
            ListTile(
              leading: Icon(CupertinoIcons.lab_flask_solid),
              title: Text('TestBooking'),
              onTap: () {
                HapticFeedback.selectionClick();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyTestScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(CupertinoIcons.cube_box),
              title: Text('My Orders'),
              onTap: () {
                HapticFeedback.selectionClick();
              },
            ),
            ListTile(
              leading: Icon(CupertinoIcons.chat_bubble_2),
              title: Text('ChatBot'),
              onTap: () {
                HapticFeedback.selectionClick();
              },
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingScreen()),
                );
              },
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  HapticFeedback.selectionClick();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingScreen()),
                  );
                },
              ),
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
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuNhTZJTtkR6b-ADMhmzPvVwaLuLdz273wvQ&s',
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Lifeline HealthCare',
          style: GoogleFonts.nunito(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            shadows: [
              Shadow(
                color: Color(0xffFFCC00),
                blurRadius: 3,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationGlassScreen()),
              );
            },
            icon: const Badge(
              label: Text('2'),
              child: Icon(Icons.notifications, color: Colors.white),
            ),
          ),
        ],
      ),

      body: ListView(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TopFeatureCard(
                title: "Instant Consult",
                subtitle: "Chat with doctors",
                image:
                    "https://static.vecteezy.com/system/resources/thumbnails/048/740/103/small/doctor-writing-on-a-clipboard-isolated-against-a-transparent-background-png.png",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientConsultScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(width: 12),

              TopFeatureCard(
                title: "Physical Appointment",
                subtitle: "Book nearby doctor",
                image:
                    "https://static.vecteezy.com/system/resources/thumbnails/050/817/819/small/happy-smiling-male-doctor-with-hand-present-something-empty-space-standing-isolate-on-transparent-background-png.png",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhysicalAppointmentScreen(),
                    ),
                  );
                },
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
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      ServiceItem(
                        title: 'Medicine',
                        imageUrl:
                            'https://cdn-icons-png.flaticon.com/256/4861/4861715.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MedicineHomeScreen(),
                            ),
                          );
                        },
                      ),

                      SizedBox(width: 10),

                      ServiceItem(
                        title: 'LabTest',
                        imageUrl:
                            'https://cdn-icons-png.flaticon.com/512/7918/7918318.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PatientLabTestScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 10),

                      ServiceItem(
                        title: 'Surgeries',
                        imageUrl:
                            'https://cdn-icons-png.flaticon.com/512/9442/9442009.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SurgeryBookingScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 10),

                      ServiceItem(
                        title: 'Doctors',
                        imageUrl:
                            'https://cdn-icons-png.flaticon.com/512/2991/2991292.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FindDoctor(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
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
                      height: 170,
                      width: double.infinity,
                      child: PageView(
                        controller: _offerController,
                        onPageChanged: (index) {
                          setState(() => _offerPage = index);
                        },
                        children: [
                          OfferBanner(
                            image:
                                'https://www.thehitavada.com/Encyc/2025/6/8/Renowned-Pune-Ayurvedic_202506081035455705_H@@IGHT_626_W@@IDTH_1200.jpg',
                          ),
                          OfferBanner(
                            image:
                                'https://medinova-pharmaceuticals.com/wp-content/uploads/2024/05/3.jpg',
                          ),
                          OfferBanner(
                            image:
                                'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiw_lTQ-OnS77ccIFEDyiR2At9c15u8RwTb6xO5i9mZFQFHp82hAGweFpSGF2Ob30Ms9FXo2wgBsEL9g-TuZplHtl5jYxXE_eyS-vaFG7DZtv7rOA8CUHzRJvRMiugMLv7vUc8_gXy1euvP/s1600/APRHS30.jpg',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

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
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FindDoctor()),
                    );
                  },
                  child: HealthCategoryItem(
                    title: healthCategories[index]['title']!,
                    imagePath: healthCategories[index]['image']!,
                    backgroundColor: Theme.of(context).cardColor,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),

          Container(
            width: double.infinity,
            color: Theme.of(context).canvasColor,
            child: Column(
              children: [
                const SizedBox(height: 15),
                Image.asset('images/app_logo.png', width: 100, height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Crafted with  ',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    // Image.network(
                    //   'https://pngimg.com/d/plus_PNG119.png',
                    //   width: 15,
                    //   height: 15,
                    // ),
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
                SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
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
              height: 300,
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
