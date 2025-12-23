import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeline_healthcare_app/providers/user_detail/User_profile_provider.dart';
import 'package:lifeline_healthcare_app/providers/user_detail/auth_provider.dart';
import 'package:lifeline_healthcare_app/providers/dashboard_provider.dart';
import 'package:lifeline_healthcare_app/providers/doctor_provider/doctor_provider.dart';
import 'package:lifeline_healthcare_app/providers/labtest_provider/book_test_provider.dart';
import 'package:lifeline_healthcare_app/providers/media_provider/media_picker_provider.dart';
import 'package:lifeline_healthcare_app/providers/labtest_provider/cancel_test_provider.dart';
import 'package:lifeline_healthcare_app/providers/medicine_provider/medicineCart_provider.dart';
import 'package:lifeline_healthcare_app/providers/medicine_provider/medicine_order_provider.dart';
import 'package:lifeline_healthcare_app/providers/medicine_provider/product_provider.dart';
import 'package:lifeline_healthcare_app/providers/rating_provider/app_rating_review_provider.dart';
import 'package:lifeline_healthcare_app/providers/rating_provider/submit_rating_provider.dart';
import 'package:lifeline_healthcare_app/providers/surgery_provider/surgery_provider.dart';
import 'package:lifeline_healthcare_app/providers/theme_provider/theme_provider.dart';
import 'package:lifeline_healthcare_app/providers/labtest_provider/popular_test_provider.dart';
import 'package:lifeline_healthcare_app/screens/user_profile/complete_profile_screen.dart';
import 'package:lifeline_healthcare_app/screens/auth/phone_auth_screen.dart';
import 'package:lifeline_healthcare_app/screens/home/dashboard_screen.dart';
import 'package:lifeline_healthcare_app/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

import 'config/app_theme_colors.dart';
import 'core/utils/services/notification_service.dart';

void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // await NotificationService.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => PopularTestProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => MediaPickerProvider()),
        ChangeNotifierProvider(create: (context) => BookTestProvider()),
        ChangeNotifierProvider(create: (context) => SurgeryProvider(),),
        ChangeNotifierProvider(create: (context) => DashBoardProvider(),),
        ChangeNotifierProvider(create: (context) => DoctorProvider(),),
        ChangeNotifierProvider(create: (context) => ProductProvider(),),
        ChangeNotifierProvider(create: (context) => CartProvider(),),
        ChangeNotifierProvider(create: (context) => MedicineOrderProvider(),),
        ChangeNotifierProvider(create: (context) => SurgeryProvider()),
        ChangeNotifierProvider(create: (context) => DashBoardProvider()),
        ChangeNotifierProvider(create: (context) => DoctorProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => TopRatingProvider(),),
        ChangeNotifierProvider(create: (context) => SubmitRatingProvider(),),
        ChangeNotifierProvider(create: (context) => UserProfileProvider(),),
        ChangeNotifierProvider(create: (context) => CancelTestProvider(),),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Lifeline Healthcare',
              theme: ThemeData(
                brightness: Brightness.light,
                extensions: [
                  AppThemeColors(
                    glassBackground: Colors.white.withOpacity(0.4),
                    borderColor: Colors.white.withOpacity(0.7),
                    cardShadow: Colors.black.withOpacity(0.05),
                  ),
                ],
              ),

              darkTheme: ThemeData(
                brightness: Brightness.dark,
                extensions: [
                  AppThemeColors(
                    glassBackground: Colors.white.withOpacity(0.10),
                    borderColor: Colors.white.withOpacity(0.20),
                    cardShadow: Colors.black.withOpacity(0.50),
                  ),
                ],
              ),
              themeMode:
                  themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
              routes: {
                '/phone_auth_screen': (context) => const PhoneAuthScreen(),
                '/dashboard': (context) => const DashboardScreen(),
                '/splash_screen': (context) => const SplashScreen(),
                '/create_profile':(context)=> const CompleteProfileScreen(),
              },
              home: SplashScreen(),
            );
          },
        );
      },
      child: const SplashScreen(),
    );
  }
}
