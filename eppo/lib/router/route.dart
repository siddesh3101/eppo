import 'package:eppo/pages/main_page.dart';
import 'package:flutter/material.dart';

import '../pages/sliver_detail.dart';
import '../screens/home_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => MainPage(),
  '/detail': (context) => SliverDoctorDetail(),
};
