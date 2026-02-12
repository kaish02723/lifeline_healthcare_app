import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lifeline_healthcare_app/providers/appointment_provider/book_appointment_provider.dart';
import 'package:provider/provider.dart';
import '../models/appointment_model/book_appointment_modal.dart';

class BookAppointmentServices {
  final String token;
  final baseUrl = 'https://healthcare.edugaondev.com';

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

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      getBookAppointment =
          data.map((e) => BookAppointmentModal.convertToModel(e)).toList();
    } else {
      getBookAppointment = [];
    }
  }

  Future<Map<String, dynamic>> bookAppointment({
    required int doctorId,
    required int slotId,
  }) async {
    final body = {"doctor_id": doctorId, "slot_id": slotId};

    final response = await http.post(
      Uri.parse('$baseUrl/appointments/book'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return {
        "success": true,
        "message": decoded["message"] ?? "Appointment booked successfully",
      };
    } else {
      return {
        "success": false,
        "message": decoded["message"] ?? "Failed to book appointment",
      };
    }
  }

  Future<Map<String, dynamic>> cancelAppointment({
    required int appointmentId,
    required Map<String, dynamic> cancelReason,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/appointments/cancel/$appointmentId'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(cancelReason),
    );

    print(response.body);
    print(response.request?.headers);

    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {
        "success": true,
        "message": decoded["message"] ?? "Appointment cancelled successfully",
      };
    } else {
      return {
        "success": false,
        "message": decoded["message"] ?? "Failed to cancel appointment",
      };
    }
  }
}
