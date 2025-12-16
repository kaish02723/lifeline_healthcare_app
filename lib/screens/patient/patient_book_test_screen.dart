import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline_healthcare_app/providers/labtest_provider/book_test_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

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

  // ✅ SUCCESS + REVIEW DIALOG
  void showTestSuccessDialog() {
    int rating = 0;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Center(
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 70,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Test Booked Successfully 🎉",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(widget.testName,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(widget.category,
                        style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 16),

                    // ⭐ RATING
                    const Text("Rate your experience"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          onPressed: () {
                            setState(() {
                              rating = index + 1;
                            });
                          },
                          icon: Icon(
                            Icons.star,
                            color: index < rating
                                ? const Color(0xFFFFC107)
                                : Colors.grey,
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context); // dialog close
                          Navigator.pop(context); // screen close
                        },
                        child: const Text(
                          "OK",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var bookTestProvider = Provider.of<BookTestProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Test"),
        backgroundColor: const Color(0xff00796B),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: bookTestProvider.testFormKey,
          child: ListView(
            children: [

              Text("User Name", style: TextStyle(fontWeight: FontWeight.w600)),
              TextFormField(
                controller: bookTestProvider.testNameController,
                validator: (v) => v!.isEmpty ? "Name required" : null,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),

              Text("Test Name"),
              TextFormField(
                readOnly: true,
                initialValue: widget.testName,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),

              Text("Category"),
              TextFormField(
                readOnly: true,
                initialValue: widget.category,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),

              Text("Phone Number"),
              TextFormField(
                controller: bookTestProvider.testPhoneController,
                keyboardType: TextInputType.phone,
                validator: (v) =>
                v!.length != 10 ? "Enter valid number" : null,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 30),

              GestureDetector(
                onTap: () async {
                  final auth =
                  Provider.of<AuthProvider>(context, listen: false);

                  if (bookTestProvider.testFormKey.currentState!.validate()) {
                    var data = {
                      "user_id": auth.userId,
                      "user_name":
                      bookTestProvider.testNameController.text,
                      "test_name": widget.testName,
                      "category": widget.category,
                      "phone":
                      bookTestProvider.testPhoneController.text,
                    };

                    bool success =
                    await bookTestProvider.bookTest(data);

                    if (success) {
                      showTestSuccessDialog();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Booking failed")),
                      );
                    }
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

