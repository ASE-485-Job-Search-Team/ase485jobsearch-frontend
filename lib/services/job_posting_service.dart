import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api.dart';
import '../models/job_info.dart'; // Import the JobPosting data model

class JobPostingService {
  final http.Client httpClient;

  JobPostingService({required this.httpClient});

  Future<List<JobPosting>> fetchJobPostingsForBuilder(http.Client client,
      {String query = ''}) async {
    final response =
    await client.get(Uri.parse('${Api.jobPostingsUrl}?$query'));
    if (response.statusCode == 200) {
      print(response.statusCode);
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
        required companyId,
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

        // Create a JobPosting object
        JobPosting jobPosting = JobPosting(
          id: '', // You may need to assign an id before sending to the API
          title: title,
          companyId: companyId, // Replace with companyId
          company: '', // Replace with company name
          location: location,
          jobType: jobType,
          description: description,
          qualifications: qualifications,
          responsibilities: responsibilities,
          datePosted: DateTime.parse(datePosted),
          dateClosing: DateTime.parse(dateClosing),
          companyLogo: '', // Replace with companyLogo URL
          salaryRange: salaryRange,
        );

        // Use the JobPosting object's toJson method to generate the request body
        final response = await http.post(url,
            headers: headers, body: jsonEncode(jobPosting.toJson()));

        return response;
  }
}

