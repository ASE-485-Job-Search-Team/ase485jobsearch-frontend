import 'dart:convert';

import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../services/auth_api_service.dart';
import 'widgets/resume_upload_button.dart';

class ResumeUploadPage extends StatefulWidget {
  const ResumeUploadPage({Key? key}) : super(key: key);

  @override
  _ResumeUploadPage createState() => _ResumeUploadPage();
}

class _ResumeUploadPage extends State<ResumeUploadPage> {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Resume'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome! Please upload your resume.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ResumeUploadButton(
              userID: _user.id,
            ),
          ],
        ),
      ),
    );
  }
}
