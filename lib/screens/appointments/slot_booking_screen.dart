import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifeline_healthcare_app/screens/doctor/pay_to_book_screen.dart';
import 'package:provider/provider.dart';

import '../../config/color.dart';
import '../../models/doctors/doctor_model.dart';
import '../../providers/doctor_slot_provider/doctor_slot_provider.dart';

class SlotBookingScreen extends StatefulWidget {
  final DoctorModel doctor;

  const SlotBookingScreen({super.key, required this.doctor});

  @override
  State<SlotBookingScreen> createState() => _SlotBookingScreenState();
}

class _SlotBookingScreenState extends State<SlotBookingScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,

      appBar: AppBar(
        backgroundColor: isDark ? AppColors.primaryDark : AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text("Book Appointment"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _doctorCard(isDark),
            const SizedBox(height: 24),

            _sectionTitle("Select Date", isDark),
            _datePicker(isDark),

            const SizedBox(height: 24),
            _sectionTitle("Select Slot", isDark),
            _slotGrid(isDark),

            const SizedBox(height: 24),
            _sectionTitle("Appointment Type", isDark),
            _typeSelector(isDark),

            const SizedBox(height: 32),
            _bookButton(isDark),
          ],
        ),
      ),
    );
  }

  Widget _doctorCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.card,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          if (!isDark)
            BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: isDark ? AppColors.iconDark : AppColors.icon,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: widget.doctor.image ?? "",
                width: 68,
                height: 68,
                fit: BoxFit.cover,
                placeholder:
                    (_, __) => const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                errorWidget: (_, __, ___) => const Icon(Icons.person, size: 34),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.doctor.name ?? "",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.textDark : AppColors.text,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.doctor.speciality ?? "",
                style: TextStyle(
                  color:
                      isDark
                          ? AppColors.lightGreyTextDark
                          : AppColors.lightGreyText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _datePicker(bool isDark) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 30)),
          initialDate: DateTime.now(),
        );

        if (picked != null) {
          final apiDate = DateFormat('yyyy-MM-dd').format(picked);
          final displayDate = DateFormat('dd MMM yyyy').format(picked);

          context.read<DoctorSlotProvider>().getGeneratedSlot(
            widget.doctor.id!,
            apiDate,
            displayDate: displayDate,
          );
        }
      },
      child: Consumer<DoctorSlotProvider>(
        builder: (_, provider, __) {
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : AppColors.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? AppColors.secondaryDark : AppColors.secondary,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: isDark ? AppColors.iconDark : AppColors.icon,
                ),
                const SizedBox(width: 10),
                Text(
                  provider.displayDate.isEmpty
                      ? "Choose Date"
                      : provider.displayDate,
                  style: TextStyle(
                    color: isDark ? AppColors.textDark : AppColors.text,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _slotGrid(bool isDark) {
    return Consumer<DoctorSlotProvider>(
      builder: (_, provider, __) {
        if (provider.isLoading) {
          return const Padding(
            padding: EdgeInsets.all(12),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.message.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              provider.message,
              style: TextStyle(
                color: isDark ? AppColors.greyTextDark : AppColors.greyText,
              ),
            ),
          );
        }

        if (provider.allGeneratedSlotList.isEmpty) {
          return const SizedBox.shrink();
        }

        final slots = provider.allGeneratedSlotList.first.slots ?? [];

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              slots.map((slot) {
                final selected = provider.selectedSlot?.id == slot.id;

                return GestureDetector(
                  onTap: () => provider.selectSlot(slot),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color:
                          selected
                              ? (isDark
                                  ? AppColors.secondaryDark
                                  : AppColors.secondary)
                              : (isDark ? AppColors.cardDark : AppColors.card),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color:
                            selected
                                ? (isDark
                                    ? AppColors.secondaryDark
                                    : AppColors.secondary)
                                : Colors.transparent,
                      ),
                    ),
                    child: Text(
                      "${slot.start_time} - ${slot.end_time}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color:
                            selected
                                ? Colors.white
                                : (isDark
                                    ? AppColors.textDark
                                    : AppColors.text),
                      ),
                    ),
                  ),
                );
              }).toList(),
        );
      },
    );
  }

  Widget _typeSelector(bool isDark) {
    return Consumer<DoctorSlotProvider>(
      builder: (_, provider, __) {
        return Row(
          children:
              ["Physical", "Video"].map((type) {
                final selected = provider.appointmentType == type;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => provider.changeAppointmentType(type),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color:
                            selected
                                ? (isDark
                                    ? AppColors.secondaryDark
                                    : AppColors.secondary)
                                : (isDark
                                    ? AppColors.cardDark
                                    : AppColors.card),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          type,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color:
                                selected
                                    ? Colors.white
                                    : (isDark
                                        ? AppColors.textDark
                                        : AppColors.text),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
        );
      },
    );
  }

  Widget _bookButton(bool isDark) {
    return Consumer<DoctorSlotProvider>(
      builder: (_, slotProvider, __) {
        return SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isDark ? AppColors.primaryDark : AppColors.primary,
              foregroundColor: Colors.white,
            ),
            onPressed:
                slotProvider.canProceed
                    ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => PayToBookScreen(
                                doctor: widget.doctor,
                                appointmentType: slotProvider.appointmentType,
                                selectedDate: slotProvider.selectedDate,
                                selectedStartTime:
                                    slotProvider.selectedSlot!.start_time!,
                                selectedEndTime:
                                    slotProvider.selectedSlot!.end_time!,
                                slotId: slotProvider.selectedSlot!.id!,
                              ),
                        ),
                      );
                    }
                    : null,
            child: const Text("Confirm Appointment"),
          ),
        );
      },
    );
  }

  Widget _sectionTitle(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: isDark ? AppColors.textDark : AppColors.text,
        ),
      ),
    );
  }
}
