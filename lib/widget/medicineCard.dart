import 'package:flutter/material.dart';
import 'package:lifeline_healthcare/screen/theme/color.dart';
import 'package:lifeline_healthcare/screen/theme/text_styles.dart';

class MedicineCard extends StatelessWidget {
  final Image image;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const MedicineCard({super.key, required this.image, required this.icon, required this.title, required this.subtitle, required this.onTap});


  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[200] : Colors.grey[900],
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4 ,
              offset: Offset(0, 3)
            )
          ]
        ),
        child: Stack(
         children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image(
                    image: image.image,
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))
                ),
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:AppTextStyle.titleMedium.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      Text(
                        subtitle,
                        style:AppTextStyle.titleMedium.copyWith(
                            color: AppColors.colorText,
                            fontWeight: FontWeight.w600
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
           Positioned(
             top: 8,
             left:120,
             child: Container(
               height: 38,
               width: 38,
               alignment: Alignment.center,
               decoration: BoxDecoration(shape: BoxShape.circle,color: isDark?Colors.white:Color(0xFFDDDDDD)),
               child: Icon(
                 icon,
                 size:22,
                 color: isDark ? Colors.black87 : Colors.white,
               ),
             ),
           ),
          ],
        ),

      ),
    );
  }
}
