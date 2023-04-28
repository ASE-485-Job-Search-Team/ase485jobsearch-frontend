import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsearchmobile/models/user.dart';
import 'package:jobsearchmobile/screens/home/widgets/custom_app_bar.dart';
import 'package:jobsearchmobile/screens/my_applications/pages/job_app_create_form.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';
import 'package:jobsearchmobile/services/job_posting_service.dart';
import 'package:mockito/mockito.dart';

import 'mocks/mock_api_service.dart';
import 'mocks/mock_job_posting_service.dart';
import 'package:http/http.dart' as http;
import 'user_home_page_test.mocks.dart';


void main() {
  group('JobApplicationPage', () {
    late http.Client client;

    setUp(() {
      client = MockClient();
    });
    testWidgets('Form renders and submits correctly', (WidgetTester tester) async {
      // Prepare test data
      final mockApiService = APIService(client: client);
      final mockJobPostingService = MockJobPostingService();

      when(mockApiService.getUserProfile()).thenAnswer((_) async {
        return User(
          id: '1',
          name: 'John Doe',
          email: 'john.doe@example.com',
          isAdmin: false,
        ) as String;
      });

      // Build the widget
      await tester.pumpWidget(MaterialApp(
        home: JobApplicationPage(
          apiService: mockApiService,
          jobPostingService: mockJobPostingService,
        ),
      ));

      // Verify CustomAppBar title
      expect(find.widgetWithText(CustomAppBar, 'Create Job Application'), findsOneWidget);

      // Fill out the form
      await tester.enterText(find.byType(TextFormField).first, 'Job Title');
      await tester.enterText(find.byType(TextFormField).at(1), 'Location');
      await tester.enterText(find.byType(TextFormField).at(2), 'Job Type');
      await tester.enterText(find.byType(TextFormField).at(3), 'Job Description');
      await tester.enterText(find.byType(TextFormField).at(4), 'Qualification');
      await tester.enterText(find.byType(TextFormField).at(5), 'Responsibility');
      await tester.enterText(find.byType(TextFormField).at(7), 'Closing Date');
      await tester.enterText(find.byType(TextFormField).at(8), 'Salary Range');

      // Tap the 'Submit' button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify that createJobPosting was called with the correct data
      verify(mockJobPostingService.createJobPosting(
        title: 'Job Title',
        companyId: '1',
        location: 'Location',
        jobType: 'Job Type',
        description: 'Job Description',
        qualifications: ['Qualification'],
        responsibilities: ['Responsibility'],
        datePosted: 'Posted Date',
        dateClosing: 'Closing Date',
        salaryRange: 'Salary Range',
      ));
    });
  });
}
