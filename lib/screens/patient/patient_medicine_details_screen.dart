import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_medicine_cart_screen.dart';

class MedicineDetailsScreen extends StatelessWidget {
  const MedicineDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xff00796B),
        elevation: 0,
        title: const Text(
          "Product Details",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MedicineCart()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.location_on, size: 20, color: Colors.black87),
                SizedBox(width: 6),
                Text(
                  "Deliver to - Saran",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Center(
              child: Container(
                height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://m.media-amazon.com/images/I/71Kg39130xL.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "MuscleBlaze Whey Protein for gym",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            const Text(
              "By Bright Lifecare Pvt. Ltd. (HealthKart)",
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "₹499",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff009688),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            sectionTitle("Product Information"),
            sectionText(
              "Manufactures: Bright Lifecare Pvt. Ltd.\n"
              "Form: Powder\n"
              "Shelf Life: 18 months",
            ),

            const SizedBox(height: 22),

            sectionTitle("Know More"),
            sectionText(
              "• Ideal for gym-goers, athletes, and bodybuilders.\n"
              "• Take 1 scoop with 200–250 ml water or milk.\n"
              "• Use as a pre/post workout drink.\n"
              "• Store in a cool, dry place.",
            ),

            const SizedBox(height: 22),

            /// ------------------- RETURN POLICY -------------------
            sectionTitle("Return Policy"),
            sectionText(
              "Return Window: 7 days from the date of delivery.\n"
              "Product must be unopened and in original packaging.",
            ),

            const SizedBox(height: 22),

            /// ------------------- DISCLAIMER -------------------
            sectionTitle("Disclaimer"),
            sectionText(
              "This product is not intended to diagnose, treat, cure, or prevent any disease.\n"
              "Consult a doctor before use if pregnant, nursing, or under medication.\n"
              "Keep out of reach of children.",
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// ------------------- REUSABLE WIDGETS -------------------

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
    );
  }

  Widget sectionText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
    );
  }
}
