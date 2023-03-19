import 'package:eppo/constants/colors.dart';
import 'package:eppo/pages/home_page.dart';
import 'package:eppo/pages/prof_home_page.dart';
import 'package:eppo/pages/requests.dart';
import 'package:eppo/services/appointment_service.dart';
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
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ProfTab(
              onPressedScheduleCard: () {},
            ),
            PendingAppointments(),
            Container(
              child: Center(
                child: InkWell(
                    onTap: () async {
                      var released = await AppointmentService().release();
                      if (released) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Appointment Released'),
                        ));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Release Appointment',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    )),
              ),
            ),
          ],
          onPageChanged: (idx) {
            setState(() {
              _currentIndex = idx;
            });
          },
        ),
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
