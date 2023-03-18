import 'package:eppo/constants/colors.dart';
import 'package:eppo/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class ProfPage extends StatefulWidget {
  const ProfPage({super.key});

  @override
  State<ProfPage> createState() => _ProfPageState();
}

class _ProfPageState extends State<ProfPage> {
  // current index state
  int _currentIndex = 0;

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.gray3,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
            child: const Center(
              child: Text('Home'),
            ),
          ),
          Container(
            child: const Center(
              child: Text('Requests'),
            ),
          ),
          Container(
            child: const Center(
              child: Text('Profile'),
            ),
          ),
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
            icon: Icon(Icons.calendar_month),
            label: 'Requests',
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
