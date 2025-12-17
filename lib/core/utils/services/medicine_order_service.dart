import 'dart:convert';

import 'package:lifeline_healthcare_app/models/medicine/medicine_order_modal.dart';
import 'package:http/http.dart' as http;

class MedicineOrderService {
  final baseUrl = 'https://phone-auth-with-jwt-4.onrender.com';

  List<MedicineOrderModal> getMedicineOrdersList = [];

  Future<List<MedicineOrderModal>> getMedicineData() async {
    var response = await http.get(Uri.parse('$baseUrl/order'));

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      List data = decoded['orders'];

      return data
          .map((e) => MedicineOrderModal.fromJson(e))
          .toList();
    } else {
      throw Exception("Error ${response.statusCode}");
    }
  }


  Future<void> postMedicineData(Map<String, dynamic> data) async {
    var response = await http.post(
      Uri.parse('$baseUrl/order/create'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Order Created Successfully");
      print(response.body);
    } else {
      print("Error: ${response.statusCode}");
      print(response.body);
    }
  }
}
