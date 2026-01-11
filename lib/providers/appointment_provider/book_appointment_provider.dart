import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/appointment_model/book_appointment_modal.dart';
import '../../services/book_appointment_services.dart';
import '../user_detail/auth_provider.dart';

class BookAppointmentProvider with ChangeNotifier {
  BookAppointmentServices? _service;
  final TextEditingController reasonController = TextEditingController();
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
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      _service ??= _getService(context);

      final result = await _service!.bookAppointment(
        doctorId: doctorId,
        slotId: slotId,
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

  Future<Map<String, dynamic>> cancelAppointment({
    required BuildContext context,
    required int appointmentId,
    required Map<String, dynamic> cancelReason,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      _service ??= _getService(context);

      final result = await _service!.cancelAppointment(
        appointmentId: appointmentId,
        cancelReason: cancelReason,
      );

      if (result["success"] == true) {
        await getBookAppointmentAll(context);
      }

      return result;
    } catch (e) {
      debugPrint("Cancel Appointment Error: $e");
      return {"success": false, "message": "Something went wrong"};
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
