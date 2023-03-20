import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:jobsearchmobile/constants/api.dart';
import 'package:jobsearchmobile/models/job_application.dart';
import 'package:jobsearchmobile/services/my_application_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'my_applications_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('fetch my applications', () {
    late http.Client client;
    late MyApplicationService myApplicationService;

    setUp(() {
      client = MockClient();
      myApplicationService = MyApplicationService(httpClient: client);
    });

    test(
        'returns a list of job applications a user has applied if the http call completes successfully',
        () async {
      const myApplicationsJson =
          '[{"id":1,"dateApplied":"2023-03-08T00:00:00","status":"applied","jobSeekerId":1,"jobPostingId":1,"jobPosting":{"id":"1","title":"Software Engineer","company":"Google LLC","location":"New York, NY","jobType":"Full-time","description":"We\';re looking for a talented software engineer to join our team and help us build amazing products.","qualifications":["Bachelor\'s degree in Computer Science or related field","3+ years of experience in software development","Proficiency in Java, Python, or Ruby","Strong problem-solving skills","Excellent communication skills"],"responsibilities":["Develop and maintain high-quality software using best practices","Collaborate with cross-functional teams to design and implement new features","Write clean, efficient, and well-documented code","Participate in code reviews and contribute to continuous improvement of our development processes","Stay up-to-date with emerging trends and technologies in software development"],"datePosted":"2022-12-01T00:00:00","dateClosing":"2023-01-31T00:00:00","companyLogo":"https://companiesmarketcap.com/img/company-logos/64/GOOG.webp","salaryRange":"\$150,000 - \$180,000"}},{"id":2,"dateApplied":"2023-03-08T00:00:00","status":"underReview","jobSeekerId":1,"jobPostingId":2,"jobPosting":{"id":"2","title":"Marketing Manager","company":"Netflix","location":"Los Angeles, CA","jobType":"Full-time","description":"We\'re seeking an experienced marketing manager to help us develop and execute effective marketing strategies.","qualifications":["Bachelor\'s degree in Marketing or related field","5+ years of experience in marketing or related field","Excellent communication and interpersonal skills","Proven track record of developing and executing successful marketing campaigns","Strong analytical skills and ability to interpret data to inform decision-making"],"responsibilities":["Develop and execute comprehensive marketing strategies that align with business goals","Collaborate with cross-functional teams to create compelling marketing materials","Manage marketing campaigns across multiple channels, including email, social media, and paid advertising","Track and analyze key marketing metrics to measure effectiveness of campaigns and make data-driven decisions","Stay up-to-date with emerging trends and technologies in marketing"],"datePosted":"2022-11-15T00:00:00","dateClosing":"2023-02-28T00:00:00","companyLogo":"https://companiesmarketcap.com/img/company-logos/64/NFLX.webp","salaryRange":"\$150,000 - \$180,000"}}]';
      when(client.get(Uri.parse('${Api.baseUrl}/applications?')))
          .thenAnswer((_) async => http.Response(myApplicationsJson, 200));
      final result =
          await myApplicationService.fetchJobApplicationsForBuilder(client);
      expect(result, isA<List<JobApplication>>());
      expect(result, hasLength(2));
    });

    test('throws an exception if the http call completes with an error', () {
      when(client.get(Uri.parse('${Api.baseUrl}/applications?')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(myApplicationService.fetchJobApplicationsForBuilder(client),
          throwsException);
    });
  });
}
