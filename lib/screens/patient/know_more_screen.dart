import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KnowMoreScreen extends StatefulWidget {
  const KnowMoreScreen({super.key});

  @override
  State<KnowMoreScreen> createState() => _KnowMoreScreenState();
}

class _KnowMoreScreenState extends State<KnowMoreScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 80,
          color: Colors.teal,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 10,
              bottom: 10,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.white,
              ),
              onPressed: () {},
              child: Text(
                "Go it",
                style: TextStyle(fontSize: 20, color: Colors.teal),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          leading: Icon(Icons.arrow_back, color: Colors.white),
          backgroundColor: Colors.teal,
          title: Text(
            "When to use follow-up",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: [
            Card(
              margin: EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300],
                  child: Icon(Icons.shutter_speed_outlined, color: Colors.teal,size: 35,),
                ),
                title: Text(
                  "Ask substitutes of prescribe  medication",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "In case the prescribe medicines are not avilable",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),

            Card(
              margin: EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300],
                  child: Icon(Icons.question_mark_rounded, color: Colors.teal,size: 33,),
                ),
                title: Text(
                  "Ask clarifications",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Around prescription dosage,effectivenss of treatment or lifestyle changes",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),

            Card(
              margin: EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300],
                  child: Icon(Icons.emoji_emotions_outlined, color: Colors.teal,size: 33,),
                ),
                title: Text(
                  "No improvement in condition",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "If your medical condition hasn’t improved even after following prescribed treatment",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300],
                  child: Icon(Icons.description, color: Colors.teal,size: 33,),
                ),
                title: Text(
                  "Show tests and reports",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "If there are tests are reports to be shown",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "When not to use follow -up",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),

            Card(
              margin: EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300],
                  child: Icon(Icons.do_not_disturb_on_total_silence, color: Colors.teal,size: 33,),
                ),
                title: Text(
                  "Do not consult for a different problem",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Only ask question relating to the health concern the primary consultation was form",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),

            Card(
              margin: EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300],
                  child: Icon(Icons.family_restroom_sharp, color: Colors.teal,size: 30,),
                ),
                title: Text(
                  "Do not consult for another family member",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Continue followup for the same patient that the primary consultation was done for",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "Please note that follow-up is not for emargency case go to your nearby hospital in case of an emergency",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
