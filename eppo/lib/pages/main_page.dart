import 'dart:convert';

import 'package:eppo/constants/colors.dart';
import 'package:eppo/pages/home_page.dart';
import 'package:eppo/pages/on_appointment.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:eppo/pages/profile_screen.dart';
import 'package:eppo/pages/schedule.dart';
import 'package:eppo/services/api_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../firebase_notification_provider.dart';

import 'dr_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final String doctorsJson = '''
  {
    "doctors": [
      {
        "name": "Dr. Masuda Khan",
        "speciality": "Cardiology",
        "location": "New York",
        "rating": 4.8,
        "image": "assets/Masuda_Khan.png",
        "id": "64157b99303ac48fb69cd12e"
      },
      {
        "name": "Dr. Salina Zaman",
        "speciality": "Cardiology",
        "location": "Los Angeles",
        "rating": 4.5,
        "image": "assets/Salina_Zaman.png",
        "id": "6415da02cc26535ffc32da5c"
      },
      {
        "name": "Dr. Johir Raihan",
        "speciality": "Cardiologist",
        "location": "Chicago",
        "rating": 4.9,
        "image": "assets/Johir_Raihan.png",
        "id": "64157b99303ac48fb69cd12e"
      },
      {
        "name": "Dr. Kiran Shakia",
        "speciality": "Dermatology",
        "location": "Houston",
        "rating": 4.3,
        "image": "assets/kiran.png",
        "id": "6415da02cc26535ffc32da5c"
      },
      {
        "name": "Dr. Serena Gome",
        "speciality": "Neurology",
        "location": "San Francisco",
        "rating": 4.7,
        "image": "assets/Serena_Gome.png",
        "id": "64157b99303ac48fb69cd12e"
      }
    ]
  }
  ''';
  // current index state
  int _currentIndex = 0;

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    initMessaging();
    _currentIndex = 0;
    // NotificationListenerProvider().getMessage(context);

    initMessaging();
    sendPushToken();
  }

  void initMessaging() {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    FlutterLocalNotificationsPlugin fltNotification =
        FlutterLocalNotificationsPlugin();
    var androiInit = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInit = const DarwinInitializationSettings();
    var initSetting = InitializationSettings(android: androiInit);

    fltNotification.initialize(initSetting);
    var androidDetails =
        const AndroidNotificationDetails("default", "channel name");
    var iosDetails = const DarwinNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        fltNotification.show(notification.hashCode, notification.title,
            notification.body, generalNotificationDetails);
      }
    });
  }

  sendPushToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      print(token);
      await ApiService().sendFcmToken(token, '64157b99303ac48fb69cd12e');
    } else
      print('token is null');
  }

  @override
  Widget build(BuildContext context) {
    final List<Doctor> allDoctors = (jsonDecode(doctorsJson)['doctors'] as List)
        .map((json) => Doctor(
              name: json['name'],
              speciality: json['speciality'],
              location: json['location'],
              rating: json['rating'],
              image: json['image'],
              id: json['id'],
            ))
        .toList();
    return Scaffold(
      backgroundColor: MyColors.gray3,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeTab(
            onPressedScheduleCard: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OnAppointment()));
            },
            user: allDoctors,
          ),
          Container(
            child: const Center(
              child: Text('Search'),
            ),
          ),
          ScheduleTab(),
          ProfileScreen()
        ],
        onPageChanged: (idx) {
          setState(() {
            _currentIndex = idx;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.white,
        unselectedItemColor: MyColors.gray2,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            _pageController
                .jumpTo(_currentIndex * MediaQuery.of(context).size.width);
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: MyColors.primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
