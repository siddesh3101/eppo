import 'dart:collection';

import 'package:eppo/pages/main_page.dart';
import 'package:eppo/pages/queue.dart';
import 'package:eppo/pages/virtual_queue.dart';
import 'package:flutter/material.dart';

import '../pages/prof_page.dart';
import '../pages/sliver_detail.dart';
import '../screens/book_slot.dart';
import '../screens/home_screen.dart';
import '../screens/review_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const MainPage(),
  '/detail': (context) => const SliverDoctorDetail(),
  '/book': (context) => const BookSlotPage(),
  '/professional': (context) => const ProfPage(),
};
