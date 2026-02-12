import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lifeline_healthcare_app/models/doctor_slot_model/slot_model.dart';

class SlotService {
  final String baseUrl = 'https://healthcare.edugaondev.com';

  Future<List<SlotModel>> getDoctorGeneratedSlot(
      int doctorId,
      String selectedDate,
      ) async {
    final url = '$baseUrl/consultDr/$doctorId/slots?date=$selectedDate';

    final response = await http.get(Uri.parse(url));

    print("URL => $url");
    print("Status => ${response.statusCode}");
    print("Body => ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);

      if (decoded["generated"] == false) {
        return [];
      }

      return [SlotModel.convertToModel(decoded)];
    } else {
      throw Exception("Failed to load slots");
    }
  }
}

