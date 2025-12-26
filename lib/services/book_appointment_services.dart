import 'dart:convert';

import 'package:lifeline_healthcare_app/models/appointment_model/book_appointment_modal.dart';
import 'package:http/http.dart' as http;

class BookAppointmentServices {
 final String token;
  final baseUrl = 'https://phone-auth-with-jwt-4.onrender.com';
 BookAppointmentServices({required this.token});

  List<BookAppointmentModal> getBookAppointment = [];

  Future<void> BookAppointmentGet() async {
    var response = await http.get(Uri.parse('$baseUrl/appointments/my'),
      headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      },
    );

    print("STATUS CODE  ${response.statusCode}");
    print("RAW RESPONSE  ${response.body}");
    if (response.statusCode == 200) {
      final resBody = jsonDecode(response.body);
      List<dynamic> data = resBody['data']?? resBody;
      getBookAppointment =
          data.map((e) => BookAppointmentModal.convertToModel(e)).toList();
    }
  }
}
