import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline_healthcare_app/providers/labtest_provider/book_test_provider.dart';
import 'package:provider/provider.dart';

class BookTestFormScreen extends StatefulWidget {
  final String testName;
  final String category;

  const BookTestFormScreen({
    super.key,
    required this.testName,
    required this.category,
  });

  @override
  State<BookTestFormScreen> createState() => _BookTestFormScreenState();
}

class _BookTestFormScreenState extends State<BookTestFormScreen> {
  @override
  Widget build(BuildContext context) {
    var bookTestProvider = Provider.of<BookTestProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Book Test"),
        backgroundColor: Color(0xff00796B),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: bookTestProvider.testFormKey,
          child: ListView(
            children: [
              const SizedBox(height: 10),

              // USER NAME
              Text("User Name", style: TextStyle(fontWeight: FontWeight.w600)),
              TextFormField(
                controller: bookTestProvider.testNameController,
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Name is required" : null,
              ),
              const SizedBox(height: 20),

              // TEST NAME (read-only)
              Text("Test Name", style: TextStyle(fontWeight: FontWeight.w600)),
              TextFormField(
                readOnly: true,
                initialValue: widget.testName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // CATEGORY (read-only)
              Text("Category", style: TextStyle(fontWeight: FontWeight.w600)),
              TextFormField(
                readOnly: true,
                initialValue: widget.category,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // PHONE NUMBER
              Text(
                "Phone Number",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              TextFormField(
                controller: bookTestProvider.testPhoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Enter phone number",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                ),
                validator: (value) =>
                    value!.length != 10 ? "Enter valid 10 digit number" : null,
              ),
              const SizedBox(height: 30),

              // SUBMIT BUTTON
              GestureDetector(
                onTap: () {
                  if (bookTestProvider.testFormKey.currentState!.validate()) {
                    var data = {
                      "user_name": bookTestProvider.testNameController.text,
                      "test_name": widget.testName,
                      "category": widget.category,
                      "phone": bookTestProvider.testPhoneController.text,
                    };
                    bookTestProvider.bookTest(data, context);
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      colors: [Color(0xff26A69A), Color(0xff00796B)],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
