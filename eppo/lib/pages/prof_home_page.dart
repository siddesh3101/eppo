import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:eppo/pages/chat_page.dart';
import 'package:eppo/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:tap_to_expand/tap_to_expand.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/colors.dart';

List<Map> doctors = [
  {
    'img': 'assets/saloon.png',
    'doctorName': 'Stylo Saloon',
    'doctorTitle': 'Saloon'
  },
  {
    'img': 'assets/doctor03.jpeg',
    'doctorName': 'Dr. Rosa Williamson',
    'doctorTitle': 'Skin Specialist'
  },
  {
    'img': 'assets/doctor02.png',
    'doctorName': 'Dr. Gardner Pearson',
    'doctorTitle': 'Heart Specialist'
  },
  {
    'img': 'assets/doctor03.jpeg',
    'doctorName': 'Dr. Rosa Williamson',
    'doctorTitle': 'Skin Specialist'
  }
];

enum FilterStatus { Physical, Virtual }

class ProfTab extends StatefulWidget {
  final void Function() onPressedScheduleCard;

  const ProfTab({
    Key? key,
    required this.onPressedScheduleCard,
  }) : super(key: key);

  @override
  State<ProfTab> createState() => _ProfTabState();
}

class _ProfTabState extends State<ProfTab> {
  FilterStatus status = FilterStatus.Physical;
  Alignment _alignment = Alignment.centerLeft;
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          UserIntro(),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Appointments Today',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              TextButton(
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: Color(0xFF007AFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {},
              )
            ],
          ),
          Stack(
            children: [
              Container(
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
                              if (filterStatus == FilterStatus.Physical) {
                                status = FilterStatus.Physical;
                                _alignment = Alignment.centerLeft;
                                _currentIndex = 0;
                              } else {
                                status = FilterStatus.Virtual;
                                _alignment = Alignment.centerRight;
                                _currentIndex = 1;
                              }
                            });
                          },
                          child: Center(
                            child: Text(
                              filterStatus.name,
                              // style: kFilterStyle,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment: _alignment,
                child: Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF007AFF),
                    borderRadius: BorderRadius.circular(10),
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
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                TodaysAppointments(),
                TodaysAppointments(),
              ],
              onPageChanged: (idx) {
                setState(() {
                  _currentIndex = idx;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

class TodaysAppointments extends StatelessWidget {
  const TodaysAppointments({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) =>
          AppointmentCardProfessional(onTap: () {}),
    );
  }
}

class AppointmentCardProfessional extends StatelessWidget {
  final void Function() onTap;

  const AppointmentCardProfessional({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(MyColors.primary),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/saloon.png'),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Stylo Saloon',
                              style: TextStyle(color: Colors.white)),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Salon',
                            style: TextStyle(color: Color(MyColors.text01)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(MyColors.yellow01),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Mon, July 29',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.access_alarm,
                          color: Colors.white,
                          size: 17,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(
                            '11:00 ~ 12:10',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  userId: '6415da02cc26535ffc32da5c',
                                  otherId: '64157b99303ac48fb69cd12e',
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Chat',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(MyColors.bg)),
                          )),
                      ElevatedButton(
                        onPressed: _launchUrl,
                        child: Text(
                          'Video Call',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(MyColors.bg)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse("https://virtual-appointment.glitch.me"))) {
      throw Exception('Could not launch url');
    }
  }
}

class UserIntro extends StatelessWidget {
  const UserIntro({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Hello',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              'Siddesh Shetty 👋',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        const CircleAvatar(
          backgroundImage: NetworkImage(
              'https://instagram.fbom61-1.fna.fbcdn.net/v/t51.2885-19/297723103_131991389535733_3394524039300739566_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fbom61-1.fna.fbcdn.net&_nc_cat=101&_nc_ohc=IO02ekRDY9oAX_6JkOo&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfCuMcGpvHriOC-t0GrTqybTK955SQZ30LnIa6z7N-AB_A&oe=64191CB9&_nc_sid=8fd12b'),
        )
      ],
    );
  }
}
