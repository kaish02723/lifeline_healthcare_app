import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeline_healthcare_app/screens/auth/phone_auth_screen.dart';
import 'package:lifeline_healthcare_app/screens/home/dashboard_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _logoScale;
  late Animation<double> _logoFade;

  late Animation<Offset> _titleSlide;
  late Animation<double> _titleFade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    );

    // Logo animation
    _logoScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _logoFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    // Title animation (staggered)
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 0.9, curve: Curves.easeInOutCubic),
      ),
    );

    _titleFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 0.8, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
    _checkLogin();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Color(0xFF003D3A), Color(0xFF1FA69A), Color(0xFF003D3A)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _logoFade,
              child: ScaleTransition(
                scale: _logoScale,
                child: Image.asset(
                  'images/app_logo.png',
                  width: 190.w,
                  height: 190.w,
                ),
              ),
            ),

            SizedBox(height: 28.h),

            FadeTransition(
              opacity: _titleFade,
              child: SlideTransition(
                position: _titleSlide,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "LifeLine ",
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      TextSpan(
                        text: "HealthCare",
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFFFB956), // brand golden
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 10.h),

            FadeTransition(
              opacity: _titleFade,
              child: Text(
                "Your Health, Our Priority",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15.sp,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkLogin() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    bool isLoggedIn = await auth.checkLoginStatus();

    await Future.delayed(const Duration(milliseconds: 3600));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (_) =>
                isLoggedIn ? const DashboardScreen() : const PhoneAuthScreen(),
      ),
    );
  }
}

class DiamondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width / 2, 0); // top
    path.lineTo(size.width, size.height / 2); // right
    path.lineTo(size.width / 2, size.height); // bottom
    path.lineTo(0, size.height / 2); // left
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
