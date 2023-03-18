import 'package:booking_calendar/booking_calendar.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:eppo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
    TimeSlot('9:00 - 9:30', true),
    TimeSlot('9:30 - 10:00', false),
    TimeSlot('10:00 - 10:30', false),
    TimeSlot('10:30 - 11:00', false),
    TimeSlot('11:00 - 11:30', true),
    TimeSlot('11:30 - 12:00', true),
    TimeSlot('12:00 - 12:30', false),
    TimeSlot('12:30 - 13:00', false),
    TimeSlot('13:00 - 13:30', true),
    TimeSlot('13:30 - 14:00', false),
    TimeSlot('14:00 - 14:30', true),
  ];
}

class _BookSlotPageState extends State<BookSlotPage> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Book Slot'),
          backgroundColor: MyColors.primaryColor,
          centerTitle: true,
          titleTextStyle: TextStyle(color: MyColors.white, fontSize: 18),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
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
              Expanded(
                child: GridView.builder(
                    itemCount: TimeSlot.slots.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
