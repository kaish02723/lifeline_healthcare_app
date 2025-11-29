import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline_healthcare_app/verify_otp_screen.dart';

class EmailAuthScreen extends StatefulWidget {
  const EmailAuthScreen({super.key});

  @override
  State<EmailAuthScreen> createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            /// LIGHT GREEN LOWER CURVE
            ClipPath(
              clipper: LowerWaveClipper(),
              child: Container(height: 300, color: const Color(0xFF26A69A)),
            ),

            /// DARK GREEN UPPER CURVE
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
                  key: _formKey,
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
                          controller: _phoneController,
                          cursorColor: const Color(0xFF00695C),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone number is required*';
                            } else if (!phoneRegex.hasMatch(value)) {
                              return 'Enter a valid 10-digit phone number';
                            }
                            return null;
                          },

                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.email_rounded,
                              color: Color(0xFF00695C),
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
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // ---------------- LOGIN BUTTON ----------------
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 20,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpVerifyScreen(
                                    phone: _phoneController.text,
                                  ),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Login Successful "),
                                ),
                              );
                            } else {
                              HapticFeedback.mediumImpact();
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF00796B), Color(0xFF26A69A)],
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
                    ],
                  ),
                ),
              ),
            ),
            // Positioned(
            //   top: 280,
            //   left: 20,
            //   child: Image.asset(
            //     'images/injection_img.png',
            //     width: 40,
            //     height: 40,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

//
//  UPPER CURVE
//
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

//
// LOWER CURVE
//
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
