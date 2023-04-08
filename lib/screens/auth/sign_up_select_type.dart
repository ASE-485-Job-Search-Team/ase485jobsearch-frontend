import 'package:flutter/material.dart';
import '../home/widgets/custom_app_bar.dart';

class SelectTypePage extends StatefulWidget {
  const SelectTypePage({super.key});

  @override
  _SelectTypePageState createState() => _SelectTypePageState();
}

class _SelectTypePageState extends State<SelectTypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Select Type"),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to login page
                Navigator.pushNamed(context, '/signup');
              },
              child: Text('Individual'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF2c3a6d)),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0)),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to sign up page
                Navigator.pushNamed(context, '/signupcompany');
              },
              child: Text('Company'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF2c3a6d)),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
