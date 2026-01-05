import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:lifeline_healthcare_app/providers/user_detail/auth_provider.dart';
import 'package:provider/provider.dart';

class PaymentApiService {

  String baseUrl = "https://phone-auth-with-jwt-4.onrender.com";

  /// 1️⃣ CREATE ORDER (backend)
  Future<Map<String, dynamic>> createOrder(BuildContext context,String serviceType,String serviceId,double amount)async{

    final authProvider=Provider.of<AuthProvider>(context,listen: false);
    final token=await authProvider.getToken();

    var url = Uri.parse("$baseUrl/payment/create-order");

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(
        {
          "service_type":serviceType,
          "service_id":serviceId,
          "amount":amount,
        }
      ),//serviceType,serviceId,amount
    );
    print(response.body);
    print(response.request?.headers);

    if(response.statusCode==200||response.statusCode==201){
      print("Error: Order created successfully");
      print(response.body);
    }else{
      print("Error: ${response.statusCode}");
      print(response.body);
    }
    return jsonDecode(response.body);
  }

  /// 2️⃣ VERIFY PAYMENT (after success)
  Future<Map<String, dynamic>> verifyPayment(
      BuildContext context,
      String paymentId,              // payments_v2.id
      String razorpayPaymentId,      // Razorpay response
      ) async {

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = await authProvider.getToken();

    final url = Uri.parse("$baseUrl/payment/verify-payment");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "payment_id": paymentId,
        "razorpay_payment_id": razorpayPaymentId,
      }),
    );

    print("VERIFY RESPONSE => ${response.body}");

    return jsonDecode(response.body);
  }

}
