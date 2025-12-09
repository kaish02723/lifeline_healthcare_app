import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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

    return Column(
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
                color: Theme.of(context).brightness == Brightness.light
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
        SizedBox(
          width: size + 20,
          child: Text(
            title,
            style: TextStyle(
              fontSize: size * 0.25,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
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
