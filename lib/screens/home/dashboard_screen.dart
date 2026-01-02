import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline_healthcare_app/config/color.dart';
import 'package:lifeline_healthcare_app/providers/dashboard_provider.dart';
import 'package:lifeline_healthcare_app/screens/appointments/appointment_surgery_booking_screen.dart';
import 'package:lifeline_healthcare_app/screens/appointments/my_appointment_screen.dart';
import 'package:lifeline_healthcare_app/screens/doctor/find_doctor_screen.dart';
import 'package:lifeline_healthcare_app/screens/home/setting_screen.dart';
import 'package:lifeline_healthcare_app/screens/user_profile/user_profile_screen.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_consult_screen.dart';
import 'package:lifeline_healthcare_app/screens/test/patient_lab_test_screen.dart';
import 'package:lifeline_healthcare_app/screens/test/patient_my_labtest_screen.dart';
import 'package:lifeline_healthcare_app/screens/surgery/patient_my_surgery_screen.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_physical_screen.dart';
import 'package:lifeline_healthcare_app/widgets/dashboard_widgets/dashboard_footer.dart';
import 'package:lifeline_healthcare_app/widgets/dashboard_widgets/dashboard_service_item.dart';
import 'package:lifeline_healthcare_app/widgets/dashboard_widgets/offer_banner.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../providers/rating_provider/app_rating_review_provider.dart';
import '../../providers/user_detail/User_profile_provider.dart';
import '../../widgets/dashboard_widgets/dashboard_find_doctor_card.dart';
import '../../widgets/dashboard_widgets/show_rate_us_bottom_sheet.dart';
import '../../widgets/dashboard_widgets/top_feature_card.dart';
import '../medicine screen/medicine_category_screen.dart';
import '../medicine screen/my_medicine_oder.dart';
import 'notification_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedLanguage = "English";

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   languageBottomSheet();
    // });
    Provider.of<UserProfileProvider>(
      context,
      listen: false,
    ).getProfile(context);

    var rating = Provider.of<TopRatingProvider>(context, listen: false);
    rating.fetchTopReviews();
    rating.fetchAverageRating();
    startOfferAutoScroll(context);
  }

  @override
  void dispose() {
    Provider.of<DashBoardProvider>(context).offerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProfileProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // var provider = Provider.of<GetUserDetailProvider>(context);
    var userData = provider.user;
    var dashBoardProvider = Provider.of<DashBoardProvider>(context);

    return Scaffold(
      backgroundColor:
          Theme.of(context).brightness == Brightness.light
              ? Color(0xffefefef)
              : Colors.black,
      key: _scaffoldKey,
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => UserProfileScreen()),
                    );
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primary.withOpacity(0.15),
                        backgroundImage:
                            (userData?.picture != null &&
                                    userData!.picture!.isNotEmpty)
                                ? NetworkImage(
                                  userData.picture!.startsWith("http")
                                      ? userData.picture!
                                      : "https://phone-auth-with-jwt-4.onrender.com${userData.picture!}",
                                )
                                : null,
                        child:
                            (userData?.picture == null ||
                                    userData!.picture!.isEmpty)
                                ? Icon(
                                  Icons.person,
                                  size: 32,
                                  color:
                                      isDark
                                          ? AppColors.iconDark
                                          : AppColors.icon,
                                )
                                : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData?.name ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'View and edit profile',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),

              const Divider(),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _drawerItem(
                      icon: Icons.credit_card,
                      title: 'Appointments',
                      onTap: () {
                        HapticFeedback.selectionClick();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MyAppointmentScreen(),
                          ),
                        );
                      },
                    ),

                    _drawerItem(
                      icon: CupertinoIcons.lab_flask_solid,
                      title: 'Test Booking',
                      onTap: () {
                        HapticFeedback.selectionClick();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => MyTestScreen()),
                        );
                      },
                    ),

                    _drawerItem(
                      icon: Icons.local_hospital_outlined,
                      title: 'My Surgery',
                      onTap: () {
                        HapticFeedback.selectionClick();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MySurgeryScreen(),
                          ),
                        );
                      },
                    ),

                    _drawerItem(
                      icon: CupertinoIcons.cube_box,
                      title: 'My Orders',
                      onTap: () {
                        HapticFeedback.selectionClick();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrdersScreen(),
                          ),
                        );
                      },
                    ),

                    _drawerItem(
                      icon: CupertinoIcons.chat_bubble_2,
                      title: 'ChatBot',
                      onTap: () {
                        HapticFeedback.selectionClick();
                        Navigator.pop(context); // drawer close
                        _showComingSoonDialog(context);
                      },
                    ),

                    _drawerItem(
                      icon: Icons.settings,
                      title: 'Settings',
                      onTap: () {
                        HapticFeedback.selectionClick();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SettingScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: ListTile(
                  leading: const Icon(Icons.thumb_up_alt_outlined),
                  title: const Text('Rate Us'),
                  onTap: () {
                    HapticFeedback.selectionClick();
                    showRateUsBottomSheet(context);
                  },
                ),
              ),
            ],
          ),
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
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 22,
              backgroundImage:
                  (userData?.picture != null && userData!.picture!.isNotEmpty)
                      ? NetworkImage(
                        userData.picture!.startsWith("http")
                            ? userData.picture!
                            : "https://phone-auth-with-jwt-4.onrender.com${userData.picture!}",
                      )
                      : null,
              child:
                  (userData?.picture == null || userData!.picture!.isEmpty)
                      ? const Icon(Icons.person, color: Colors.grey)
                      : null,
            ),
          ),
        ),

        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 13),
              child: Text(
                'Lifeline',
                textScaler: TextScaler.linear(0.93),
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  shadows: [
                    Shadow(
                      color: Color(0xFF5C3A00),
                      blurRadius: 3,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              "HealthCare",
              textScaler: TextScaler.linear(0.93),
              style: GoogleFonts.nunito(
                color: Color(0xFFFFC107),
                fontWeight: FontWeight.bold,
                fontSize: 25,
                shadows: [
                  Shadow(
                    color: Color(0xFF5C3A00),
                    blurRadius: 3,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Tooltip(
            message: 'Notification',
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationGlassScreen(),
                  ),
                );
              },
              icon: const Badge(
                label: Text('2'),
                child: Icon(Icons.notifications, color: Colors.white),
              ),
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
                      builder: (context) => PhysicalAppointmentScreen(),
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
                      builder: (context) => PatientConsultScreen(),
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
                              builder: (context) => MedicineCategoryScreen(),
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
                        controller: dashBoardProvider.offerController,
                        onPageChanged: (index) {
                          dashBoardProvider.updatePage(index);
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
                  controller: dashBoardProvider.offerController,
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
          const SizedBox(height: 20),
          Consumer<TopRatingProvider>(
            builder: (context, provider, _) {
              if (provider.isLoadingTopReviews || provider.isLoadingAverage) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (provider.averageData == null && provider.topReviews.isEmpty) {
                return const SizedBox();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if (provider.averageData != null) ...[
                  //   Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //     child: RatingSummaryCard(),
                  //   ),
                  //   const SizedBox(height: 16),
                  // ],
                  if (provider.topReviews.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        "What users say about us 💬",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                  if (provider.topReviews.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          "No feedback available yet",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.topReviews.length,
                    itemBuilder: (context, index) {
                      final review = provider.topReviews[index];
                      final rating = review.rating ?? 0;

                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(
                                context,
                              ).shadowColor.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: List.generate(5, (i) {
                                    if (i < rating.floor()) {
                                      return const Icon(
                                        Icons.star,
                                        color: AppColors.golden,
                                        size: 18,
                                      );
                                    } else if (i < rating &&
                                        rating - i >= 0.5) {
                                      return const Icon(
                                        Icons.star_half,
                                        color: AppColors.golden,
                                        size: 18,
                                      );
                                    } else {
                                      return const Icon(
                                        Icons.star_border,
                                        color: AppColors.golden,
                                        size: 18,
                                      );
                                    }
                                  }),
                                ),
                                const Spacer(),
                                if (review.createdAt != null)
                                  Text(
                                    review.createdAt!.split('T').first,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color
                                          ?.withOpacity(0.6),
                                    ),
                                  ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            Text(
                              review.feedback ?? "No feedback provided",
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.4,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 30),
          DashboardFooter(),
        ],
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      onTap: onTap,
    );
  }

  // void languageBottomSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     isDismissible: false,
  //     enableDrag: false,
  //     backgroundColor: Colors.white,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) {
  //       String tempSelected = selectedLanguage;
  //
  //       return StatefulBuilder(
  //         builder: (context, setSheetState) {
  //           return Container(
  //             height: 300,
  //             padding: const EdgeInsets.all(18),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Center(
  //                   child: Container(
  //                     width: 45,
  //                     height: 4,
  //                     decoration: BoxDecoration(
  //                       color: Colors.grey,
  //                       borderRadius: BorderRadius.circular(5),
  //                     ),
  //                   ),
  //                 ),
  //
  //                 const SizedBox(height: 15),
  //
  //                 Center(
  //                   child: Text(
  //                     "Choose Language",
  //                     style: TextStyle(
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.w600,
  //                       color: Color(0xff00796B),
  //                     ),
  //                   ),
  //                 ),
  //
  //                 const SizedBox(height: 20),
  //
  //                 /// ENGLISH
  //                 RadioListTile(
  //                   title: Text("English"),
  //                   value: "English",
  //                   groupValue: tempSelected,
  //                   activeColor: Color(0xff00796B),
  //                   onChanged: (value) {
  //                     setSheetState(() => tempSelected = value.toString());
  //                   },
  //                 ),
  //
  //                 /// HINDI
  //                 RadioListTile(
  //                   title: Text("Hindi"),
  //                   value: "Hindi",
  //                   groupValue: tempSelected,
  //                   activeColor: Color(0xff00796B),
  //                   onChanged: (value) {
  //                     setSheetState(() => tempSelected = value.toString());
  //                   },
  //                 ),
  //
  //                 const SizedBox(height: 10),
  //
  //                 /// Continue Button
  //                 GestureDetector(
  //                   onTap: () {
  //                     setState(() => selectedLanguage = tempSelected);
  //                     Navigator.pop(context);
  //                   },
  //                   child: Container(
  //                     height: 50,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(12),
  //                       gradient: const LinearGradient(
  //                         colors: [Color(0xff00796B), Color(0xff26A69A)],
  //                       ),
  //                     ),
  //                     child: const Center(
  //                       child: Text(
  //                         "Continue",
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 17,
  //                           fontWeight: FontWeight.w600,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  void _showComingSoonDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Row(
            children: [
              Icon(
                Icons.smart_toy_outlined,
                color: const Color(0xff00796B),
                size: 26,
              ),
              const SizedBox(width: 10),
              const Text(
                "Coming Soon",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          content: Text(
            "🤖 Our AI ChatBot is on the way!\n\n"
            "Very soon you’ll be able to chat with doctors, "
            "get instant health guidance, and quick support.",
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xff00796B),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Got it",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}
