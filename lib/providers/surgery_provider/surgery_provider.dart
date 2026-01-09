import 'package:flutter/material.dart';
import 'package:lifeline_healthcare_app/providers/user_detail/auth_provider.dart';
import 'package:lifeline_healthcare_app/screens/home/dashboard_screen.dart';
import 'package:provider/provider.dart';
import '../../models/surgery/surgery_model.dart';
import '../../services/surgery_service.dart';

class SurgeryProvider with ChangeNotifier {
  var testNameController = TextEditingController();
  var testPhoneNoController = TextEditingController();
  String? selectedSurgery;
  var testDescriptionController = TextEditingController();

  bool isLoading = false; // 👈 GET loader
  bool isSubmitting = false; // 👈 POST loader

  changeSelectedSurgeryValue(String value) {
    selectedSurgery = value;
    notifyListeners();
  }

  List<BookSurgeryModel> surgeryList = [];

  Future<void> getSurgeryDataProvider(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      var userId = authProvider.userId;

      SurgeryService api = SurgeryService();
      await api.getSurgeryData(context, userId ?? '');

      surgeryList = api.getSurgeryList;
    } catch (e) {
      debugPrint("Get Surgery Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addSurgeryDataProvider(BuildContext context) async {
    try {
      isSubmitting = true;
      notifyListeners();

      var data = {
        "name": testNameController.text.trim(),
        "phone_no": testPhoneNoController.text.trim(),
        "surgery_type": selectedSurgery,
        "description": testDescriptionController.text.trim(),
      };

      var result = await SurgeryService().postSurgeryData(data, context);

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            showCloseIcon: true,
            closeIconColor: Colors.white,
            backgroundColor: Colors.green.shade800,
            behavior: SnackBarBehavior.floating,
            content: Text("Surgery Data Added!"),
          ),
        );

        // optional: refresh list
        await getSurgeryDataProvider(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      debugPrint("Add Surgery Error: $e");
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }
}
