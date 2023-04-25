import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jobsearchmobile/models/job_info.dart';

class MockJobPostingService {
  Future<List<JobPosting>> fetchJobPostingsForBuilder(http.Client client, {String query = ''}) async {
    // Simulate fetching job postings
    List<JobPosting> jobPostings = [
      JobPosting(
        id: '1',
        title: 'Software Engineer',
        companyId: '1',
        company: 'Acme Inc.',
        location: 'New York',
        jobType: 'Full-Time',
        description: 'A great job opportunity',
        qualifications: ['Degree in CS'],
        responsibilities: ['Developing software'],
        datePosted: DateTime.now(),
        dateClosing: DateTime.now().add(Duration(days: 14)),
        companyLogo: '',
        salaryRange: '50,000 - 80,000',
      ),
    ];

    return jobPostings;
  }

  Future<http.Response> createJobPosting({
    required String title,
    required companyId,
    required String location,
    required String jobType,
    required String description,
    required List<String> qualifications,
    required List<String> responsibilities,
    required String datePosted,
    required String dateClosing,
    required String salaryRange,
  }) async {
    // Simulate creating a job posting
    return http.Response('{"status": "success", "message": "Job posting created"}', 200);
  }
}