import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline_healthcare_app/dashboard_screen.dart';
import 'package:pinput/pinput.dart';

class OtpVerifyScreen extends StatefulWidget {
  final String phone;

  const OtpVerifyScreen({super.key, required this.phone});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}
class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                /// BOTTOM CURVE
                ClipPath(
                  clipper: LowerWaveClipper(),
                  child: Container(height: 300, color: const Color(0xFF009688)),
                ),

                /// TOP CURVE (reverse)
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(3.1416),
                  child: ClipPath(
                    clipper: UpperWaveClipper(),
                    child: Container(
                      height: 300,
                      color: const Color(0xFF00796B),
                    ),
                  ),
                ),

                /// CONTENT
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 350),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            "OTP Verification",
                            style: GoogleFonts.montserrat(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF00695C),
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            "Code sent to +91 ${widget.phone}",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),

                          const SizedBox(height: 30),

                          /// PINPUT FIELD
                          Pinput(
                            length: 6,
                            controller: _otp,
                            keyboardType: TextInputType.number,
                            defaultPinTheme: PinTheme(
                              height: 60,
                              width: 50,
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00796B),
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xfff1f1f1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                            ),
                            focusedPinTheme: PinTheme(
                              height: 55,
                              width: 55,
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00796B),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFF00796B),
                                  width: 2,
                                ),
                              ),
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "Enter OTP";
                              }
                              if (v.length != 6) {
                                return "Enter 6-digit OTP";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 30),

                          /// VERIFY BUTTON
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  HapticFeedback.heavyImpact();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DashboardScreen(),
                                    ),
                                  );
                                }
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF009688),
                                      Color(0xFF00796B),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Verify OTP",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'We have sent an OTP to your phone number.\nPlease enter it to verify.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff979797),
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// SAME CLIPPERS YOU USED
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
    return path..close();
  }

  @override
  bool shouldReclip(_) => false;
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
    return path..close();
  }

  @override
  bool shouldReclip(_) => false;
}
