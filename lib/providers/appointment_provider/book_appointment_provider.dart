import 'package:flutter/cupertino.dart';

import '../../models/appointment_model/book_appointment_modal.dart';
import '../../services/book_appointment_services.dart';

class BookAppointmentProvider with ChangeNotifier {
  late BookAppointmentServices service;

  List<BookAppointmentModal> bookAppointment = [];
  bool isLoading = false;

  BookAppointmentProvider(String token) {
    service = BookAppointmentServices(token: token);
  }

  Future<void> getBookAppointmentAll() async {
    isLoading = true;
    notifyListeners();

    try {
      await service.bookAppointmentGet();
      bookAppointment = service.getBookAppointment;
    } catch (e) {
      debugPrint("Get Appointment Error: $e");
    } finally {
      isLoading = false; // 🔴 THIS LINE FIXES YOUR ISSUE
      notifyListeners();
    }
  }

  Future<bool> createAppointment({
    required int doctorId,
    required int slotId,
    required String slotDate,
    required String startTime,
    required String endTime,
    required String type,
  }) async {
    isLoading = true;
    notifyListeners();

    bool success = false;

    try {
      success = await service.bookAppointment(
        doctorId: doctorId,
        slotId: slotId,
        slotDate: slotDate,
        startTime: startTime,
        endTime: endTime,
        type: type,
      );

      if (success) {
        await getBookAppointmentAll(); // refresh list
      }
    } catch (e) {
      debugPrint("Create Appointment Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }

    return success;
  }
}

