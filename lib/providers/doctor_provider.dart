import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:lifeline_healthcare_app/models/doctor_model.dart';

class DoctorProvider with ChangeNotifier {
  final String baseUrl = "https://phone-auth-with-jwt-4.onrender.com";

  List<DoctorModel> allDoctorsList = [];
  List<DoctorModel> filteredDoctorsList = [];

  bool isLoading = false;
  String selectedSpeciality = "All";

  // ================= FETCH =================
  Future<void> getAllDoctors() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse("$baseUrl/consultDr/all"));

      if (response.statusCode == 200) {
        final List<dynamic> resBody = jsonDecode(response.body);

        allDoctorsList =
            resBody.map((e) => DoctorModel.fromJson(e)).toList();

        // default list
        filteredDoctorsList = allDoctorsList;
      } else {
        allDoctorsList = [];
        filteredDoctorsList = [];
      }
    } catch (e) {
      allDoctorsList = [];
      filteredDoctorsList = [];
      debugPrint("Doctor API Error: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  // ================= FILTER =================
  void filterBySpeciality(String speciality) {
    print("FILTER APPLY: $speciality");
    selectedSpeciality = speciality;

    if (speciality == "All") {
      filteredDoctorsList = allDoctorsList;
    } else {
      filteredDoctorsList = allDoctorsList.where((doctor) {
        return doctor.speciality != null &&
            doctor.speciality!.toLowerCase().contains(
              speciality.toLowerCase(),
            );
      }).toList();
    }

    notifyListeners();
  }

  void filterBySearchQuery(String query) {
    final baseList = selectedSpeciality == "All" ? allDoctorsList : filteredDoctorsList;
    if (query.isEmpty) {
      filteredDoctorsList = selectedSpeciality == "All" ? allDoctorsList : filteredDoctorsList;
    } else {
      filteredDoctorsList = baseList.where((doctor) {
        final name = doctor.name?.toLowerCase() ?? '';
        final speciality = doctor.speciality?.toLowerCase() ?? '';
        final q = query.toLowerCase();
        return name.contains(q) || speciality.contains(q);
      }).toList();
    }
    notifyListeners();
  }
}
