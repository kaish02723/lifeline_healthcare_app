import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/appointment_model/book_appointment_modal.dart';
import '../../services/book_appointment_services.dart';
import '../user_detail/auth_provider.dart';

class BookAppointmentProvider with ChangeNotifier {
  BookAppointmentServices? _service;

  List<BookAppointmentModal> bookAppointment = [];
  bool isLoading = false;

  BookAppointmentServices _getService(BuildContext context) {
    final token = context.read<AuthProvider>().token;
    return BookAppointmentServices(token: token!);
  }

  Future<void> getBookAppointmentAll(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      _service ??= _getService(context);
      await _service!.bookAppointmentGet();
      bookAppointment = _service!.getBookAppointment;
    } catch (e) {
      debugPrint("Get Appointment Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> createAppointment({
    required BuildContext context,
    required int doctorId,
    required int slotId,
    required String slotDate,
    required String startTime,
    required String endTime,
    required String type,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      _service ??= _getService(context);

      final result = await _service!.bookAppointment(
        doctorId: doctorId,
        slotId: slotId,
        slotDate: slotDate,
        startTime: startTime,
        endTime: endTime,
        type: type,
      );

      if (result["success"] == true) {
        await getBookAppointmentAll(context);
      }

      return result;
    } catch (e) {
      return {"success": false, "message": "Something went wrong"};
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
