import 'package:flutter/cupertino.dart';

import '../../models/appointment_model/book_appointment_modal.dart';
import '../../services/book_appointment_services.dart';

class BookAppointmentProvider with ChangeNotifier {
   late BookAppointmentServices service;

   List<BookAppointmentModal> bookAppointment = [];
   bool isLoading = true;

   BookAppointmentProvider(String token) {
      service = BookAppointmentServices(token: token);
   }

   Future<void> getBookAppointmentAll() async {
      isLoading = true;
      notifyListeners();

      await service.BookAppointmentGet();
      bookAppointment = service.getBookAppointment;

      isLoading = false;
      notifyListeners();
   }
   Future<bool> createAppointment({
      required int doctorId,
      required String slotDate,
      required String startTime,
      required String endTime,
      required String type,
   }) async {
      isLoading = true;
      notifyListeners();

      final success = await service.bookAppointment(
         doctorId: doctorId,
         slotDate: slotDate,
         startTime: startTime,
         endTime: endTime,
         type: type,
      );

      if (success) {
         await getBookAppointmentAll(); // refresh list
      }

      isLoading = false;
      notifyListeners();
      return success;
   }
}

