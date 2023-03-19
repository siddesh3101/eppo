import 'package:eppo/pages/chat_page.dart';
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
  '/': (context) => MainPage(),
  '/detail': (context) => const SliverDoctorDetail(),
  '/book': (context) => BookSlotPage(),
  '/professional': (context) => const ProfPage(),
  '/chat': (context) => const ChatPage(userId: 'siddesh', otherId: 'sachin'),
};
