import 'package:flutter/material.dart';
import 'package:jobsearchmobile/models/user.dart';
import 'package:jobsearchmobile/screens/home/widgets/app_bar.dart';
import 'package:jobsearchmobile/screens/home/widgets/custom_app_bar.dart';
import 'package:jobsearchmobile/screens/profile/widgets/resume_reader.dart';
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeAppBar(),
          const Divider(),
          const SizedBox(height: 16),
          const SizedBox(height: 8),
          const Text(
            'My Resume',
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
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
                            fontSize: 16.0, fontWeight: FontWeight.w600),
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
                            builder: (context) => const ResumeReader()));
                  },
                  child: Chip(
                    label: Text(
                      'Preview',
                      style: TextStyle(
                          fontSize: 12.0, color: Colors.grey.shade700),
                    ),
                    visualDensity: VisualDensity.compact,
                    backgroundColor: Colors.grey.shade100,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
