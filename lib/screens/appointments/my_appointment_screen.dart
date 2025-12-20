import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'book_in_clinic_appointment.dart';

import 'book_video_consultation_screen.dart';

class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({super.key});

  @override
  State<MyAppointmentScreen> createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
            ),
            title: Text(
              "Appointment",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            backgroundColor: Colors.teal,
            bottom: TabBar(
              //dividerColor: Colors.white,
              unselectedLabelStyle: TextStyle(color: Colors.white60),
              labelColor: Colors.white,
              tabs: [
                Tab(text: "Book Video Consultation"),
                Tab(text: "Book In-clinic Appointment"),
              ],
            ),
          ),
          body: TabBarView(
            children: [BookVideoConsultation(), BookInclinicAppointment()],
          ),
        ),
      ),
    );
  }
}
