import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/color.dart';
import '../../providers/appointment_provider/book_appointment_provider.dart';
import '../../models/doctors/doctor_model.dart';
import '../../providers/doctor_slot_provider/doctor_slot_provider.dart';

class SlotBookingScreen extends StatefulWidget {
  final DoctorModel doctor;

  const SlotBookingScreen({super.key, required this.doctor});

  @override
  State<SlotBookingScreen> createState() => _SlotBookingScreenState();
}

class _SlotBookingScreenState extends State<SlotBookingScreen> {
  int selectedSlotId = -1;
  String selectedStartTime = "";
  String selectedEndTime = "";
  String selectedDate = "";
  String appointmentType = "Physical";

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: isDark ? AppColors.primaryDark : AppColors.primary,
        title: const Text("Book Appointment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _doctorCard(isDark),
              const SizedBox(height: 20),

              _sectionTitle("Select Date", isDark),
              _datePicker(isDark),

              const SizedBox(height: 20),
              _sectionTitle("Select Slot", isDark),
              _slotGrid(isDark),

              const SizedBox(height: 20),
              _sectionTitle("Appointment Type", isDark),
              _typeSelector(isDark),
              const SizedBox(height: 30),
              _bookButton(isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _doctorCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.grey.shade200,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: widget.doctor.image ?? "",
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Center(
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                errorWidget:
                    (context, url, error) =>
                        Icon(Icons.person, size: 32, color: Colors.grey),
              ),
            ),
          ),

          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.doctor.name ?? "",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textDark : AppColors.text,
                ),
              ),
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
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 30)),
          initialDate: DateTime.now(),
        );

        if (picked != null) {
          /// ✅ EXACT BACKEND FORMAT
          final formattedDate =
              "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

          setState(() {
            selectedDate = formattedDate;
            selectedSlotId = -1;
          });

          await Provider.of<DoctorSlotProvider>(
            context,
            listen: false,
          ).getGeneratedSlot(widget.doctor.id!, formattedDate);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.secondary),
        ),
        child: Text(
          selectedDate.isEmpty ? "Choose Date" : selectedDate,
          style: TextStyle(color: isDark ? AppColors.textDark : AppColors.text),
        ),
      ),
    );
  }

  Widget _slotGrid(bool isDark) {
    return Consumer<DoctorSlotProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.allGeneratedSlotList.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : AppColors.card,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              provider.message.isNotEmpty
                  ? provider.message
                  : "No slots available",
              style: TextStyle(
                color:
                    isDark
                        ? AppColors.lightGreyTextDark
                        : AppColors.lightGreyText,
              ),
            ),
          );
        }

        final slots = provider.allGeneratedSlotList.first.slots ?? [];

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              slots.map((slot) {
                final selected = selectedSlotId == slot.id;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSlotId = slot.id!;
                      selectedStartTime = slot.start_time!;
                      selectedEndTime = slot.end_time!;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color:
                          selected
                              ? AppColors.secondary
                              : (isDark ? AppColors.cardDark : AppColors.white),
                      border: Border.all(color: AppColors.secondary),
                    ),
                    child: Text(
                      "${slot.start_time} - ${slot.end_time}",
                      style: TextStyle(
                        color: selected ? Colors.white : AppColors.text,
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
    return Row(
      children:
          ["Physical", "Video"].map((type) {
            final selected = appointmentType == type;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => appointmentType = type),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                        selected
                            ? AppColors.primary
                            : (isDark ? AppColors.cardDark : AppColors.white),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.primary),
                  ),
                  child: Center(
                    child: Text(
                      type,
                      style: TextStyle(
                        color: selected ? Colors.white : AppColors.text,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _bookButton(bool isDark) {
    return Consumer<BookAppointmentProvider>(
      builder: (context, provider, _) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.all(16),
            ),
            onPressed:
                provider.isLoading
                    ? null
                    : () async {
                      if (selectedDate.isEmpty || selectedSlotId == -1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select date & slot"),
                          ),
                        );
                        return;
                      }

                      final result = await provider.createAppointment(
                        context: context,
                        doctorId: widget.doctor.id!,
                        slotId: selectedSlotId,
                        slotDate: selectedDate,
                        startTime: selectedStartTime,
                        endTime: selectedEndTime,
                        type: appointmentType,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result["message"]),
                          backgroundColor:
                              result["success"]
                                  ? Colors.green.shade800
                                  : Colors.red.shade800,
                        ),
                      );
                    },
            child:
                provider.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                      "Confirm Appointment",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
          ),
        );
      },
    );
  }

  Widget _sectionTitle(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isDark ? AppColors.textDark : AppColors.text,
        ),
      ),
    );
  }
}
