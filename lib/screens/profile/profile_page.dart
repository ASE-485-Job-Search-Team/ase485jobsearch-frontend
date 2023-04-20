import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jobsearchmobile/models/user.dart';
import 'package:jobsearchmobile/screens/profile/widgets/resume_reader.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _loadUserData();
  }

  Future<User> _loadUserData() async {
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

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<User>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                          Icons.person_outline,
                          size: 48,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            user.email,
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  const Text(
                    'Account Information',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Membership status:',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600]),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Active',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Visibility(
                      visible: !user.isAdmin,
                      child: const Text(
                        'My Resume',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w600),
                      )),
                  Visibility(
                    visible: !user.isAdmin,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[200]!)),
                      child: Row(
                        children: [
                          Container(
                            width: 32.0,
                            height: 32.0,
                            padding: const EdgeInsets.all(4.0),
                            child: const Icon(Icons.picture_as_pdf,
                                color: Colors.red, size: 20),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 180,
                                child: Text(
                                  'Resume_0403',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Text('Last updated: 04/03/2023',
                                  style: const TextStyle(
                                      fontSize: 12.0, color: Colors.grey)),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ResumeReader(
                                            title: 'Resume',
                                            resumeUrl:
                                                'https://firebasestorage.googleapis.com/v0/b/ase456-myfirstproject.appspot.com/o/Software%20Engineer.pdf?alt=media',
                                          )));
                            },
                            child: Chip(
                              label: Text(
                                'Preview',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.grey.shade700),
                              ),
                              visualDensity: VisualDensity.compact,
                              backgroundColor: Colors.grey.shade100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
