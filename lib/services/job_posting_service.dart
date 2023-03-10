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
        await client.get(Uri.parse('${Api.baseUrl}/jobPostings?$query'));
    if (response.statusCode == 200) {
      final jobPostings = jsonDecode(response.body) as List;
      return jobPostings
          .map((jobPosting) => JobPosting.fromJson(jobPosting))
          .toList();
    } else {
      throw Exception('Failed to load job postings');
    }
  }
}
