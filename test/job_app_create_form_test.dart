import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:jobsearchmobile/screens/my_applications/pages/job_app_create_form.dart';
import 'package:jobsearchmobile/services/job_posting_service.dart';

class CustomMockClient extends http.BaseClient {
      http.Request? sentRequest;

      @override
      Future<http.StreamedResponse> send(http.BaseRequest request) {
            sentRequest = request as http.Request?;
            return Future.error(Exception('Test client, not sending actual request.'));
      }
}

void main() {
      testWidgets('JobApplicationPage submits form and sends a request to create a new job posting',
              (WidgetTester tester) async {
                // Prepare the custom mock API service
                final customMockClient = CustomMockClient();
                final jobPostingService = JobPostingService(httpClient: customMockClient);

                // Build the MaterialApp with JobApplicationPage as the home widget
                final app = MaterialApp(
                      home: JobApplicationPage(),
                );

                await tester.pumpWidget(app);

                // Fill in the form fields
                await tester.enterText(find.byType(TextFormField).at(0), 'Job Title');
                await tester.enterText(find.byType(TextFormField).at(1), 'Location');
                await tester.enterText(find.byType(TextFormField).at(2), 'Job Type');
                await tester.enterText(find.byType(TextFormField).at(3), 'Job Description');
                await tester.enterText(find.byType(TextFormField).at(4), 'Qualification');
                await tester.enterText(find.byType(TextFormField).at(5), 'Responsibility');
                await tester.enterText(find.byType(TextFormField).at(6), '2023-04-30');
                await tester.enterText(find.byType(TextFormField).at(7), '50000-70000');

                // Tap the submit button
                await tester.tap(find.text('Submit'));
                await tester.pumpAndSettle();

                // Verify that a POST request was sent to the API
                expect(customMockClient.sentRequest, isNotNull);
                expect(customMockClient.sentRequest!.method, 'POST');
                expect(customMockClient.sentRequest!.url.path, '/job_postings/create');
          });
}
