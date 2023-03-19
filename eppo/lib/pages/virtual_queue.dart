import 'dart:async';
import 'package:flutter/material.dart';

class Person {
  String name;
  String label;

  Person({required this.name, required this.label});
}

class QueueScreen extends StatefulWidget {
  final List<Person> people;

  QueueScreen({required this.people});

  @override
  _QueueScreenState createState() => _QueueScreenState();
}

class _QueueScreenState extends State<QueueScreen> {
  List<Person> _peopleInLine = [];

  @override
  void initState() {
    super.initState();

    // Add all people to the virtual queue
    _peopleInLine = List.from(widget.people);

    // Start a timer that moves people in line every second
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        // Move the first person in line to the end of the queue
        _peopleInLine.add(_peopleInLine.removeAt(0));
      });
    });

    // Start a timer that removes people after 10 seconds
    Timer.periodic(Duration(seconds: 10), (timer) {
      if (_peopleInLine.isNotEmpty) {
        setState(() {
          // Remove the first person in line
          _peopleInLine.removeAt(0);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Virtual Queue'),
      ),
      body: ListView.builder(
        itemCount: _peopleInLine.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_peopleInLine[index].name),
            subtitle: Text(_peopleInLine[index].label),
          );
        },
      ),
    );
  }
}
