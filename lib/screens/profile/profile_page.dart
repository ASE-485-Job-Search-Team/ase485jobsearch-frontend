import 'package:flutter/material.dart';
import 'package:jobsearchmobile/models/user.dart';
import 'package:jobsearchmobile/screens/home/widgets/custom_app_bar.dart';
import 'package:jobsearchmobile/services/user_service.dart';

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
    final UserService userService = UserService();
    // Replace this with actual user data fetched from a service
    final User user = User(
      id: '1',
      name: 'John Doe',
      email: 'johndoe@example.com',
    );
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
