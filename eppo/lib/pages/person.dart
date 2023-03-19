import 'dart:async';

import 'package:flutter/material.dart';

class PeopleWalkingOnLine extends StatefulWidget {
  final double percentage1;
  final double percentage2;

  const PeopleWalkingOnLine(
      {Key? key, required this.percentage1, required this.percentage2})
      : super(key: key);

  @override
  State<PeopleWalkingOnLine> createState() => _PeopleWalkingOnLineState();
}

class _PeopleWalkingOnLineState extends State<PeopleWalkingOnLine> {
  double percentage1 = 0;
  double percentage2 = 70;
  double percentage3 = 70;

  void _updatePercentages(double newPercentage1, double newPercentage2) {
    setState(() {
      if (newPercentage1 >= 60) {
        percentage1 = 0;
        percentage2 = newPercentage2 - 60;
        percentage3 = 70;
      } else {
        percentage1 = newPercentage1;
        percentage2 = newPercentage2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              color: Colors.grey,
            ),
          ),
          if (percentage1 > 0)
            Positioned(
              left: percentage1 / 100 * MediaQuery.of(context).size.width - 10,
              bottom: 50,
              child: Text(
                '1',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (percentage1 > 0)
            Positioned(
              left: percentage1 / 100 * MediaQuery.of(context).size.width,
              bottom: 0,
              child: Image.asset(
                'assets/man.png',
                height: 50,
              ),
            ),
          Positioned(
            left: percentage2 / 100 * MediaQuery.of(context).size.width - 10,
            bottom: 50,
            child: Text(
              '2',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            left: percentage2 / 100 * MediaQuery.of(context).size.width,
            bottom: 0,
            child: Image.asset(
              'assets/man.png',
              height: 50,
            ),
          ),
          if (percentage1 >= 60)
            Positioned(
              left: percentage3 / 100 * MediaQuery.of(context).size.width - 10,
              bottom: 50,
              child: Text(
                '3',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (percentage1 >= 60)
            Positioned(
              left: percentage3 / 100 * MediaQuery.of(context).size.width,
              bottom: 0,
              child: Image.asset(
                'assets/man.png',
                height: 50,
              ),
            ),
        ],
      ),
    );
  }
}
