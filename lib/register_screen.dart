import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline_healthcare_app/dashboard_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              children: [
                ///  Light Green Lower Wave
                ClipPath(
                  clipper: LowerWaveClipper(),
                  child: Container(height: 300, color: const Color(0xFF26A69A)),
                ),

                ///  Dark Green Upper Wave
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(3.1416),
                  child: ClipPath(
                    clipper: UpperWaveClipper(),
                    child: Container(height: 300, color: const Color(0xff00796B)),
                  ),
                ),

                /// FORM
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 300),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            "Create Account",
                            style: GoogleFonts.montserrat(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF00695C),
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            "Register to continue",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 25),

                          /// NAME FIELD
                          _buildInputField(
                            controller: _name,
                            hint: "Full Name",
                            icon: Icons.person,
                            validator: (val) =>
                            val!.isEmpty ? "Name is required*" : null,
                          ),

                          /// EMAIL FIELD
                          _buildInputField(
                            controller: _email,
                            hint: "Email Address",
                            icon: Icons.email_outlined,
                            keyboard: TextInputType.emailAddress,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Email is required*";
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                                  .hasMatch(val)) {
                                return "Enter a valid email!";
                              }
                              return null;
                            },
                          ),

                          /// PASSWORD FIELD
                          _buildInputField(
                            controller: _password,
                            hint: "Password",
                            icon: Icons.lock_outline,
                            obscure: _hidePassword,
                            toggleVisibility: () {
                              setState(() => _hidePassword = !_hidePassword);
                            },
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Password is required*";
                              }
                              if (val.length < 6) {
                                return "Password must be 6+ characters";
                              }
                              return null;
                            },
                          ),

                          /// SIGNUP BUTTON
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen(),));
                                  HapticFeedback.lightImpact();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Account Created Successfully"),
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
                                    colors: [ Color(0xFF26A69A),Color(0xFF00796B),],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Sign Up",
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// ------------- INPUT FIELD BUILDER --------------
  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
    bool obscure = false,
    Function()? toggleVisibility,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        obscureText: obscure,
        validator: validator,
        cursorColor: const Color(0xFF00695C),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFF00695C)),
          suffixIcon: toggleVisibility != null
              ? IconButton(
            icon: Icon(
              obscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: toggleVisibility,
          )
              : null,
          hintText: hint,
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
    );
  }
}

/// ------------------- CURVE CLIPPERS -------------------

class UpperWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(size.width * 0.25, size.height - 180,
        size.width * 0.55, size.height - 120);
    path.quadraticBezierTo(
        size.width * 0.85, size.height - 45, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    return path..close();
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
        size.width * 0.25, size.height - 47, size.width * 0.5, size.height - 80);
    path.quadraticBezierTo(
        size.width * 0.8, size.height - 109, size.width, size.height - 45);
    path.lineTo(size.width, 0);
    return path..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
