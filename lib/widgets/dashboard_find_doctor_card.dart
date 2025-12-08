import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HealthCategoryItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color backgroundColor;
  final Color borderColor;

  const HealthCategoryItem({
    super.key,
    required this.title,
    required this.imagePath,
    required this.backgroundColor ,
    this.borderColor = const Color(0xffd1d1d1),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: borderColor, width: 0.5),
          ),
          child: CachedNetworkImage(imageUrl: imagePath,fit: BoxFit.contain,),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

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
