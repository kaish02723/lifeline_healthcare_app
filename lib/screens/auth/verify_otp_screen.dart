import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class OtpVerifyScreen extends StatefulWidget {
  final String phone;

  const OtpVerifyScreen({super.key, required this.phone});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).startTimer();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: LowerWaveClipper(),
                  child: Container(height: 300, color: const Color(0xFF009688)),
                ),

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

                Padding(
                  padding: const EdgeInsets.only(top: 330),
                  child: Form(
                    key: provider.otpFormKey,
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

                        Pinput(
                          length: 6,
                          controller: provider.otp,
                          keyboardType: TextInputType.number,
                          defaultPinTheme: PinTheme(
                            height: 60,
                            width: 52,
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
                            height: 60,
                            width: 52,
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

                        const SizedBox(height: 18),

                        ValueListenableBuilder(
                          valueListenable: provider.timerValue,
                          builder: (context, value, _) {
                            return Column(
                              children: [
                                Text(
                                  value > 0
                                      ? "Resend OTP in 00:${value.toString().padLeft(2, '0')}"
                                      : "Didn’t receive the OTP?",
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                GestureDetector(
                                  onTap: value == 0
                                      ? () {
                                          provider.resendOtp(
                                            widget.phone,
                                            context,
                                          );
                                          HapticFeedback.mediumImpact();
                                        }
                                      : null,
                                  child: Text(
                                    "Resend OTP",
                                    style: TextStyle(
                                      color: value == 0
                                          ? Colors.teal.shade700
                                          : Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        const SizedBox(height: 30),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if (provider.otpFormKey.currentState!
                                  .validate()) {
                                var data = {
                                  'phone': '+91${widget.phone}',
                                  'otp': provider.otp.text,
                                };
                                provider.verifyOtp(data, context);
                                HapticFeedback.heavyImpact();
                              }
                            },
                            child: Container(
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

                        const SizedBox(height: 15),
                      ],
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

/// ====================== SAME CLIPPERS YOU USED ======================
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
