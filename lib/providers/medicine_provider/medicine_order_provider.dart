import 'package:flutter/material.dart';
import '../../services/medicine_order_service.dart';
import '../../models/medicine_models/medicine_order_modal.dart';

class MedicineOrderProvider with ChangeNotifier {
  final MedicineOrderService service = MedicineOrderService();
  final TextEditingController reasonController = TextEditingController();
  List<MedicineOrderModal> ordersDetailList = [];

  // payment method
  String selectedPayment = 'COD';

  // loading states
  bool isLoading = false; // GET loader
  bool isCreatingOrder = false; // CREATE loader

  void changePaymentMethod(String value) {
    selectedPayment = value;
    notifyListeners();
  }

  // GET ORDERS
  Future<void> getMedicine(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      ordersDetailList = await service.getMedicineData(context);

      // Latest first
      ordersDetailList.sort((a, b) {
        final aDate = a.orderedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bDate = b.orderedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bDate.compareTo(aDate);
      });
    } catch (e) {
      debugPrint("Get Orders Error: $e");
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // CREATE ORDER
  Future<int> createFullOrder({
    required Map<String, dynamic> order,
    required List<Map<String, dynamic>> items,
    required BuildContext context,
  }) async {
    try {
      isCreatingOrder = true;
      notifyListeners();

      final data = {"order": order, "items": items};

      /// ⬅️ service se response lo
      final int orderId = await service.createMedicineOrder(context, data);

      await getMedicine(context);

      return orderId; // 🔥 IMPORTANT
    } finally {
      isCreatingOrder = false;
      notifyListeners();
    }
  }

  Future<void> cancelOrder(BuildContext context, int orderId) async {
    try {
      final data = {"reason": reasonController.text};

      isLoading = true;
      notifyListeners();

      await service.cancelOrder(context, orderId, data);

      reasonController.clear();

      await getMedicine(context);
    } catch (e) {
      debugPrint("Cancel Order Error: $e");
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
