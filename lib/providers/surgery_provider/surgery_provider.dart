import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/core/utils/services/surgery_service.dart';
import 'package:lifeline_healthcare_app/providers/user_detail/auth_provider.dart';
import 'package:provider/provider.dart';

import '../models/surgery_model.dart';

class SurgeryProvider with ChangeNotifier {
  var testNameController = TextEditingController();
  var testPhoneNoController = TextEditingController();
  String? selectedSurgery;
  var testDescriptionController = TextEditingController();

  changeSelectedSurgeryValue(String value){
    selectedSurgery=value;
    notifyListeners();
  }

  List<BookSurgeryModel> surgeryList = [];

  Future<void> getSurgeryDataProvider(BuildContext context) async {
    var authProvider=Provider.of<AuthProvider>(context,listen: false);
    var user_Id=authProvider.userId;

    SurgeryService api = SurgeryService();
    await api.getSurgeryData(user_Id??'');

    surgeryList = api.getSurgeryList;
    notifyListeners();
  }

  Future<void> addSurgeryDataProvider(BuildContext context) async {
    // var authProvider=Provider.of<AuthProvider>(context,listen: false);
    // var user_Id=authProvider.userId;

    var data = {
      // "user_Id": user_Id,
      "name": testNameController.text,
      "phone_no": testPhoneNoController.text,
      "surgery_type": selectedSurgery,
      "description": testDescriptionController.text,
    };

    var result = await SurgeryService().postSurgeryData(data,context);

    if (result != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Surgery Data Added!")));
    }
  }
}