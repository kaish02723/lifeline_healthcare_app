import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/models/doctor_slot_model/slot_model.dart';
import 'package:lifeline_healthcare_app/services/doctor_slot_service/slot_service.dart';

class DoctorSlotProvider with ChangeNotifier {
  List<SlotModel> allGeneratedSlotList = [];
  bool isLoading = false;
  String message = "";

  String selectedDate = "";

  String displayDate = "";

  SlotDataModel? selectedSlot;
  String appointmentType = "Physical";

  final SlotService service = SlotService();


  Future<void> getGeneratedSlot(
      int doctorId,
      String apiDate, {
        String? displayDate,
      }) async {
    try {
      isLoading = true;
      message = "";

      selectedDate = apiDate; // backend use
      this.displayDate = displayDate ?? apiDate; // ui use
      selectedSlot = null;

      notifyListeners();

      final result =
      await service.getDoctorGeneratedSlot(doctorId, apiDate);

      allGeneratedSlotList = result;

      if (result.isEmpty) {
        message = "Doctor not available on this day";
      }
    } catch (e) {
      message = "Failed to load slots";
      allGeneratedSlotList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void selectSlot(SlotDataModel slot) {
    selectedSlot = slot;
    notifyListeners();
  }

  void changeAppointmentType(String type) {
    appointmentType = type;
    notifyListeners();
  }

  bool get canProceed =>
      selectedDate.isNotEmpty && selectedSlot != null;
}
