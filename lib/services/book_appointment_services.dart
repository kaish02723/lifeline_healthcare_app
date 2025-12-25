import 'dart:convert';

import 'package:lifeline_healthcare_app/models/appointment_model/book_appointment_modal.dart';
import 'package:http/http.dart' as http;

class BookAppointmentServices {
  final baseUrl = 'https://phone-auth-with-jwt-4.onrender.com';

  List<BookAppointmentModal> getBookAppointment = [];

  Future<void> BookAppointmentGet() async {
    var response = await http.get(Uri.parse('$baseUrl/appointments/my'));
    if (response.statusCode == 200) {
      final resBody = jsonDecode(response.body);
      List<dynamic> data = resBody;
      getBookAppointment =
          data.map((e) => BookAppointmentModal.convertToModel(e)).toList();
    }
  }
}
