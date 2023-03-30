import 'dart:convert';
import 'package:flutter/material.dart';
import '../home/widgets/custom_app_bar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isCompany = true;
  String? _companyName;
  String? _email;
  String? _password;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _handleRadioValueChange(bool? value) {
    setState(() {
      _isCompany = value ?? true;
    });
  }

  void _handleCompanyNameChange(String value) {
    setState(() {
      _companyName = value;
    });
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      // Create a Map object to hold the input data
      Map<String, dynamic> userData = {
        'email': _email,
        'password': _password,
      };

      if (_isCompany && _companyName!.isNotEmpty) {
        userData['companyName'] = _companyName;
      }

      // Convert the Map to JSON format
      String jsonData = json.encode(userData);

      // TODO: Send jsonData to the database API

      // Navigate to dashboard page
      Navigator.pushNamed(context, '/user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Sign Up"),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2c3a6d)),
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: _validateEmail,
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            obscureText: true,
                            validator: _validatePassword,
                          ),
                          SizedBox(height: 16.0),
                          Text('I am a:'),
                          Row(
                            children: [
                              Radio(
                                value: true,
                                groupValue: _isCompany,
                                onChanged: _handleRadioValueChange,
                              ),
                              Text('Company'),
                            ],
                          ),
                          if (_isCompany)
                            TextField(
                              decoration: InputDecoration(
                                labelText: "What is your company's name?",
                              ),
                              onChanged: _handleCompanyNameChange,
                            ),
                          Row(
                            children: [
                              Radio(
                                value: false,
                                groupValue: _isCompany,
                                onChanged: _handleRadioValueChange,
                              ),
                              Text('Job searcher'),
                            ],
                          ),
                          SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: _handleSignUp,
                            child: Text('Sign up'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color(0xFF2c3a6d)),
                              padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0)),
                            ),
                          ),
                        ],
                      ),
                    ),]),
            )
        )
    );
  }
}