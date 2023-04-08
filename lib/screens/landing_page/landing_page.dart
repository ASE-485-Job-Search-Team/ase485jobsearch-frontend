import 'package:flutter/material.dart';
import 'package:jobsearchmobile/services/auth_shared_service.dart';
import '../home/widgets/custom_app_bar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  Future<void> _checkIfLoggedIn() async {
    // Example of asynchronous call to the function named `isLoggedIn`
    final isLoggedIn = await SharedService.isLoggedIn();
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Welcome to JobHive!"),
    body: Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
    if (!_isLoggedIn) ...[
    ElevatedButton(
    onPressed: () {
    // Navigate to sign up page
    Navigator.pushNamed(context, '/select');
    },
    child: Text('Sign Up'),
    style: ButtonStyle(
    backgroundColor:
    MaterialStateProperty.all(Color(0xFF2c3a6d)),
    padding: MaterialStateProperty.all(EdgeInsets.symmetric(
    vertical: 12.0, horizontal: 24.0)),
    ),
    ),
    SizedBox(height: 20.0),
    ElevatedButton(
    onPressed: () {
    // Navigate to login page
    Navigator.pushNamed(context, '/login');
    },
    child: Text('Log In'),
    style: ButtonStyle(
    backgroundColor:
    MaterialStateProperty.all(Color(0xFF2c3a6d)),
    padding: MaterialStateProperty.all(EdgeInsets.symmetric(
    vertical: 12.0, horizontal: 24.0)),
    ),
    ),
    ],
    SizedBox(height: 20.0),
    ElevatedButton(
    onPressed: () {
    // Navigate to sign up page
    Navigator.pushNamed(context, '/home');
    },
    child: Text('Home'),
    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Color(0xFF2c3a6d)),
    padding: MaterialStateProperty.all(EdgeInsets.symmetric(
    vertical: 12.0, horizontal: 24.0)),
    ),
    ),
    ],
    ),
    )
        );
  }}
