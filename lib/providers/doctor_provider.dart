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

  Future<void> getAllDoctors() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse("$baseUrl/consultDr/all"));

      if (response.statusCode == 200) {
        final List<dynamic> resBody = jsonDecode(response.body);

        allDoctorsList =
            resBody.map((e) => DoctorModel.fromJson(e)).toList();

        if (selectedSpeciality == "All") {
          filteredDoctorsList = allDoctorsList;
        } else {
          filterBySpeciality(selectedSpeciality);
        }
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

  final Map<String, List<String>> specialityAliasMap = {
    "Psychiatry": ["Psychiatrist", "Mental Wellness", "Psychiatry"],
    "Gynecology": ["Gynecologist", "Gynae", "Gynecology"],
    "General Physician": [
      "General Physician",
      "Physician",
      "General Medicine"
    ],
    "Dermatology": ["Dermatologist", "Dermatology", "Skin"],
    "Orthopaedics": ["Orthopedic", "Orthopaedics", "Ortho"],
    "Pediatrics": ["Pediatrician", "Pediatrics", "Child"],
    "Sexology": ["Sexologist", "Sexology"],
    "Neurology": ["Neurologist", "Neurology"],
    "Gastroenterology": ["Gastroenterologist", "Gastroenterology"],
    "Endocrinology": ["Endocrinologist", "Endocrinology"],
  };


  void filterBySpeciality(String speciality) {
    print("FILTER APPLY: $speciality");
    selectedSpeciality = speciality;

    if (speciality == "All") {
      filteredDoctorsList = allDoctorsList;
    } else {
      filteredDoctorsList = allDoctorsList.where((doctor) {
        final docSpec = doctor.speciality?.toLowerCase() ?? "";

        final aliases =
            specialityAliasMap[speciality]?.map((e) => e.toLowerCase()) ?? [];

        return aliases.any((alias) => docSpec.contains(alias));
      }).toList();
    }

    notifyListeners();
  }


  void filterBySearchQuery(String query) {
    List<DoctorModel> baseList;

    if (selectedSpeciality == "All") {
      baseList = allDoctorsList;
    } else {
      baseList = allDoctorsList.where((doctor) {
        return doctor.speciality != null &&
            doctor.speciality!.toLowerCase() ==
                selectedSpeciality.toLowerCase();
      }).toList();
    }

    if (query.isEmpty) {
      filteredDoctorsList = baseList;
    } else {
      final q = query.toLowerCase();
      filteredDoctorsList = baseList.where((doctor) {
        return (doctor.name ?? "").toLowerCase().contains(q) ||
            (doctor.speciality ?? "").toLowerCase().contains(q);
      }).toList();
    }

    notifyListeners();
  }
}
