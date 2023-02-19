import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Search App',
      theme: ThemeData(
        primaryColor: Colors.blue,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.blue),
          labelLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
        ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/signup': (context) => SignUpPage(),
        '/login': (context) => LoginPage(),
        '/user': (context) => UserDashboardPage(),
        '/resume': (context) => ResumeUploadPage(),
        '/company': (context) => DashboardPage(),
        '/jobapp': (context) => JobApplicationPage(),
      },
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome to [Name]!',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to sign up page
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text('Sign up'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12.0)),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to login page
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Login'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12.0)),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
