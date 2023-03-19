import 'dart:async';
import 'dart:math';

import 'package:eppo/services/api_service.dart';
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
  double percentage1 = 10;
  double percentage2 = 70;
  double percentage3 = 0;
  String waitingTime = "";
  int estimatedTime = 0;
  Timer? _timer;
  int label = 1;
  void callApis() async {
    var getting = await ApiService().getQueueDetails();
    setState(() {
      waitingTime = getting["duration"];
      estimatedTime = getting["waitingtime"];
    });
  }

  @override
  void initState() {
    super.initState();
    callApis();
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        percentage1 += 1;
        if (percentage1 >= 100) {
          callApis();
          _timer = null;
          label += 1;
          percentage1 = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updatePercentages(double newPercentage1, double newPercentage2) {
    setState(() {
      if (percentage1 >= 100) {
        percentage1 = 0;
        percentage2 = newPercentage2;
        _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
          setState(() {
            percentage3 += 1;
            if (percentage3 >= 100) {
              _timer?.cancel();
              _timer = null;
            }
          });
        });
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
          Positioned(
              left: percentage1 / 100 * MediaQuery.of(context).size.width - 10,
              bottom: 52,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10)),
                width: 150,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/location.png",
                            width: 20,
                          ),
                          Text("-------------------------"),
                          Image.asset(
                            "assets/location.png",
                            width: 20,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Estimated\nReach Time:",
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                waitingTime,
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Estimated\nWaiting Time:",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.end,
                              ),
                              Text(
                                "${estimatedTime} mins",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "${label}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )),
          Positioned(
            left: percentage1 / 100 * MediaQuery.of(context).size.width,
            bottom: 0,
            child: Image.asset(
              'assets/man.png',
              height: 50,
            ),
          ),
          // Positioned(
          //   left: percentage2 / 100 * MediaQuery.of(context).size.width - 10,
          //   bottom: 50,
          //   child: Text(
          //     '2',
          //     style: TextStyle(
          //       fontSize: 16,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          // Positioned(
          //   left: percentage2 / 100 * MediaQuery.of(context).size.width,
          //   bottom: 0,
          //   child: Image.asset(
          //     'assets/man.png',
          //     height: 50,
          //   ),
          // ),
        ],
      ),
    );
  }
}
