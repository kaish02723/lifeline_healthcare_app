import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:lifeline_healthcare_app/models/doctors/doctor_model.dart';

class DoctorProvider with ChangeNotifier {
  final String baseUrl = "https://healthcare.edugaondev.com";
  bool isSearching = false;

  List<DoctorModel> allDoctorsList = [];
  List<DoctorModel> filteredDoctorsList = [];

  bool isLoading = false;

  String selectedSpeciality = "All";

  //  Grid Tiles Lists (Add these)
  List<Map<String, dynamic>> _topList1 = [];
  List<Map<String, dynamic>> _topList2 = [];
  List<Map<String, dynamic>> _filteredTopList1 = [];
  List<Map<String, dynamic>> _filteredTopList2 = [];

  //  Getters for Grid Lists
  List<Map<String, dynamic>> get filteredTopList1 => _filteredTopList1;
  List<Map<String, dynamic>> get filteredTopList2 => _filteredTopList2;

  Future<void> getAllDoctors() async {
    isLoading = true;
    notifyListeners();

    // Initialize Grid Data
    _initializeGridData();

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

  // Initialize Grid Data Method
  void _initializeGridData() {
    _topList1 = [
      {
        'title': 'Stomach Pain',
        'img': 'https://cdn-icons-png.flaticon.com/512/5730/5730077.png'
      },
      {
        'title': 'Vertigo',
        'img': 'https://cdn-icons-png.flaticon.com/512/2248/2248294.png'
      },
      {
        'title': 'Acne',
        'img': 'https://img.freepik.com/premium-vector/acne-skin-icon-problem-skin-dermatology_946691-311.jpg'
      },
      {
        'title': 'PCOS',
        'img': 'https://media.istockphoto.com/id/1326285050/vector/polycystic-ovary-syndrome-pcos-of-woman-female-reproductive-system-disease-abnormal-uterus.jpg?s=612x612&w=0&k=20&c=GPVImoSoP07FCv0cZ9_BqhNlTHgrmw5Kx_lB65OVOY4='
      },
      {
        'title': 'Thyroid',
        'img': 'https://cdn-icons-png.flaticon.com/128/2913/2913124.png'
      },
      {
        'title': 'Back Pain',
        'img': 'https://cdn-icons-png.flaticon.com/512/4939/4939268.png'
      },
      {
        'title': 'Mental Wellness',
        'img': 'https://media.istockphoto.com/id/1338729700/vector/intrinsic-motivation-gradient-linear-vector-icon.jpg?s=612x612&w=0&k=20&c=IFlMknR7mHYCBVxBqCKvLU9lohLSeIbB9WJdMCnpa3k='
      },
      {
        'title': 'General Physician',
        'img': 'https://cdn-icons-png.flaticon.com/128/2785/2785482.png'
      },
    ];

    _topList2 = [
      {
        'title': 'Head Aches',
        'img': 'https://cdn-icons-png.flaticon.com/512/16779/16779695.png'
      },
      {
        'title': 'Fungal Infection',
        'img': 'https://cdn-icons-png.flaticon.com/128/4223/4223545.png'
      },
      {
        'title': 'Gynae Colo',
        'img': 'https://cdn-icons-png.flaticon.com/128/8402/8402965.png'
      },
      {
        'title': 'Ortho-pedic',
        'img': 'https://cdn-icons-png.flaticon.com/128/7350/7350861.png'
      },
      {
        'title': 'Pediatrics',
        'img': 'https://cdn-icons-png.flaticon.com/128/6205/6205503.png'
      },
      {
        'title': 'Sexology',
        'img': 'https://cdn-icons-png.flaticon.com/128/6749/6749674.png'
      },
    ];

    // Initially filtered lists same as original
    _filteredTopList1 = List.from(_topList1);
    _filteredTopList2 = List.from(_topList2);
  }

  //  Search Grid Titles Method
  void searchGridTitles(String query) {
    if (query.isEmpty) {
      _filteredTopList1 = List.from(_topList1);
      _filteredTopList2 = List.from(_topList2);
    } else {
      final lowerQuery = query.toLowerCase();

      _filteredTopList1 = _topList1.where((item) {
        return item['title'].toString().toLowerCase().contains(lowerQuery);
      }).toList();

      _filteredTopList2 = _topList2.where((item) {
        return item['title'].toString().toLowerCase().contains(lowerQuery);
      }).toList();
    }

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
    "Sexology": ["Sexologist", "Sexology","sexlogy"],
    "Neurology": ["Neurologist", "Neurology"],
    "Gastroenterology": ["Gastroenterologist", "Gastroenterology"],
    "Endocrinology": ["Endocrinologist", "Endocrinology"],
  };

  void searchDoctors(String query) {
    isSearching = query.isNotEmpty;
    List<DoctorModel> baseList;

    if (selectedSpeciality == "All") {
      baseList = allDoctorsList;
    } else {
      baseList = allDoctorsList.where((doctor) {
        final docSpec = doctor.speciality?.toLowerCase() ?? "";
        final aliases =
            specialityAliasMap[selectedSpeciality]?.map((e) => e.toLowerCase()) ??
                [];
        return aliases.any((a) => docSpec.contains(a));
      }).toList();
    }

    if (query.isEmpty) {
      filteredDoctorsList = baseList;
    } else {
      final q = query.toLowerCase();
      filteredDoctorsList = baseList.where((doc) {
        return (doc.name ?? "").toLowerCase().contains(q) ||
            (doc.speciality ?? "").toLowerCase().contains(q) ||
            (doc.hospital ?? "").toLowerCase().contains(q);
      }).toList();
    }

    notifyListeners();
  }

  void filterBySpeciality(String speciality) {
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
    if (query.isEmpty) {
      // Agar search empty hai toh selected speciality ke basis pe dikhaao
      if (selectedSpeciality == "All") {
        filteredDoctorsList = allDoctorsList;
      } else {
        filterBySpeciality(selectedSpeciality);
        return;
      }
    } else {
      // Search query ko lowercase mein convert karo
      final q = query.toLowerCase();

      // Sabhi doctors mein search karo (speciality filter ko consider karte hue)
      List<DoctorModel> baseList;

      if (selectedSpeciality == "All") {
        baseList = allDoctorsList;
      } else {
        baseList = allDoctorsList.where((doctor) {
          final docSpec = doctor.speciality?.toLowerCase() ?? "";
          final aliases = specialityAliasMap[selectedSpeciality]?.map((e) => e.toLowerCase()) ?? [];
          return aliases.any((alias) => docSpec.contains(alias));
        }).toList();
      }

      // Name, speciality, aur hospital mein search karo
      filteredDoctorsList = baseList.where((doctor) {
        final name = (doctor.name ?? "").toLowerCase();
        final speciality = (doctor.speciality ?? "").toLowerCase();
        final hospital = (doctor.hospital ?? "").toLowerCase();

        return name.contains(q) || speciality.contains(q) || hospital.contains(q);
      }).toList();
    }

    notifyListeners();
  }

  DoctorModel? getDoctorById(int? doctorId) {
    try {
      return allDoctorsList.firstWhere(
            (doc) => doc.id == doctorId,
      );
    } catch (_) {
      return null;
    }
  }
}