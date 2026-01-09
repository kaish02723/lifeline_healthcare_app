import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/doctor_provider/doctor_provider.dart';
import '../../screens/doctor/doctor_find_consult_screen.dart';
import '../../screens/doctor/find_doctor_screen.dart';

class HealthCategoryItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color? backgroundColor;
  final Color? borderColor;

  const HealthCategoryItem({
    super.key,
    required this.title,
    required this.imagePath,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.17; // responsive
    Color bgColor =
        backgroundColor ??
        (Theme.of(context).brightness == Brightness.light
            ? Colors.white.withOpacity(0.75)
            : Colors.white.withOpacity(0.1));
    Color bColor =
        borderColor ??
        (Theme.of(context).brightness == Brightness.light
            ? Colors.grey.shade300
            : Colors.grey.shade700);

    return GestureDetector(
      onTap: () {

        final provider =
        Provider.of<DoctorProvider>(context, listen: false);

        final speciality =
            categoryToSpeciality[title] ?? "All";

        provider.filterBySpeciality(speciality);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FindDoctor()),
        );
      },
      child: Column(
        children: [
          Container(
            width: size,
            height: size,
            padding: EdgeInsets.all(size * 0.15),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: bColor, width: 0.8),
              boxShadow: [
                BoxShadow(
                  color:
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.black.withOpacity(0.05)
                          : Colors.black.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: CachedNetworkImage(imageUrl: imagePath, fit: BoxFit.contain),
          ),
          SizedBox(height: size * 0.08),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Sample list remains same
final List<Map<String, String>> healthCategories = [
  {
    'title': 'Skin & Hair',
    'image': 'https://cdn-icons-png.flaticon.com/512/4615/4615577.png',
  },
  {
    'title': 'Heart',
    'image': 'https://cdn-icons-png.flaticon.com/512/3843/3843010.png',
  },
  {
    'title': 'Dental',
    'image':
        'https://img.pikbest.com/png-images/20241204/minimalist-tooth-logo-design-for-dental-clinics_11170365.png!sw800',
  },
  {
    'title': 'Eye Care',
    'image': 'https://cdn-icons-png.flaticon.com/512/2824/2824810.png',
  },
  {
    'title': 'ENT',
    'image': 'https://cdn-icons-png.flaticon.com/512/3974/3974908.png',
  },
  {
    'title': 'Bone & Joint',
    'image': 'https://cdn-icons-png.flaticon.com/512/10368/10368848.png',
  },
  {
    'title': 'Diabetes',
    'image': 'https://cdn-icons-png.flaticon.com/512/4349/4349215.png',
  },
  {
    'title': 'Kidney',
    'image': 'https://cdn-icons-png.flaticon.com/512/2044/2044562.png',
  },
];

final Map<String, String> categoryToSpeciality = {
  "Skin & Hair": "Dermatology",
  "Heart": "Cardiology",
  "Dental": "Dental",
  "Eye Care": "Ophthalmology",
  "ENT": "ENT",
  "Bone & Joint": "Orthopaedics",
  "Diabetes": "Endocrinology",
  "Kidney": "Nephrology",
};

String mapCategoryToSpeciality(String title) {
  switch (title) {
    case 'Skin & Hair':
      return 'Dermatology';
    case 'Heart':
      return 'Cardiology';
    case 'Dental':
      return 'Dental';
    case 'Eye Care':
      return 'Ophthalmology';
    case 'ENT':
      return 'ENT';
    case 'Bone & Joint':
      return 'Orthopaedics';
    case 'Diabetes':
      return 'Endocrinology';
    case 'Kidney':
      return 'Nephrology';
    default:
      return 'All';
  }
}
