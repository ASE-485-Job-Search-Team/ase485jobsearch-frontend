import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jobsearchmobile/models/user.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User _user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    late User user;
    String response = await APIService.getUserProfile();

    final model = jsonDecode(response);
    final isAdmin = model['data']['isAdmin'];

    if(isAdmin){
      user = User(
        id: model['data']['id'],
        name: model['data']['company'],
        email: model['data']['email'],
      );
    } else {
      user = User(
        id: model['data']['id'],
        name: model['data']['first'] + ' ' + model['data']['last'],
        email: model['data']['email'],
      );
    }

    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _user != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${_user.name}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Email: ${_user.email}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
