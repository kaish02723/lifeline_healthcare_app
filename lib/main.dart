import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeline_healthcare_app/providers/auth_provider.dart';
import 'package:lifeline_healthcare_app/providers/labtest_provider/book_test_provider.dart';
import 'package:lifeline_healthcare_app/providers/media_picker_provider.dart';
import 'package:lifeline_healthcare_app/providers/theme_provider.dart';
import 'package:lifeline_healthcare_app/providers/user_detail/get_userdetail_provider.dart';
import 'package:lifeline_healthcare_app/providers/labtest_provider/popular_test_provider.dart';
import 'package:lifeline_healthcare_app/providers/user_detail/user_detail_provider.dart';
import 'package:lifeline_healthcare_app/screens/auth/phone_auth_screen.dart';
import 'package:lifeline_healthcare_app/screens/auth/verify_otp_screen.dart';
import 'package:lifeline_healthcare_app/screens/home/dashboard_screen.dart';
import 'package:lifeline_healthcare_app/screens/splash/splash_screen.dart';
import 'package:lifeline_healthcare_app/widgets/network_wraper.dart';
import 'package:provider/provider.dart';

import 'config/app_theme.dart';
import 'config/app_theme_colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => PopularTestProvider()),
        ChangeNotifierProvider(create: (context) => UserDetailProvider()),
        ChangeNotifierProvider(create: (context) => GetUserDetailProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => MediaPickerProvider()),
        ChangeNotifierProvider(create: (context) => BookTestProvider()),
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
                  )
                ],
              ),

              darkTheme: ThemeData(
                brightness: Brightness.dark,
                extensions: [
                  AppThemeColors(
                    glassBackground: Colors.white.withOpacity(0.10),
                    borderColor: Colors.white.withOpacity(0.20),
                    cardShadow: Colors.black.withOpacity(0.50),
                  )
                ],
              ),
              themeMode: themeProvider.isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              routes: {
                '/phone_auth_screen': (context) => const PhoneAuthScreen(),
                '/dashboard': (context) => const DashboardScreen(),
                '/splash_screen': (context) => const SplashScreen(),
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
