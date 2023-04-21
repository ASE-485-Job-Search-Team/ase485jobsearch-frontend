import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import '../../models/user.dart';
import '../../services/auth_api_service.dart';
import 'widgets/resume_upload_button.dart';

class ResumeUploadPage extends StatefulWidget {
  const ResumeUploadPage({Key? key}) : super(key: key);

  @override
  _ResumeUploadPage createState() => _ResumeUploadPage();
}

class _ResumeUploadPage extends State<ResumeUploadPage> {
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _loadUserData();
  }

  Future<User> _loadUserData() async {
    String response = await APIService.getUserProfile();

    final model = jsonDecode(response);
    final isAdmin = model['data']['isAdmin'];
    User user;

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

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Resume'),
        backgroundColor: HexColor("#283B71"),
      ),
      body: Center(
        child: FutureBuilder<User>(
          future: _userFuture,
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final user = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Please upload your resume',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ResumeUploadButton(
                    userID: user!.id,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
