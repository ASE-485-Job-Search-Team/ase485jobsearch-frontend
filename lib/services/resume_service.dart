import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jobsearchmobile/constants/api.dart';

import '../models/resume.dart';

class ResumeService {
  static Future<Resume> fetchResume(String userId) async {
    final response =
        await http.get(Uri.parse('${Api.baseUrl}/users/$userId/resume'));

    if (response.statusCode == 200) {
      return Resume.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load resume');
    }
  }
}
