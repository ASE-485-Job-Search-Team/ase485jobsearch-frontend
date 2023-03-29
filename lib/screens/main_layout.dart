import 'package:flutter/material.dart';
import 'package:jobsearchmobile/screens/home/user_home_page.dart';
import 'package:jobsearchmobile/screens/my_applications/my_applications.dart';

class MainAppLayout extends StatefulWidget {
  const MainAppLayout({Key? key}) : super(key: key);

  @override
  State<MainAppLayout> createState() => _MainAppLayoutState();
}

class _MainAppLayoutState extends State<MainAppLayout> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    UserHomePage(),
    MyApplications(),
    Text('Hello'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cases_outlined),
            label: 'My Applications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'My Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF2c3a6d),
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
      ),
    );
  }
}
