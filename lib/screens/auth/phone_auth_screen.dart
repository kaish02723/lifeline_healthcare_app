import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline_healthcare_app/providers/user_detail/auth_provider.dart';
import 'package:lifeline_healthcare_app/screens/user_profile/complete_profile_screen.dart';
import 'package:lifeline_healthcare_app/screens/auth/verify_otp_screen.dart';
import 'package:provider/provider.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            ClipPath(
              clipper: LowerWaveClipper(),
              child: Container(height: 300, color: const Color(0xFF26A69A)),
            ),

            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.1416),
              child: ClipPath(
                clipper: UpperWaveClipper(),
                child: Container(
                  height: 300,
                  decoration: const BoxDecoration(color: Color(0xff00796B)),
                ),
              ),
            ),

            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 350),
                child: Form(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      Text(
                        "Welcome Back",
                        style: GoogleFonts.montserrat(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF00695C),
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "Add your phone number to get loggedIn",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 25),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          controller: provider.phoneController,
                          cursorColor: const Color(0xFF00695C),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone number is required*';
                            } else if (!provider.phoneRegex.hasMatch(value)) {
                              return 'Enter a valid 10-digit phone number';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: InputDecoration(
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 25,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://img.freepik.com/premium-photo/india-national-fabric-flag_113767-1933.jpg?semt=ais_hybrid&w=740&q=80',
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  '+91',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Container(
                                  height: 35,
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),

                            hintText: 'Phone number',
                            filled: true,
                            fillColor: const Color(0xfff1f1f1),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                              borderSide: const BorderSide(
                                color: Color(0xFF00695C),
                                width: 2,
                              ),
                            ),
                            counterText: "",
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// ==============================
                      /// SEND OTP BUTTON (UPDATED)
                      /// ==============================
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 20,
                        ),
                        child: ValueListenableBuilder<bool>(
                          valueListenable: provider.isPhoneValid,
                          builder: (context, isValid, _) {
                            return GestureDetector(
                              onTap:
                                  isValid
                                      ? () {
                                        if (provider.formKey.currentState!
                                            .validate()) {
                                          provider.sendOtp(context);
                                        } else {
                                          HapticFeedback.mediumImpact();
                                        }
                                      }
                                      : null,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  gradient: LinearGradient(
                                    colors:
                                        isValid
                                            ? [
                                              Color(0xFF00796B),
                                              Color(0xFF26A69A),
                                            ]
                                            : [
                                              Colors.grey.shade400,
                                              Colors.grey.shade500,
                                            ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Send OTP",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 10),
                      const Text(
                        'We will send an OTP of 6-digits to your phone number.',
                        style: TextStyle(
                          color: Color(0xff979797),
                          fontSize: 13,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CompleteProfileScreen(),
                            ),
                          );
                        },
                        child: const Text('Skip'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//  UPPER CURVE
class UpperWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height - 180,
      size.width * 0.55,
      size.height - 120,
    );
    path.quadraticBezierTo(
      size.width * 0.85,
      size.height - 45,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class LowerWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height - 47,
      size.width * 0.5,
      size.height - 80,
    );
    path.quadraticBezierTo(
      size.width * 0.8,
      size.height - 109,
      size.width,
      size.height - 45,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
