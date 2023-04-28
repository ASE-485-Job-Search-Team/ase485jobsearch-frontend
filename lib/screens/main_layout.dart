import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jobsearchmobile/screens/home/user_home_page.dart';
import 'package:jobsearchmobile/screens/home/widgets/custom_app_bar.dart';
import 'package:jobsearchmobile/screens/my_applications/my_applications.dart';
import 'package:jobsearchmobile/screens/my_applications/my_job_postings.dart';
import 'package:jobsearchmobile/screens/profile/profile_page.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';

import '../models/user.dart';

class MainAppLayout extends StatefulWidget {
  final APIService apiService;
  const MainAppLayout({Key? key, required this.apiService}) : super(key: key);

  @override
  State<MainAppLayout> createState() => _MainAppLayoutState();
}

class _MainAppLayoutState extends State<MainAppLayout> {
  late User _user;
  int _selectedIndex = 0;

  late List<Widget> _widgetOptions = <Widget>[];

  @override
  void initState() {
    super.initState();
    _user = User(
      id: '',
      name: '',
      email: '',
      resume: '',
      isAdmin: false,
    );
    _loadUserData();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _loadUserData() async {
    late User user;
    String response = await widget.apiService.getUserProfile();

    final model = jsonDecode(response);
    final isAdmin = model['data']['isAdmin'];

    if (isAdmin) {
      user = User(
        id: model['data']['id'],
        name: model['data']['company'],
        email: model['data']['email'],
        isAdmin: true,
      );
    } else {
      user = User(
        id: model['data']['id'],
        name: model['data']['first'] + ' ' + model['data']['last'],
        email: model['data']['email'],
        resume: model['data']['resume'],
        isAdmin: false,
      );
    }

    setState(() {
      _user = user;
      if (_user.isAdmin)
        _widgetOptions = <Widget>[
          MyJobPostings(apiService: widget.apiService,),
          ProfilePage(apiService: widget.apiService,),
        ];
      else
        _widgetOptions = <Widget>[
          UserHomePage(user: user, apiService: widget.apiService,),
          MyApplications(apiService: widget.apiService,),
          ProfilePage(apiService: widget.apiService,),
        ];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user.id == '') {
      return Scaffold(
        appBar: CustomAppBar(title: "Home"),
        body: Center(
          child: CircularProgressIndicator(),
        ),
        backgroundColor: Colors.white,
      );
    } else {
      return Scaffold(
        appBar: CustomAppBar(title: "Home"),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          items: _user.isAdmin
              ? const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.cases_outlined),
                    label: 'Job Postings',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_outlined),
                    label: 'Company Profile',
                  ),
                ]
              : const <BottomNavigationBarItem>[
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
}
