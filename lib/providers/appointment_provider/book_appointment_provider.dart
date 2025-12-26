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
}
