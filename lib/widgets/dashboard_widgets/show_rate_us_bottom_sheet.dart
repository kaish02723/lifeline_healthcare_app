import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/rating_model/submit_rating_model.dart';
import '../../providers/rating_provider/submit_rating_provider.dart';

void showRateUsBottomSheet(BuildContext context) {
  final rootContext = context;

  TextEditingController feedbackController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) {
      return StatefulBuilder(
        builder: (sheetContext, setState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 16,
            ),
            child: Consumer<SubmitRatingProvider>(
              builder: (BuildContext context, value, Widget? child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Rate Your Experience",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Lifeline Healthcare ke sath aapka experience kaisa raha?",
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 16),

                    ///  STAR RATING
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          onPressed: () {
                            value.selectedRatingCount(index);
                          },
                          icon: Icon(
                            Icons.star,
                            size: 34,
                            color:
                                index < value.selectedRating
                                    ? const Color(0xFFFFC107)
                                    : Colors.grey.shade400,
                          ),
                        );
                      }),
                    ),

                    ///  FEEDBACK
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

                    ///  SUBMIT BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFC107),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed:
                            value.isLoading
                                ? null
                                : () async {
                                  if (value.selectedRating == 0) {
                                    ScaffoldMessenger.of(
                                      rootContext,
                                    ).showSnackBar(
                                      const SnackBar(
                                        content: Text("Please select rating"),
                                      ),
                                    );
                                    return;
                                  }

                                  final model = SubmitRatingModel(
                                    ratingTypes: "app",
                                    rating: value.selectedRating.toDouble(),
                                    feedback: feedbackController.text.trim(),
                                    appVersion: 1.0,
                                    platform: "android",
                                  );

                                  await value.submitRating(model, context);

                                  if (value.successMessage != null) {
                                    ScaffoldMessenger.of(
                                      rootContext,
                                    ).showSnackBar(
                                      SnackBar(
                                        content: Text(value.successMessage!),
                                      ),
                                    );

                                    Navigator.pop(sheetContext); // LAST
                                  }

                                  if (value.errorMessage != null) {
                                    ScaffoldMessenger.of(
                                      rootContext,
                                    ).showSnackBar(
                                      SnackBar(
                                        content: Text(value.errorMessage!),
                                      ),
                                    );
                                  }
                                },
                        child:
                            value.isLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.black,
                                )
                                : const Text(
                                  "Submit Rating",
                                  style: TextStyle(color: Colors.black),
                                ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      );
    },
  );
}
