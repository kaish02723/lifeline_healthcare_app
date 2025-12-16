import 'dart:ui';
import 'package:flutter/material.dart';
import '../../models/doctor_model.dart';

class DoctorDetailScreen extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorDetailScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xff0E0E0E) : const Color(0xffF6F8FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(),
        title: const Text('Doctor Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(w * 0.04),
        child: Column(
          children: [
            _glassCard(
              context,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: w * 0.18,
                    backgroundImage: NetworkImage(doctor.image ?? ''),
                  ),
                  SizedBox(height: h * 0.015),
                  Text(
                    doctor.name ?? '',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4),
                  Text(
                    doctor.speciality ?? '',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text('${doctor.rating ?? 0}'),
                      const SizedBox(width: 12),
                      Text('${doctor.totalConsult ?? 0}+ Consults'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: h * 0.025),
            _glassCard(
              context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow('Hospital', doctor.hospital),
                  _infoRow('Experience', doctor.experience),
                  _infoRow('Consultation Fee', doctor.fee),
                ],
              ),
            ),
            SizedBox(height: h * 0.02),
            _glassCard(
              context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Qualifications',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children:
                        (doctor.qualification ?? [])
                            .map(
                              (q) => Chip(
                                label: Text(q),
                                backgroundColor: Colors.white,
                              ),
                            )
                            .toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: h * 0.02),
            if (doctor.timing != null)
              _glassCard(
                context,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Available Timing',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      children:
                          doctor.timing!.day!
                              .map(
                                (d) => Chip(
                                  backgroundColor: Colors.white,
                                  label: Text(d),
                                  visualDensity: VisualDensity.compact,
                                ),
                              )
                              .toList(),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${doctor.timing!.start} AM - ${doctor.timing!.end} PM',
                      style: const TextStyle(height: 1.4),
                    ),
                  ],
                ),
              ),
            SizedBox(height: h * 0.04),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff00796B),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {},
                child: const Text('Book Appointment'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassCard(BuildContext context, {required Widget child}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                isDark
                    ? Colors.white.withOpacity(0.08)
                    : Colors.white.withOpacity(0.75),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value ?? '-')),
        ],
      ),
    );
  }
}
