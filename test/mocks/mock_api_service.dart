import 'dart:convert';
import 'package:jobsearchmobile/models/auth/login_request.dart';
import 'package:jobsearchmobile/models/auth/login_response.dart';
import 'package:jobsearchmobile/models/auth/register_request.dart';
import 'package:jobsearchmobile/models/auth/register_response.dart';
import 'package:jobsearchmobile/models/user.dart';

class MockAPIService {
  static Future<bool> login(LoginRequestModel model) async {
    // Simulate successful login
    return true;
  }

  static Future<RegisterResponseModel> register(RegisterRequestModel model) async {
    // Simulate successful registration
    return RegisterResponseModel(message: 'Registration successful', data: null);
  }

  static Future<User> loadUserData() async {
    // Simulate loading user data
    return User(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      resume: 'resume.pdf',
      isAdmin: false,
    );
  }
}