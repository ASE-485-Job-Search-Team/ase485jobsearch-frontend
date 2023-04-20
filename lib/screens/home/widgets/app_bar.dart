import 'package:flutter/material.dart';

import '../../../models/user.dart';

class HomeAppBar extends StatelessWidget {
  final User user;
  const HomeAppBar({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Welcome back,',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 4.0,
              ),
              Text(user.name,
                  style: const TextStyle(
                      fontSize: 28.0, fontWeight: FontWeight.w600))
            ]),
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey.shade300,
              child: Icon(
                Icons.person_outline,
                size: 28,
                color: Colors.grey.shade600,
              ),
            ),
          ]),
    );
  }
}
