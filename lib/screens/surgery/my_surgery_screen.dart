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
          _info("Booked", formatDate(data.booked_At ?? '')),

          if ((data.status ?? '').toLowerCase() == "pending")
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  showCancelSurgeryDialog(context, index: index);
                },
                child: const Text(
                  "Cancel Surgery",
                  style: TextStyle(color: Colors.redAccent, fontSize: 13),
                ),
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

void showCancelSurgeryDialog(BuildContext context, {required int index}) {
  final controller = TextEditingController();

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text("Cancel Surgery"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter cancel reason"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              // cancel surgery
            },
            child: const Text("Yes, Cancel"),
          ),
        ],
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
