import 'dart:collection';

import 'package:eppo/pages/main_page.dart';
import 'package:eppo/pages/queue.dart';
import 'package:eppo/pages/virtual_queue.dart';
import 'package:flutter/material.dart';

import '../pages/sliver_detail.dart';
import '../screens/home_screen.dart';
import '../screens/review_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => MainPage(),
  '/detail': (context) => SliverDoctorDetail(),
  '/review': (context) => RatingUI()
};
