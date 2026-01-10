import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/surgery_provider/surgery_provider.dart';
import '../../widgets/animated_loader.dart';
import '../../config/color.dart';
import 'surgery_booking_screen.dart';

class MySurgeryScreen extends StatefulWidget {
  const MySurgeryScreen({super.key});

  @override
  State<MySurgeryScreen> createState() => _MySurgeryScreenState();
}

class _MySurgeryScreenState extends State<MySurgeryScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await Provider.of<SurgeryProvider>(
      context,
      listen: false,
    ).getSurgeryDataProvider(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,

      appBar: AppBar(
        backgroundColor: isDark ? AppColors.primaryDark : AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text("My Surgeries"),
        leading: const BackButton(color: Colors.white),
      ),

      body: Consumer<SurgeryProvider>(
        builder: (context, value, _) {
          if (value.isLoading) {
            return const Center(child: MedicalCrossLoader());
          }

          if (value.surgeryList.isEmpty) {
            return const _EmptyState();
          }

          return RefreshIndicator(
            color: Colors.teal,
            onRefresh: fetchData,
            child: ListView.builder(
              padding: EdgeInsets.all(w * 0.04),
              itemCount: value.surgeryList.length,
              itemBuilder: (context, index) {
                final data = value.surgeryList[index];

                return TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 500),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: _SurgeryCard(data: data, isDark: isDark, index: index),
                );
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: isDark ? AppColors.primaryDark : AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("Book Surgery"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SurgeryBookingScreen()),
          );
        },
      ),
    );
  }
}

class _SurgeryCard extends StatelessWidget {
  final dynamic data;
  final bool isDark;
  final int index;

  const _SurgeryCard({
    required this.data,
    required this.isDark,
    required this.index,
  });

  String formatDate(String date) {
    try {
      final d = DateTime.parse(date);
      return DateFormat('dd MMM yyyy, hh:mm a').format(d);
    } catch (_) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            children: [
              Icon(Icons.local_hospital, color: AppColors.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  data.surgery_type ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textDark : AppColors.text,
                  ),
                ),
              ),
              _StatusChip(status: data.status ?? ''),
            ],
          ),

          const SizedBox(height: 12),
          _info("Patient", data.name),
          _info("Phone", data.phone_no),
          _info("Description", data.description),
          _info("Booked", formatDate(data.createdAt ?? '')),

          if ((data.status ?? '').toLowerCase() == "pending")
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      final provider = Provider.of<SurgeryProvider>(
                        context,
                        listen: false,
                      );

                      // 🔥 Prefill controllers
                      provider.updateNameController.text = data.name ?? '';
                      provider.updatePhoneNoController.text =
                          data.phone_no ?? '';
                      provider.updateSurgeryTypeController.text =
                          data.surgery_type ?? '';
                      provider.updateDescriptionController.text =
                          data.description ?? '';

                      showEditSurgeryBottomSheet(
                        context,
                        requestId: data.requestId,
                      );
                    },
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text("Edit"),
                  ),

                  TextButton(
                    onPressed: () {
                      showCancelSurgeryDialog(
                        context,
                        requestId: data.requestId,
                      );
                    },
                    child: const Text(
                      "Cancel Surgery",
                      style: TextStyle(color: Colors.redAccent, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _info(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        "$title : ${value ?? ''}",
        style: TextStyle(
          fontSize: 14,
          color: isDark ? Colors.white70 : Colors.grey.shade700,
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color =
        status.toLowerCase() == "completed"
            ? Colors.green
            : status.toLowerCase() == "cancelled"
            ? Colors.red
            : Colors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

void showCancelSurgeryDialog(BuildContext context, {required int requestId}) {
  showDialog(
    context: context,
    builder: (_) {
      return Consumer<SurgeryProvider>(
        builder: (context, surgeryProvider, _) {
          return AlertDialog(
            title: const Text("Cancel Surgery"),
            content: TextField(
              controller: surgeryProvider.surgeryCancelController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Enter cancel reason",
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  surgeryProvider.surgeryCancelController.clear();
                  Navigator.pop(context);
                },
                child: const Text("No"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                onPressed:
                    surgeryProvider.isSubmitting
                        ? null
                        : () async {
                          await surgeryProvider.cancelSurgery(
                            requestId,
                            context,
                          );

                          Navigator.pop(context); // ✅ close dialog
                        },
                child:
                    surgeryProvider.isSubmitting
                        ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                        : const Text("Yes, Cancel"),
              ),
            ],
          );
        },
      );
    },
  );
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.local_hospital_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text("No surgery booked yet"),
          SizedBox(height: 6),
          Text("Tap + to book surgery"),
        ],
      ),
    );
  }
}

void showEditSurgeryBottomSheet(
  BuildContext context, {
  required int requestId,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: isDark ? AppColors.cardDark : AppColors.card,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) {
      return Consumer<SurgeryProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 4,
                      width: 40,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  Text(
                    "Edit Surgery",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.textDark : AppColors.text,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _editField(
                    controller: provider.updateNameController,
                    label: "Patient Name",
                    icon: Icons.person,
                    isDark: isDark,
                  ),

                  _editField(
                    controller: provider.updatePhoneNoController,
                    label: "Phone Number",
                    icon: Icons.phone,
                    keyboard: TextInputType.phone,
                    isDark: isDark,
                  ),

                  _editField(
                    controller: provider.updateSurgeryTypeController,
                    label: "Surgery Type",
                    icon: Icons.local_hospital,
                    isDark: isDark,
                  ),

                  _editField(
                    controller: provider.updateDescriptionController,
                    label: "Description",
                    icon: Icons.notes,
                    maxLines: 3,
                    isDark: isDark,
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isDark ? AppColors.primaryDark : AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed:
                          provider.isSubmitting
                              ? null
                              : () async {
                                await provider.updateSurgery(
                                  requestId,
                                  context,
                                );

                                Navigator.pop(context);
                              },
                      child:
                          provider.isSubmitting
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                              : const Text(
                                "Update Surgery",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget _editField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  required bool isDark,
  TextInputType keyboard = TextInputType.text,
  int maxLines = 1,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: TextField(
      controller: controller,
      keyboardType: keyboard,
      maxLines: maxLines,
      cursorColor: isDark ? AppColors.colorTextDark : AppColors.colorText,
      style: TextStyle(
        color: isDark ? AppColors.textDark : AppColors.text,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: isDark ? AppColors.lightGreyTextDark : AppColors.lightGreyText,
        ),
        floatingLabelStyle: TextStyle(
          color: isDark ? AppColors.colorTextDark : AppColors.colorText,
          fontWeight: FontWeight.w600,
        ),
        prefixIcon: Icon(
          icon,
          color: isDark ? AppColors.iconDark : AppColors.icon,
        ),
        filled: true,
        fillColor:
            isDark
                ? AppColors.backgroundDark.withOpacity(0.6)
                : AppColors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color:
                isDark
                    ? AppColors.greyTextDark.withOpacity(0.3)
                    : Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? AppColors.primaryDark : AppColors.primary,
            width: 1.4,
          ),
        ),
      ),
    ),
  );
}
