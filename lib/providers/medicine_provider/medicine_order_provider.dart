import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lifeline_healthcare_app/core/utils/services/medicine_order_service.dart';

import '../../models/medicine_models/medicine_order_modal.dart';

class MedicineOrderProvider with ChangeNotifier {
  final MedicineOrderService service = MedicineOrderService();
  List<MedicineOrderModal> ordersDetailList = [];

  Future<void> getMedicine() async {
    ordersDetailList = await service.getMedicineData();
    notifyListeners();
  }

  Future<void> createFullOrder({
    required Map<String, dynamic> order,
    required List<Map<String, dynamic>> items,
  }) async {

    final data = {
      "order": order,
      "items": items,

    };

    await service.createMedicineOrder(data);
  }

  String generateOrderCode() {

    return "ORD-${DateTime.now().millisecondsSinceEpoch}";
  }
}
