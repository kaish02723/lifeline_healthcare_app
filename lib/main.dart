import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeline_healthcare_app/providers/auth_provider.dart';
import 'package:lifeline_healthcare_app/providers/media_picker_provider.dart';
import 'package:lifeline_healthcare_app/providers/theme_provider.dart';
import 'package:lifeline_healthcare_app/providers/user_detail/get_userdetail_provider.dart';
import 'package:lifeline_healthcare_app/providers/labtest_provider/popular_test_provider.dart';
import 'package:lifeline_healthcare_app/providers/user_detail/user_detail_provider.dart';
import 'package:lifeline_healthcare_app/screens/splash/splash_screen.dart';
import 'package:lifeline_healthcare_app/widgets/network_wraper.dart';
import 'package:provider/provider.dart';

import 'config/app_theme.dart';

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
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: NetworkWrapper(child: SplashScreen()),
            );
          },
        );
      },
      child: const SplashScreen(),
    );
  }
}
