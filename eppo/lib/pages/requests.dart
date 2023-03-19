import 'package:eppo/pages/schedule.dart';
import 'package:eppo/services/appointment_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../theme/colors.dart';
import '../theme/style.dart';

class PendingAppointments extends StatefulWidget {
  const PendingAppointments({super.key});

  @override
  State<PendingAppointments> createState() => _PendingAppointmentsState();
}

class _PendingAppointmentsState extends State<PendingAppointments> {
  FilterStatus status = FilterStatus.Upcoming;
  Alignment _alignment = Alignment.centerLeft;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(MyColors.bg),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (FilterStatus filterStatus in FilterStatus.values)
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (filterStatus == FilterStatus.Upcoming) {
                                    status = FilterStatus.Upcoming;
                                    _alignment = Alignment.centerLeft;
                                  } else if (filterStatus ==
                                      FilterStatus.Complete) {
                                    status = FilterStatus.Complete;
                                    _alignment = Alignment.center;
                                  } else if (filterStatus ==
                                      FilterStatus.Cancel) {
                                    status = FilterStatus.Cancel;
                                    _alignment = Alignment.centerRight;
                                  }
                                });
                              },
                              child: Center(
                                child: Text(
                                  filterStatus.name,
                                  style: kFilterStyle,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedAlign(
                    duration: Duration(milliseconds: 200),
                    alignment: _alignment,
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(MyColors.primary),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          status.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: FutureBuilder<Map<dynamic, dynamic>>(
                future: AppointmentService().getPendingAppointments(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!["data"].length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/Asma_Khan.png"),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${snapshot.data!["userInfo"][index]["firstname"]} ${snapshot.data!["userInfo"][index]["lastname"]}",
                                              style: TextStyle(
                                                color: Color(MyColors.header01),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${snapshot.data!["userInfo"][index]["email"]}",
                                              style: TextStyle(
                                                color: Color(MyColors.grey02),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    DateTimeCard(),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                            child: Text('Cancel'),
                                            onPressed: () {},
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                textStyle: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            child: Text('Accept'),
                                            onPressed: () async {
                                              var accepting =
                                                  await AppointmentService()
                                                      .updateAppointment(
                                                          snapshot.data!["data"]
                                                              [index]["_id"]);
                                              setState(() {});
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                    case ConnectionState.none:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    // TODO: Handle this case.

                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    // TODO: Handle this case.

                    case ConnectionState.active:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    // TODO: Handle this case.
                  }

                  // return Text(
                  //   '${}',
                  //   style: TextStyle(
                  //       color: Colors.white),
                  // );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
