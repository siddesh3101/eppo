import 'package:booking_calendar/booking_calendar.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:eppo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../theme/style.dart';

class BookSlotPage extends StatefulWidget {
  const BookSlotPage({super.key});

  @override
  State<BookSlotPage> createState() => _BookSlotPageState();
}

class TimeSlot {
  final String time;
  final bool isBooked;

  TimeSlot(this.time, this.isBooked);

  static List<TimeSlot> slots = [
    TimeSlot('9:00', true),
    TimeSlot('9:30', false),
    TimeSlot('10:00', false),
    TimeSlot('10:30', false),
    TimeSlot('11:00', true),
    TimeSlot('11:30', true),
    TimeSlot('12:00', false),
    TimeSlot('12:30', false),
    TimeSlot('13:00', true),
    TimeSlot('13:30', false),
    TimeSlot('14:00', true),
  ];
}

class _BookSlotPageState extends State<BookSlotPage> {
  int _selectedIndex = -1;
  String _selectedOption = 'Mins';
  List<String> _options = ['Mins', 'Hours'];
  Widget notifyMe() {
    return AlertDialog(
      title: (const Center(child: Text("Notification Reminder"))),
      content: StatefulBuilder(
        builder: (context, dialogstate) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Enable Notification Reminder"),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Before"),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                      width: 50,
                      child: TextField(
                        keyboardType: TextInputType.phone,
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  DropdownButton(
                    value: _selectedOption,
                    onChanged: (newValue) {
                      dialogstate(
                        () {
                          _selectedOption = newValue!;
                        },
                      );
                    },
                    items: _options.map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                ],
              )
            ],
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {},
          child: Text("Ok"),
        )
      ],
    );
  }

  Widget sellerSelectDialog() {
    // var campusId = data["campusId"];

    return AlertDialog(
        title: (const Center(child: Text("Update Campus Settings"))),
        content: StatefulBuilder(
          builder: (context, dialogstate) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Book Slot'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CalendarTimeline(
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                onDateSelected: (date) {
                  // api call
                },
                activeBackgroundDayColor: MyColors.primaryColor,
                dayColor: MyColors.primaryColor,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: Center(
                    child: bookingLegend('Selected', MyColors.primaryColor,
                        MyColors.primaryColor),
                  )),
                  Expanded(
                      child: Center(
                    child: bookingLegend(
                        'Available', MyColors.white, MyColors.primaryColor),
                  )),
                  Expanded(
                      child: Center(
                    child:
                        bookingLegend('Booked', MyColors.gray2, MyColors.gray2),
                  )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.builder(
                  itemCount: TimeSlot.slots.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2.5),
                  itemBuilder: ((context, index) => GestureDetector(
                        onTap: () {
                          if (TimeSlot.slots[index].isBooked) return;
                          setState(() {
                            if (_selectedIndex == index)
                              _selectedIndex = -1;
                            else
                              _selectedIndex = index;
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1.5,
                                  color: TimeSlot.slots[index].isBooked
                                      ? MyColors.gray2
                                      : MyColors.primaryColor),
                              color: TimeSlot.slots[index].isBooked
                                  ? MyColors.gray2
                                  : index == _selectedIndex
                                      ? MyColors.primaryColor
                                      : MyColors.white,
                            ),
                            child: Center(
                              child: Text(
                                TimeSlot.slots[index].time,
                                style: TextStyle(
                                    color: (TimeSlot.slots[index].isBooked ||
                                            index == _selectedIndex)
                                        ? MyColors.white
                                        : MyColors.primaryColor),
                              ),
                            )),
                      ))),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text("Notify me before:"),
                trailing: Icon(Icons.edit),
                subtitle: Text(
                  "30 Minutes",
                  style: TextStyle(color: MyColors.primaryColor),
                ),
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => notifyMe(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _selectedIndex == -1
                  ? Container()
                  : Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              MyColors.primaryColor.withOpacity(0.8)),
                        ),
                        child: const Text('Book Slot',
                            style:
                                TextStyle(color: MyColors.white, fontSize: 16)),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }

  Row bookingLegend(String text, Color color, Color borderColor) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1.5, color: borderColor),
          color: color,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Text(text)
    ]);
  }
}
