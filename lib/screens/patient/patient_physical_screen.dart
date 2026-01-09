import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/doctor_provider/doctor_provider.dart';
import '../doctor/physical_summary_screen.dart';


class PhysicalAppointmentScreen extends StatefulWidget {
  static const Color primary = Color(0xFF00796B);

  const PhysicalAppointmentScreen({super.key});

  @override
  State<PhysicalAppointmentScreen> createState() =>
      _PhysicalAppointmentScreenState();
}

class _PhysicalAppointmentScreenState extends State<PhysicalAppointmentScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    /// Provider call without setState
    Future.microtask(() {
      context.read<DoctorProvider>().getAllDoctors();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
      isDark ? const Color(0xff121212) : const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: PhysicalAppointmentScreen.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Find Doctors'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔍 SEARCH BAR
              _searchBar(isDark),

              const SizedBox(height: 22),

              /// 🟢 MOST SEARCHED
              const Text(
                "Most searched specialities",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 14),

              Consumer<DoctorProvider>(
                builder: (context, provider, _) {
                  return _gridSection(provider.filteredTopList1, isDark);
                },
              ),

              const SizedBox(height: 26),

              /// 🟢 SURGERIES
              const Text(
                "Conditions that can be treated through surgeries",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),

              Consumer<DoctorProvider>(
                builder: (context, provider, _) {
                  return _gridSection(provider.filteredTopList2, isDark);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  /// 🔍 SEARCH BAR
  Widget _searchBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          context.read<DoctorProvider>().searchGridTitles(value);
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.search),
          hintText: "Search Symptoms / Specialities",
          border: InputBorder.none,
        ),
      ),
    );
  }

  ///  GRID SECTION
  Widget _gridSection(List<Map<String, dynamic>> list, bool isDark) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 20,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final item = list[index];

        return GestureDetector(
          onTap: () {
            final speciality = mapTitleToSpeciality(item['title']);

            ///  PROVIDER FILTER
            context.read<DoctorProvider>().filterBySpeciality(speciality);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PhysicalSummaryScreen(),
              ),
            );
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white10 : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CachedNetworkImage(
                  imageUrl: item['img'],
                  fit: BoxFit.contain,
                  errorWidget: (_, __, ___) =>
                  const Icon(Icons.broken_image),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item['title'],
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}

///  TITLE → SPECIALITY MAP
String mapTitleToSpeciality(String title) {
  switch (title.toLowerCase()) {
    case "stomach pain":
      return "Gastroenterology";
    case "vertigo":
    case "head aches":
      return "Neurology";
    case "acne":
    case "fungal infection":
      return "Dermatology";
    case "pcos":
    case "gynae colo":
      return "Gynecology";
    case "thyroid":
      return "Endocrinology";
    case "back pain":
    case "ortho-pedic":
      return "Orthopaedics";
    case "mental wellness":
      return "Psychiatry";
    case "general physician":
      return "General Physician";
    case "pediatrics":
      return "Pediatrics";
    case "sexology":
      return "Sexology";
    default:
      return "All";
  }
}