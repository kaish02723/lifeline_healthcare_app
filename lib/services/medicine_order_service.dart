import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/medicine_models/medicine_order_modal.dart';

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


  Future<void> createMedicineOrder(Map<String, dynamic> data) async {
    var response = await http.post(
      Uri.parse('$baseUrl/order/create'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Order Confirmed");
      print(response.body);
    } else {
      print("Error: ${response.statusCode}");
      print(response.body);
    }
  }
}
