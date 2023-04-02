import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jobsearchmobile/models/user.dart';

class UserService {
  final String apiUrl = 'https://example.com/api/users';

  Future<User> getCurrentUser() async {
    final response = await http.get(Uri.parse('$apiUrl/1'));

    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);
      return User.fromJson(userData);
    } else {
      throw Exception('Failed to load user');
    }
  }
}
