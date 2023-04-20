import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jobsearchmobile/constants/api.dart';

import '../models/job_application.dart';

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

  Future<List<JobApplication>> getJobApplicationsFromJobPosting(
      String companyId, String jobId) async {
    final http.Response response = await http.get(Uri.parse(
        '${Api.baseUrl}/companies/$companyId/jobs/$jobId/jobApplications'));
    if (response.statusCode == 200) {
      final jobApplications = jsonDecode(response.body) as List;
      return jobApplications
          .map((jobApplication) => JobApplication.fromJson(jobApplication))
          .toList();
    } else {
      throw Exception('Failed to load job application');
    }
  }
}
