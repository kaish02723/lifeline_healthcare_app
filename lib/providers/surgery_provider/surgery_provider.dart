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
  var surgeryCancelController = TextEditingController();

  // update controller
  var updateNameController = TextEditingController();
  var updatePhoneNoController = TextEditingController();
  var updateSurgeryTypeController = TextEditingController();
  var updateDescriptionController = TextEditingController();

  bool isLoading = false;
  bool isSubmitting = false;

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
        "patient_name": testNameController.text.trim(),
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

  Future<void> cancelSurgery(int requestId, BuildContext context) async {
    try {
      isSubmitting = true;
      notifyListeners();

      final reason = {"cancel_reason": surgeryCancelController.text.trim()};

      final service = SurgeryService();
      final success = await service.cancelSurgery(requestId, reason, context);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Surgery cancelled successfully"),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );

        surgeryCancelController.clear();

        await getSurgeryDataProvider(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to cancel surgery"),
            backgroundColor: Colors.black87,
          ),
        );
      }
    } catch (e) {
      debugPrint("Provider cancel error: $e");
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  Future<void> updateSurgery(int requestId, BuildContext context) async {
    try {
      isSubmitting = true;
      notifyListeners();

      final newData = {
        "patient_name": updateNameController.text.trim(),
        "phone_no": updatePhoneNoController.text.trim(),
        "surgery_type": updateSurgeryTypeController.text.trim(),
        "description": updateDescriptionController.text.trim(),
      };

      final service = SurgeryService();
      final success = await service.updateSurgeryDetail(
        requestId,
        context,
        newData,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            showCloseIcon: true,
            closeIconColor: Colors.white,
            content: const Text("Surgery updated successfully"),
            backgroundColor: Colors.green.shade800,
            behavior: SnackBarBehavior.floating,
          ),
        );

        await getSurgeryDataProvider(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            showCloseIcon: true,
            closeIconColor: Colors.white,
            backgroundColor: Colors.red.shade800,
            behavior: SnackBarBehavior.floating,
            content: Text("Failed to update surgery"),
          ),
        );
      }
    } catch (e) {
      debugPrint("Update provider error: $e");
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }
}
