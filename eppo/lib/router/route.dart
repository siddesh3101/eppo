import 'dart:collection';

import 'package:eppo/pages/main_page.dart';

import 'package:flutter/material.dart';

import '../pages/dr_screen.dart';
import '../pages/prof_page.dart';
import '../pages/sliver_detail.dart';
import '../screens/book_slot.dart';
import '../screens/home_screen.dart';
import '../screens/review_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => MyApp(),
  '/detail': (context) => const SliverDoctorDetail(),
  '/book': (context) => const BookSlotPage(),
  '/professional': (context) => const ProfPage(),
};
