import 'package:flutter/material.dart';
import 'package:lifeline_healthcare/screen/edit_profile.dart';
import 'package:lifeline_healthcare/screen/medicine_screen.dart';
import 'package:lifeline_healthcare/screen/theme/app_theme.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditProfile(),
      themeMode: ThemeMode.system,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.lightTheme,
    );
  }
}
