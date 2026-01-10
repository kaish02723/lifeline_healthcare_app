import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/models/doctor_slot_model/slot_model.dart';
import 'package:lifeline_healthcare_app/services/doctor_slot_service/slot_service.dart';

class DoctorSlotProvider with ChangeNotifier {
  List<SlotModel> allGeneratedSlotList = [];
  bool isLoading = false;
  String message = "";

  SlotService service = SlotService();

  Future<void> getGeneratedSlot(int doctorId, String selectedDate) async {
    try {
      isLoading = true;
      message = "";
      notifyListeners();

      final result = await service.getDoctorGeneratedSlot(
        doctorId,
        selectedDate,
      );

      allGeneratedSlotList = result;

      if (result.isEmpty) {
        message = "Doctor not available on this day";
      }
    } catch (e) {
      message = "Failed to load slots";
      allGeneratedSlotList = [];
      print('Slot Error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
