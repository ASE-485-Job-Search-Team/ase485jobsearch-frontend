import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api.dart';
import '../models/job_application.dart';

class MyApplicationService {
  final http.Client httpClient;

  MyApplicationService({required this.httpClient});

  Future<List<JobApplication>> fetchJobApplicationsForBuilder(
      http.Client client,
      {String query = ''}) async {
    final response =
        await client.get(Uri.parse('${Api.baseUrl}/applications?$query'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData
          .map((jobApplication) => JobApplication.fromJson(jobApplication))
          .toList();
    } else {
      throw Exception('Failed to load job applications');
    }
  }
}
