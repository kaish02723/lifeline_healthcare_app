import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsersDetails extends StatefulWidget {
  const UsersDetails({super.key});

  @override
  State<UsersDetails> createState() => _UsersDetailsState();
}

class _UsersDetailsState extends State<UsersDetails> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    child: Container(height: 300, color: Color(0xFF26A69A)),
                  ),

                  ///  Dark Green Upper Wave
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.1416),
                    child: ClipPath(
                      clipper: UpperWaveClipper(),
                      child: Container(height: 300, color: Color(0xff00796B)),
                    ),
                  ),

                  /// FORM
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 300),
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          // Yeh add karo
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "Enter your Details",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              SizedBox(height: 30),

                              // Name Field
                              TextField(
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),

                                decoration: InputDecoration(
                                  labelText: "Full Name ",
                                  hintText: "Enter your name",
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    color: Colors.teal,
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintStyle: TextStyle(color: Colors.black45),
                                  floatingLabelStyle: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 18,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.teal,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 18),

                              // Gender Field
                              TextField(
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),

                                decoration: InputDecoration(
                                  labelText: "Gender",
                                  hintText: "Male / Female / Other",
                                  prefixIcon: Icon(
                                    Icons.male_outlined,
                                    color: Colors.teal,
                                  ),

                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintStyle: TextStyle(color: Colors.black45),
                                  floatingLabelStyle: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 18,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.teal,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 18),

                              // Date of Birth with Calendar Icon
                              TextField(
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                controller: dateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: "Date of Birth",
                                  hintText: "dd/mm/yyyy",
                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintStyle: TextStyle(color: Colors.black45),
                                  floatingLabelStyle: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 18,
                                  ),

                                  // thoda bada feel
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.calendar_today_rounded,
                                      color: Colors.teal,
                                    ),

                                    onPressed: () async {
                                      DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime.now(),
                                      );
                                      if (picked != null) {
                                        dateController.text =
                                        "${picked.day}/${picked.month}/${picked.year}";
                                      }
                                    },
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.teal,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 35),

                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                    foregroundColor: Colors.white,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
    return path..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
