import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api.dart';
import '../models/job_info.dart';

class JobPostingService {
  final http.Client httpClient;

  JobPostingService({required this.httpClient});

  Future<List<JobPosting>> fetchJobPostingsForBuilder(http.Client client,
      {String query = ''}) async {
    final response =
        await client.get(Uri.parse('${Api.jobPostingsUrl}?$query'));
    if (response.statusCode == 200) {
      final jobPostings = jsonDecode(response.body) as List;
      return jobPostings
          .map((jobPosting) => JobPosting.fromJson(jobPosting))
          .toList();
    } else {
      throw Exception('Failed to load job postings');
    }
  }

  Future<http.Response> createJobPosting(
      {required String title,
      required String location,
      required String jobType,
      required String description,
      required List<String> qualifications,
      required List<String> responsibilities,
      required String datePosted,
      required String dateClosing,
      required String salaryRange}) async {
    var url = Uri.parse('${Api.jobPostingsUrl}/create');

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    Map<String, dynamic> jobPostingData = {
      'title': title,
      'companyId': '', //TODO: Replace with companyId
      'location': location,
      'jobType': jobType,
      'description': description,
      'qualifications': qualifications,
      'responsibilities': responsibilities,
      'datePosted': datePosted,
      'dateClosing': dateClosing,
      'salaryRange': salaryRange
    };

    final response = await http.post(url,
        headers: headers, body: jsonEncode(jobPostingData));

    return response;
  }
}
