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
    this.backgroundColor = const Color(0xffF5F7FA),
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
            border: Border.all(
              color: borderColor,
              width: 0.5,
            ),
          ),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
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
    'image': 'https://static.vecteezy.com/system/resources/thumbnails/039/855/432/small/ai-generated-business-woman-portrait-png.png',
  },
  {
    'title': 'Heart',
    'image': 'assets/icons/heart.png',
  },
  {
    'title': 'Dental',
    'image': 'assets/icons/dental.png',
  },
  {
    'title': 'Eye Care',
    'image': 'assets/icons/eye.png',
  },
  {
    'title': 'ENT',
    'image': 'assets/icons/ent.png',
  },
  {
    'title': 'Bone & Joint',
    'image': 'assets/icons/bone.png',
  },
  {
    'title': 'Diabetes',
    'image': 'assets/icons/diabetes.png',
  },
  {
    'title': 'Kidney',
    'image': 'assets/icons/kidney.png',
  },
];

