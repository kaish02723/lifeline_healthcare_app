import 'package:flutter/material.dart';
import 'package:lifeline_healthcare/screen/theme/color.dart';
import 'package:lifeline_healthcare/screen/theme/text_styles.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: height * 0.30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: Image.asset(
                        "asset/images/img_3.png",
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: -50,
                    left: width / 2 - 50,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("asset/images/img_3.png"),
                    ),
                  ),
                  Positioned(
                      bottom: -45,
                      right: width / 2 - 45,
                      child:CircleAvatar(
                    radius: 15,
                   backgroundColor: AppColors.white,
                   child: Icon(Icons.mode_edit_sharp,color: AppColors.colorText,),
                  ),
                  )
                ],
              ),

              SizedBox(height: 60),//my card
              Container(
                width: width,
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Edit Your Profile",
                      style: AppTextStyle.titleLarge,
                    ),

                    SizedBox(height: 25),

                    inputBox("MD Kaish", Icons.person),
                    SizedBox(height: 15),

                    inputBox("Male", Icons.male),
                    SizedBox(height: 15),

                    inputBox("01/01/2004", Icons.date_range),
                    SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                        child: Text("Save", style: AppTextStyle.h2.copyWith(
                          color: AppColors.white,
                        )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget inputBox(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.secondaryDark,size: 30,),
          SizedBox(width: 12),
          Text(text, style: AppTextStyle.titleLarge.copyWith(
            color: AppColors.greyText,
            fontWeight: FontWeight.w300
          )),
        ],
      ),
    );
  }
}
