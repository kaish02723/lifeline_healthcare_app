import 'dart:convert';

import 'package:lifeline_healthcare_app/models/medicine/medicine_order_modal.dart';
import 'package:http/http.dart'as http;
class MedicineOrderService {
//final baseUrl='https://phone-auth-with-jwt-4.onrender.com/order';

List<MedicineOrderModal> getMedicineOrdersList=[];

 Future<void> getMedicineData()async{
   var response=await http.get(Uri.parse('https://phone-auth-with-jwt-4.onrender.com/order'));
   if(response.statusCode==200) {
     var decode = jsonDecode(response.body);
     List<dynamic> data = decode['data'];

     getMedicineOrdersList = data.map((e)=> MedicineOrderModal.fromJson(e)).toList();
   }else{
     print("Error:${response.statusCode}");
   }
 }
}