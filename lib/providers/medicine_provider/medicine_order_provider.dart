import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../services/medicine_order_service.dart';

import '../../models/medicine_models/medicine_order_modal.dart';

class MedicineOrderProvider with ChangeNotifier {
  final MedicineOrderService service = MedicineOrderService();
  List<MedicineOrderModal> ordersDetailList = [];

  //medicine checkout screen
  String selectedPayment = 'COD';

  changePaymentMethod(String value) {
    selectedPayment = value;
    notifyListeners();
  }

  Future<void> getMedicine() async {
    ordersDetailList = await service.getMedicineData();
    notifyListeners();
  }

  Future<void> createFullOrder({
    required Map<String, dynamic> order,
    required List<Map<String, dynamic>> items,
    required BuildContext context
  }) async {
    final data = {"order": order, "items": items};

    await service.createMedicineOrder(context, data);
  }

  String generateOrderCode() {
    return "ORD-${DateTime.now().millisecondsSinceEpoch}";
  }
}
