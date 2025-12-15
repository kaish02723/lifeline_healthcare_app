

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showRateUsBottomSheet(BuildContext context) {
  int selectedRating = 0;
  TextEditingController feedbackController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Rate Your Experience",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Lifeline Healthcare ke sath aapka experience kaisa raha?",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 16),

                // ⭐ STAR RATING
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      onPressed: () {
                        setState(() {
                          selectedRating = index + 1;
                        });
                      },
                      icon: Icon(
                        Icons.star,
                        size: 34,
                        color: index < selectedRating
                            ? const Color(0xFFFFC107)
                            : Colors.grey.shade400,
                      ),
                    );
                  }),
                ),

                // FEEDBACK FIELD
                TextField(
                  controller: feedbackController,
                  maxLength: 200,
                  decoration: InputDecoration(
                    hintText: "Short feedback (optional)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // SUBMIT BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC107),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      if (selectedRating == 0) return;

                      Navigator.pop(context);

                      if (selectedRating >= 4) {
                        // 👉 Play Store redirect
                        // final url = Uri.parse(
                        //   "https://play.google.com/store/apps/details?id=com.lifeline.healthcare",
                        // );
                        // await launchUrl(url, mode: LaunchMode.externalApplication);
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Thank you for rating Lifeline Healthcare 💙",
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Submit Rating",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
