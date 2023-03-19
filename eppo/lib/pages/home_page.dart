import 'package:carousel_slider/carousel_slider.dart';
import 'package:eppo/pages/doctor_screen.dart';
import 'package:eppo/pages/dr_screen.dart';
import 'package:eppo/pages/sliver_detail.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../screens/review_screen.dart';
import '../theme/colors.dart';
import '../theme/style.dart';

List<Map> doctors = [
  {
    'img': 'assets/salooon.jpg',
    'doctorName': 'Stylo Saloon',
    'doctorTitle': 'Saloon'
  },
  {
    'img': 'assets/lawyer.jpeg',
    'doctorName': 'Rk Gupta',
    'doctorTitle': 'Lawyer'
  },
  {
    'img': 'assets/councl.jpeg',
    'doctorName': 'Himani Deshpande',
    'doctorTitle': 'Counselor'
  },
  {
    'img': 'assets/Masuda_Khan.png',
    'doctorName': 'Dr. Masuda Khan',
    'doctorTitle': 'Skin Specialist'
  }
];

class HomeTab extends StatelessWidget {
  final void Function() onPressedScheduleCard;
  final List<Doctor>? user;

  const HomeTab({
    Key? key,
    required this.onPressedScheduleCard,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController edit = TextEditingController();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            UserIntro(),
            SizedBox(
              height: 10,
            ),
            SearchInput(
              hint: "Search for a service",
              onTap: () {},
              text: edit,
            ),
            SizedBox(
              height: 20,
            ),
            CarouselSlider(
              items: [
                Container(
                    alignment: Alignment.bottomLeft,
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://content.jdmagicbox.com/comp/mumbai/t4/022pxx22.xx22.110613193004.k2t4/catalogue/lakme-salon-shivaji-park-dadar-west-mumbai-salons-04QFWyLWYJosuDy.jpg?clr=006600"))),
                    child: Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            blurRadius: 10.0,
                            color: Colors.black.withOpacity(0.4))
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Lakme Saloon",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Mumbai Maharashtra",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Appointment booking opening soon",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    )),
                Container(
                    alignment: Alignment.bottomLeft,
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://content.jdmagicbox.com/comp/mumbai/t7/022pxx22.xx22.160728204731.u3t7/catalogue/santosh-kumar-singh-fort-mumbai-lawyers-2iht6bd.jpg?clr="))),
                    child: Container(
                      width: double.infinity,
                      height: 90,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            blurRadius: 10.0,
                            color: Colors.black.withOpacity(0.4))
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "RK Lawyer",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Borivali Maharashtra",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Slots open between 1-2 pm from Mon-Fri",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    )),
              ],
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CategoryIcons(user: user),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Appointment Today',
                  style: kTitleStyle,
                ),
                TextButton(
                  child: Text(
                    'See All',
                    style: TextStyle(
                      color: Color(MyColors.yellow01),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {},
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            AppointmentCard(
              onTap: onPressedScheduleCard,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Trending Businesses',
              style: TextStyle(
                color: Color(MyColors.header01),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            for (var doctor in doctors)
              TopDoctorCard(
                img: doctor['img'],
                doctorName: doctor['doctorName'],
                doctorTitle: doctor['doctorTitle'],
                id: doctor['id'],
                ontap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: SliverDoctorDetail(details: doctor, decide: true),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}

class TopDoctorCard extends StatelessWidget {
  String img;
  String doctorName;
  String id;
  String doctorTitle;
  VoidCallback ontap;

  TopDoctorCard(
      {required this.img,
      required this.doctorName,
      required this.doctorTitle,
      required this.id,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: ontap,
        child: Row(
          children: [
            Container(
              color: Color(MyColors.grey01),
              child: Image(
                width: 100,
                image: AssetImage(img),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: TextStyle(
                    color: Color(MyColors.header01),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  doctorTitle,
                  style: TextStyle(
                    color: Color(MyColors.grey02),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Color(MyColors.yellow02),
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '4.0 - 50 Reviews',
                      style: TextStyle(color: Color(MyColors.grey02)),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final void Function() onTap;

  const AppointmentCard({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                              'Saloon',
                              style: TextStyle(color: Color(MyColors.text01)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ScheduleCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Color(MyColors.bg02),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Color(MyColors.bg03),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

List<Map> categories = [
  {'icon': "assets/doctor.png", 'text': 'Doctor'},
  {'icon': "assets/haircut.png", 'text': 'Salon'},
  {'icon': "assets/justice.png", 'text': 'Lawyer'},
  {'icon': "assets/communication.png", 'text': 'Counselor'},
];

class CategoryIcons extends StatelessWidget {
  const CategoryIcons({
    Key? key,
    this.user,
  }) : super(key: key);
  final List<Doctor>? user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var category in categories)
          CategoryIcon(
            image: category['icon'],
            text: category['text'],
            user: user,
            decide: true,
          ),
      ],
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.calendar_today,
            color: Colors.black,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Mon, Mar 19',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.access_alarm,
            color: Colors.black,
            size: 17,
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(
              '13:00 ~ 13:30',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  String image;
  String text;

  CategoryIcon({
    required this.image,
    required this.text,
    this.user,
    this.decide,
  });
  final List<Doctor>? user;
  final bool? decide;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Color(MyColors.bg01),
      onTap: decide!
          ? () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DoctorScreen(user: user),
              ));
            }
          : () {},
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color(MyColors.bg),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Image.asset(
                image,
                color: Color(MyColors.primary),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(
                color: Color(MyColors.primary),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({
    Key? key,
    required this.hint,
    required this.onTap,
    required this.text,
    this.color = 0xfff5f3fe,
  }) : super(key: key);
  final String hint;
  final VoidCallback onTap;
  final TextEditingController text;
  final int? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(color!),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Icon(
              Icons.search,
              color: Color(MyColors.purple02),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              onTap: onTap,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(
                    fontSize: 13,
                    color: Color(MyColors.purple01),
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
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
        Row(children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/professional');
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xffF5F3FE),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Icon(
                Icons.notifications,
                color: Color(MyColors.primary),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://instagram.fbom61-1.fna.fbcdn.net/v/t51.2885-19/297723103_131991389535733_3394524039300739566_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fbom61-1.fna.fbcdn.net&_nc_cat=101&_nc_ohc=IO02ekRDY9oAX_6JkOo&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfCuMcGpvHriOC-t0GrTqybTK955SQZ30LnIa6z7N-AB_A&oe=64191CB9&_nc_sid=8fd12b'),
          ),
        ])
      ],
    );
  }
}
