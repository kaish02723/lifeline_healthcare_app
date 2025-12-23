import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifeline_healthcare_app/providers/user_detail/get_userdetail_provider.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? imageFile;

  Future pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GetUserDetailProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Edit Profile"),
        elevation: 1,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------ PROFILE IMAGE ------------------
            Center(
              child: GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage:
                      imageFile != null ? FileImage(imageFile!) : null,
                  child:
                      imageFile == null
                          ? Icon(
                            Icons.camera_alt,
                            size: 32,
                            color: Colors.black54,
                          )
                          : null,
                ),
              ),
            ),

            SizedBox(height: 30),

            // ------------------ NAME ------------------
            TextField(
              controller: provider.updateNameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            // ------------------ EMAIL ------------------
            TextField(
              controller: provider.updateEmailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            // ------------------ GENDER ------------------
            DropdownButtonFormField<String>(
              value: provider.updateGender,
              decoration: InputDecoration(
                labelText: "Gender",
                border: OutlineInputBorder(),
              ),
              items:
                  ["Male", "Female", "Other"]
                      .map((g) => DropdownMenuItem(child: Text(g), value: g))
                      .toList(),
              onChanged: (value) {
                setState(() {
                  provider.updateGender = value;
                });
              },
            ),

            SizedBox(height: 15),

            // ------------------ DOB ------------------
            TextField(
              controller: provider.updateDobController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Date of Birth",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_month),
              ),
              onTap: () {
                provider.selectDate(context);
              },
            ),

            SizedBox(height: 15),

            // ------------------ ADDRESS ------------------
            TextField(
              controller: provider.updateAddressController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 25),

            // ------------------ SAVE BUTTON ------------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                onPressed: () async {
                  String? imageUrl;

                  if (imageFile != null) {
                    imageUrl =
                    await provider.uploadProfileImage(imageFile!, context);
                  }

                  Map<String, dynamic> data = {
                    "name": provider.updateNameController.text,
                    "email": provider.updateEmailController.text,
                    "gender": provider.updateGender,
                    "date_of_birth": provider.updateDobController.text,
                    "address": provider.updateAddressController.text,
                  };

                  if (imageUrl != null && imageUrl.isNotEmpty) {
                    data["picture"] = imageUrl;
                  }

                  provider.updateUserProfile(context, data);
                },

                child: Text("SAVE CHANGES"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
