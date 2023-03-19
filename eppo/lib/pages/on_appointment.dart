import 'package:eppo/pages/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class OnAppointment extends StatefulWidget {
  const OnAppointment({super.key});

  @override
  State<OnAppointment> createState() => _OnAppointmentState();
}

class _OnAppointmentState extends State<OnAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Live Appointment Queue",
            style: TextStyle(color: Colors.black),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
          ),
          SizedBox(
              width: double.infinity,
              height: 200,
              child: PeopleWalkingOnLine(
                percentage1: 10,
                percentage2: 60,
              ))
        ],
      ),
    );
  }
}
