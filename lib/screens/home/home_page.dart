import 'package:flutter/material.dart';
import 'package:jobsearchmobile/screens/home/widgets/app_bar.dart';
import 'package:jobsearchmobile/screens/home/widgets/job_posting_list.dart';
import 'package:jobsearchmobile/screens/home/widgets/search_bar.dart';
import 'package:jobsearchmobile/screens/home/widgets/tag_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    Column(
      children: [
        HomeAppBar(),
        HomeSearchBar(),
        TagList(),
        HomeJobPostingList()
      ],
    ),
    Text(
      'My Applications',
      style: optionStyle,
    ),
    Text(
      'My Profile',
      style: optionStyle,
    ),
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
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
      ),
    );
  }
}
