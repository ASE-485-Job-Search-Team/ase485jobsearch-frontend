import 'package:flutter/material.dart';
import 'package:jobsearchmobile/screens/auth/login.dart';
import 'package:jobsearchmobile/screens/auth/resume_upload.dart';
import 'package:jobsearchmobile/screens/auth/sign_up.dart';
import 'package:jobsearchmobile/screens/auth/sign_up_company.dart';
import 'package:jobsearchmobile/screens/auth/sign_up_select_type.dart';
import 'package:jobsearchmobile/screens/landing_page/landing_page.dart';
import 'package:jobsearchmobile/screens/main_layout.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';
import 'package:http/http.dart' as http;

final APIService apiService = APIService(client: http.Client);
void main() => runApp(MyApp(apiService: apiService,));

class MyApp extends StatelessWidget {
  final APIService apiService;
  const MyApp({super.key, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Search App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.blue),
          labelLarge: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/signup': (context) => SignUpPage(apiService: apiService,),
        '/login': (context) => LoginPage(apiService: apiService,),
        '/home': (context) => MainAppLayout(apiService: apiService,),
        '/signupcompany': (context) => SignUpCompanyPage(apiService: apiService,),
        '/select': (context) => const SelectTypePage(),
        // '/user': (context) => UserDashboardPage(),
        '/resume': (context) => ResumeUploadPage(apiService: apiService,),
        // '/company': (context) => DashboardPage(),
        // '/jobapp': (context) => JobApplicationPage(),
      },
    );
  }
}
