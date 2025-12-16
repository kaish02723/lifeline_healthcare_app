import 'package:flutter/foundation.dart';
import 'package:lifeline_healthcare_app/core/utils/services/medicine_order_service.dart';
import 'package:lifeline_healthcare_app/models/medicine/medicine_order_modal.dart';

class MedicineOrderProvider  with ChangeNotifier{

  final MedicineOrderService = MedicineOrderModal();
  List<MedicineOrderModal> orders=[];

}