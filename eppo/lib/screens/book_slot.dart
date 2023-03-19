import 'package:booking_calendar/booking_calendar.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:eppo/constants/colors.dart';
import 'package:eppo/models/get_slots_response.dart';
import 'package:eppo/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';

import '../theme/style.dart';

class BookArguments {
  final String id;

  BookArguments(this.id);
}

class BookSlotPage extends StatefulWidget {
  BookSlotPage({super.key});
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MTU3Yjk5MzAzYWM0OGZiNjljZDEyZSIsImlhdCI6MTY3OTE3NjYzMiwiZXhwIjoxNjc5MjYzMDMyfQ._PwHChUhLHZzUWEfTPQ-ovut0p44W7J0OqGcTM8GX34";
  String otherId = "";

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
  late ApiService _apiService;
  int _selectedIndex = -1;
  Datum? _selectedSlot = null;
  String _selectedOption = 'Mins';
  List<String> _options = ['Mins', 'Hours'];
  late Future<GetSlotResponse> _future;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiService = ApiService();
    // fetchSlotsByDate(DateTime.now());
  }

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
    final args = ModalRoute.of(context)!.settings.arguments as BookArguments;
    widget.otherId = args.id;
    fetchSlotsByDate(DateTime.now());
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
                initialDate: _selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                onDateSelected: (date) {
                  print('Selected date: $date');
                  _selectedDate = date;
                  fetchSlotsByDate(date);
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
                child: FutureBuilder<GetSlotResponse>(
                    future: _future,
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? GridView.builder(
                              itemCount: snapshot.data!.data.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 2.5),
                              itemBuilder: ((context, index) => GestureDetector(
                                    onTap: () {
                                      if (snapshot!.data!.data[index].isBooked)
                                        return;
                                      setState(() {
                                        if (_selectedIndex == index) {
                                          _selectedIndex = -1;
                                          _selectedSlot = null;
                                        } else {
                                          _selectedIndex = index;
                                          _selectedSlot =
                                              snapshot.data!.data[index];
                                        }
                                      });
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1.5,
                                              color: snapshot!.data!.data[index]
                                                      .isBooked
                                                  ? MyColors.gray2
                                                  : MyColors.primaryColor),
                                          color: snapshot!
                                                  .data!.data[index].isBooked
                                              ? MyColors.gray2
                                              : index == _selectedIndex
                                                  ? MyColors.primaryColor
                                                  : MyColors.white,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${snapshot.data!.data[index].start} - ${snapshot.data!.data[index].end}',
                                            style: TextStyle(
                                                color: (snapshot!
                                                            .data!
                                                            .data[index]
                                                            .isBooked ||
                                                        index == _selectedIndex)
                                                    ? MyColors.white
                                                    : MyColors.primaryColor),
                                          ),
                                        )),
                                  )))
                          : Container();
                    }),
              ),
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
                        onPressed: () async {
                          final res =
                              await _apiService.getOrder(widget.otherId);
                          Razorpay _razorPay = Razorpay();
                          var options = {
                            'key': 'rzp_test_NTCtiBhSzJJA1c',
                            'amount': res.amount * 100,
                            'name': 'TimeTap Ltd.',
                            'description': 'Appointment Booking',
                            'retry': {'enabled': true, 'max_count': 1},
                            'send_sms_hash': true,
                            'prefill': {
                              'contact': '8888888888',
                              'email': 'test@razorpay.com'
                            },
                            'external': {
                              'wallets': ['paytm']
                            }
                          };
                          _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR,
                              handlePaymentErrorResponse);
                          _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                              handlePaymentSuccessResponse);
                          _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                              handleExternalWalletSelected);
                          _razorPay.open(options);
                        },
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

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    final res = await _apiService.bookSlot(
        widget.token,
        widget.otherId,
        DateFormat('dd-MM-yyyy').format(DateTime.now()),
        [_selectedSlot!.start, _selectedSlot!.end]);
    // ignore: use_build_context_synchronously
    if (res) {
      showAlertDialog(context, "Payment Successful. Booking is completed..",
          "Payment ID: ${response.paymentId}", onOk: () {
        Navigator.pushNamed(context, '/');
      });
    }
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message,
      {Function? onOk}) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        onOk?.call();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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

  void fetchSlotsByDate(DateTime dateTime) async {
    setState(() {
      _future = _apiService.getSlotsByProfId(widget.otherId, widget.token,
          DateFormat('dd-MM-yyyy').format(dateTime));
    });
  }
}
