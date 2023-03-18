import 'package:eppo/pages/virtual_queue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<Person> people = [
    Person(name: 'John', label: 'Customer'),
    Person(name: 'Jane', label: 'VIP'),
    Person(name: 'Bob', label: 'Regular'),
  ];

  @override
  Widget build(BuildContext context) {
    QueueScreen virtualQueue = QueueScreen(people: people);
    return Scaffold(
      body: virtualQueue,
    );
  }
}
