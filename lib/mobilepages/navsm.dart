// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:smart_bin/mobilepages/navpages/homepage.dart';
import 'package:smart_bin/mobilepages/navpages/datalog.dart';
import 'package:smart_bin/mobilepages/navpages/dashboard.dart';
import 'package:smart_bin/mobilepages/login_register.dart';

class NavPage extends StatefulWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _selectedIndex = 0;

  final List<String> _titles = const [
    'Home',
    'Dashboard',
    'Data Log',
    'Statistic',
  ];

  late List<Widget> _pages; // Define _pages here as an instance variable

  void changePage(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  void initState() {
    super.initState();

    // Initialize _pages list
    _pages = [
      HomePage(),
      const DashBoard(),
      const DataLog(),
    ];
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const LogOrRegister()));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.9),
        appBar: AppBar(
          centerTitle: true,
          leading: Container(
            margin: const EdgeInsets.all(8.0),
            child: Image.asset(
              'image/trashlogo.png',
            ),
          ),
          title: Text(
            _titles[_selectedIndex],
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Work',
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          actions: [
            IconButton(
              onPressed: signOut,
              icon: const Icon(Icons.logout_outlined),
            ),
          ],
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 13, 13, 13),
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: GNav(
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            changePage(index);
          },
          iconSize: 23,
          gap: 5,
          color: Colors.white,
          activeColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 18),
          backgroundColor: const Color.fromARGB(255, 13, 13, 13),
          tabBackgroundColor: Colors.white.withOpacity(0.05),
          tabs: const [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
              textStyle: TextStyle(
                  fontFamily: 'Nova',
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            GButton(
              icon: LineIcons.trash,
              text: 'Dashboard',
              textStyle: TextStyle(
                  fontFamily: 'Nova',
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            GButton(
              icon: LineIcons.server,
              text: 'Data Log',
              textStyle: TextStyle(
                  fontFamily: 'Nova',
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
