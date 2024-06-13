import 'package:healthforall/screens/appointment/patient_appointment_screen.dart';
import 'package:healthforall/screens/doctors/doctors_screen.dart';
import 'package:healthforall/screens/home/home_screen.dart';
import 'package:healthforall/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../constants.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/main';


  const MainScreen({super.key});


  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late final List<Widget> _pages;
  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePage(),
      const DoctorsScreen(),
      const MyAppointmentScreen(),
      ProfileScreen(),
    ];
  }
  int _selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPage],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(defaultPadding),
        color: Colors.white,
        child: SafeArea(
          child: GNav(
            haptic: true,
            tabBorderRadius: 15,
            curve: Curves.ease,
            duration: const Duration(milliseconds: 350),
            gap: 8,
            color: Colors.grey[800],
            activeColor: Colors.white,
            iconSize: 24,
            tabBackgroundColor: primaryColor,
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: defaultPadding / 2,
            ),
            tabs: const [
              GButton(
                backgroundColor: const Color(0xFF6CD8D1),
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                backgroundColor: const Color(0xfffea41d),
                icon: Icons.people,
                text: 'Doctors',
              ),
              GButton(
                backgroundColor: const Color(0xFF6CD8D1),
                icon: Icons.content_paste,
                text: 'Appointment',
              ),
              GButton(
                backgroundColor: const Color(0xfffea41d),
                icon: Icons.person,
                text: 'Profile',
              )
            ],
            onTabChange: (pageNum) {
              setState(() {
                _selectedPage = pageNum;
              });
            },
          ),
        ),
      ),
    );
  }
}
