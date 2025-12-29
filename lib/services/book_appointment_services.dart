import 'dart:convert';

import 'package:lifeline_healthcare_app/models/appointment_model/book_appointment_modal.dart';
import 'package:http/http.dart' as http;

class BookAppointmentServices {
  final String token;
  final baseUrl = 'https://phone-auth-with-jwt-4.onrender.com';

  BookAppointmentServices({required this.token});

  List<BookAppointmentModal> getBookAppointment = [];

  Future<void> bookAppointmentGet() async {
    final response = await http.get(
      Uri.parse('$baseUrl/appointments/my'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    print("STATUS CODE ${response.statusCode}");
    print("RAW RESPONSE ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      getBookAppointment = data
          .map((e) => BookAppointmentModal.convertToModel(e))
          .toList();
    } else {
      getBookAppointment = [];
    }
  }

  Future<bool> bookAppointment({
    required int doctorId,
    required int slotId,
    required String slotDate,
    required String startTime,
    required String endTime,
    required String type, // video / clinic
  }) async {
    final body = {
      "doctor_id": doctorId,
      "slot_id": slotId,
      "slot_date": slotDate,
      "start_time": startTime,
      "end_time": endTime,
      "type": type,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/appointments/book'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    print("POST STATUS CODE: ${response.statusCode}");
    print("POST RESPONSE: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
