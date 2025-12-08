import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'book_in-clinic_appointment.dart';
import 'book_video_consultation.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.arrow_back_rounded, color: Colors.white),
            title: Text(
              "Appointment",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            backgroundColor: Colors.teal,
            bottom: TabBar(
              //dividerColor: Colors.white,
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
