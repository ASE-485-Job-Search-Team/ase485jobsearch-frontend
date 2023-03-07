import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 16, left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Welcome back,',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text('John Doe',
                      style: TextStyle(
                          fontSize: 28.0, fontWeight: FontWeight.w600))
                ]),
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://flowbite.com/docs/images/people/profile-picture-5.jpg'),
            ),
          ],
        ));
  }
}
