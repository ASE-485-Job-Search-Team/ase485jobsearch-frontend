import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jobsearchmobile/constants/api.dart';

class JobApplicationService {
  final http.Client httpClient;

  JobApplicationService({required this.httpClient});

  Future<void> applyForJob(String userId, String jobId) async {
    const String url = '${Api.baseUrl}/jobs/apply';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> requestBody = {'userId': userId, 'jobId': jobId};

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(requestBody),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to apply for job: ${response.body}');
    }
  }
}
