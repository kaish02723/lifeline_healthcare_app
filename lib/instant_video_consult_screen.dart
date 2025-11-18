import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InstantVideoConsult extends StatelessWidget {
  const InstantVideoConsult({super.key});

  static const Color primary = Color(0xFF00796B);
  static const Color lightAccent = Color(0xFF009688);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.back, size: 23),
        ),
        backgroundColor: primary,
        elevation: 0,
        title: const Text(
          "Consult a doctor",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                "HELP",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Free follow-up card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F2F1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Free follow-up",
                      style: TextStyle(
                        color: primary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "for 7 days with every consultation",
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Know More >",
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Search
              const Text(
                "Search Health Problem/ symptoms",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: "Search symptoms..",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: const Color(0xfff1f1f1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Top Specialities heading
              sectionHeading("CHOOSE FROM TOP SPECIALITIES"),

              // Grid for top specialities (4 columns)
              GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 12,
                childAspectRatio: 0.73,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  CircleCategory(title: "Mental\nWellness", emoji: "🧠"),
                  CircleCategory(title: "Gynae\ncolo", emoji: "🤰"),
                  CircleCategory(title: "General\nphysician", emoji: "🩺"),
                  CircleCategory(title: "Derma\ntology", emoji: "🧴"),
                  CircleCategory(title: "Ortho-\npedic", emoji: "🦴"),
                  CircleCategory(title: "Pediat\nrics", emoji: "🧒"),
                  CircleCategory(title: "Sexology", emoji: "❤️"),
                  CircleCategory(title: "View\nAll", emoji: "ALL", isAll: true),
                ],
              ),

              const SizedBox(height: 28),

              // Common Health Issues
              sectionHeading("Common Health Issues"),
              GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 12,
                childAspectRatio: 0.73,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  CircleCategory(title: "Stomach\npain", emoji: "🤢"),
                  CircleCategory(title: "Vertigo", emoji: "😵"),
                  CircleCategory(title: "Acne", emoji: "🌿"),
                  CircleCategory(title: "PCOS", emoji: "🩺"),
                  CircleCategory(title: "Thyroid", emoji: "🧪"),
                  CircleCategory(title: "Head\naches", emoji: "🤕"),
                  CircleCategory(title: "Fungal\nInfection", emoji: "🍄"),
                  CircleCategory(title: "Back Pain", emoji: "🦴"),
                ],
              ),

              const SizedBox(height: 28),

              // General Physician
              sectionHeading("General Physician"),
              GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 12,
                childAspectRatio: 0.73,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  CircleCategory(title: "Fever", emoji: "🤒"),
                  CircleCategory(title: "High blood\npressure", emoji: "❤️‍🩹"),
                  CircleCategory(title: "Dizziness", emoji: "😵‍💫"),
                  CircleCategory(title: "Pneum\nonia", emoji: "🫁"),
                ],
              ),

              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionHeading(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
      ),
    );
  }
}

/// Reusable circular category widget
class CircleCategory extends StatelessWidget {
  final String title;
  final String emoji;
  final bool isAll;

  const CircleCategory({
    super.key,
    required this.title,
    required this.emoji,
    this.isAll = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color circleBg =
    isAll ? const Color(0xFF00796B) : const Color(0xFFE0F2F1);
    final Color emojiColor = isAll ? Colors.white : Colors.black87;
    final double emojiSize = isAll ? 14 : 26;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(color: circleBg, shape: BoxShape.circle),
          child: Center(
            child: Text(
              emoji,
              style: TextStyle(
                fontSize: emojiSize,
                color: emojiColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
