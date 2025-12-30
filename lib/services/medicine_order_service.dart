import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../models/medicine_models/medicine_order_modal.dart';
import '../providers/user_detail/auth_provider.dart';

class MedicineOrderService {
  final baseUrl = 'https://phone-auth-with-jwt-4.onrender.com';

  List<MedicineOrderModal> getMedicineOrdersList = [];

  Future<List<MedicineOrderModal>> getMedicineData() async {
    var response = await http.get(Uri.parse('$baseUrl/med-order'));

    print(response.body);
    print(response.request?.headers);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      List data = decoded['orders'];

      return data.map((e) => MedicineOrderModal.fromJson(e)).toList();
    } else {
      throw Exception("Error ${response.statusCode}");
    }
  }

  Future<void> createMedicineOrder(BuildContext context,Map<String, dynamic> data) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = await authProvider.getToken();

    var response = await http.post(
      Uri.parse('$baseUrl/med-order/create'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonEncode(data),
    );

    print(response.body);
    print(response.request?.headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Order Confirmed");
      print(response.body);
    } else {
      print("Error: ${response.statusCode}");
      print(response.body);
    }
  }
}
