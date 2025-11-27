import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/screens/patient/patient_medicine_cart_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff00796B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          const Icon(Icons.share, color: Colors.white),
          const SizedBox(width: 16),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MedicineCart(),));
          },
          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              const SizedBox(height: 16),

              // Product Image
              Center(
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'https://cdn-icons-png.flaticon.com/256/4861/4861715.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                "MuscleBlaze Whey Protein for gym",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              const Text(
                "By Bright Lifecare Pvt. Ltd. (HealthKart)",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),

              const SizedBox(height: 16),

              // Price + Add to cart
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "₹499",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff009688),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Add to Cart", style: TextStyle(color: Colors.white)),
                  )
                ],
              ),

              const SizedBox(height: 24),

              const Text(
                "Product Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              const Text(
                "Manufactures: Bright Lifecare Pvt. Ltd.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              const SizedBox(height: 16),

              const Text(
                "Know More",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              const Text(
                "Ideal for gym-goers, athletes, and bodybuilders.\nConsume 1 scoop with 200–250 ml water or milk.\nCan also be taken as a mid-meal protein boost.\nStore in a cool, dry place away from sunlight.",
                style: TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
              ),

              const SizedBox(height: 16),

              const Text(
                "Return Policy",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              const Text(
                "Return Window: 7 days from the date of delivery",
                style: TextStyle(fontSize: 14, height: 1.5),
              ),

              const SizedBox(height: 16),

              const Text(
                "Disclaimer",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              const Text(
                "This product is not intended to diagnose, treat, cure, or prevent any disease.\nConsult a nutritionist or doctor before use if you are under medication, pregnant, or nursing.\nKeep out of reach of children.\nResults may vary depending on diet and exercise.",
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
