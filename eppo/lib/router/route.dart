import 'package:eppo/pages/chat_page.dart';
import 'package:eppo/pages/main_page.dart';
import 'package:flutter/material.dart';

import '../pages/prof_page.dart';
import '../pages/sliver_detail.dart';
import '../screens/home_screen.dart';
import '../pages/book_slot.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const MainPage(),
  '/detail': (context) => const SliverDoctorDetail(),
  '/book': (context) => const BookSlotPage(),
  '/professional': (context) => const ProfPage(),
  '/chat': (context) => const ChatPage(userId: 'siddesh', otherId: 'sachin'),
};
