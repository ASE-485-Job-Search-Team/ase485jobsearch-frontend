import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:jobsearchmobile/constants/api.dart';
import 'package:jobsearchmobile/models/job_info.dart';
import 'package:jobsearchmobile/services/job_posting_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_home_page_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetch job postings', () {
    late http.Client client;
    late JobPostingService jobPostingService;

    setUp(() {
      client = MockClient();
      jobPostingService = JobPostingService(httpClient: client);
    });

    test(
        'returns a list of job postings if the http call completes successfully',
        () async {
      const jobPostingsJson =
          '[{"id": "1", "title": "Software Engineer", "company": "Google LLC", "location": "New York, NY", "jobType": "Full-time", "description": "We\'re looking for a talented software engineer to join our team and help us build amazing products.", "qualifications": ["Bachelor\'s degree in Computer Science or related field", "3+ years of experience in software development", "Proficiency in Java, Python, or Ruby", "Strong problem-solving skills", "Excellent communication skills"], "responsibilities": ["Develop and maintain high-quality software using best practices", "Collaborate with cross-functional teams to design and implement new features", "Write clean, efficient, and well-documented code", "Participate in code reviews and contribute to continuous improvement of our development processes", "Stay up-to-date with emerging trends and technologies in software development"], "datePosted": "2022-12-01T00:00:00.000", "dateClosing": "2023-01-31T00:00:00.000", "companyLogo": "https://companiesmarketcap.com/img/company-logos/64/GOOG.webp", "salaryRange": "\$150,000 - \$180,000"}, {"id": "2", "title": "Software Engineer", "company": "Facebook Inc.", "location": "New York, NY", "jobType": "Full-time", "description": "We\'re looking for a talented software engineer to join our team and help us build amazing products.", "qualifications": ["Bachelor\'s degree in Computer Science or related field", "3+ years of experience in software development", "Proficiency in Java, Python, or Ruby", "Strong problem-solving skills", "Excellent communication skills"], "responsibilities": ["Develop and maintain high-quality software using best practices", "Collaborate with cross-functional teams to design and implement new features", "Write clean, efficient, and well-documented code", "Participate in code reviews and contribute to continuous improvement of our development processes", "Stay up-to-date with emerging trends and technologies in software development"], "datePosted": "2022-12-01T00:00:00.000", "dateClosing": "2023-01-31T00:00:00.000", "companyLogo": "https://companiesmarketcap.com/img/company-logos/64/FB.webp", "salaryRange": "\$150,000 - \$180,000"}]';
      // final jsonMap = json.decode(jobPostingsJson);
      // final jobPostings =
      //     jsonMap.map((json) => JobPosting.fromJson(json)).toList();
      when(client.get(Uri.parse('${Api.baseUrl}/jobPostings?')))
          .thenAnswer((_) async => http.Response(jobPostingsJson, 200));
      final result = await jobPostingService.fetchJobPostingsForBuilder(client);
      expect(result, isA<List<JobPosting>>());
      expect(result, hasLength(2));
    });

    test('throws an exception if the http call completes with an error', () {
      when(client.get(Uri.parse('${Api.baseUrl}/jobPostings?')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(jobPostingService.fetchJobPostingsForBuilder(client),
          throwsException);
    });
  });
}
