import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsearchmobile/models/auth/update_resume_fb_request.dart';
import 'package:jobsearchmobile/models/auth/update_resume_fb_response.dart';
import 'package:jobsearchmobile/models/auth/update_resume_md_request.dart';
import 'package:jobsearchmobile/models/auth/update_resume_md_response.dart';
import 'package:jobsearchmobile/models/resume_upload_result.dart';
import 'package:jobsearchmobile/screens/auth/widgets/resume_upload_button.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';
import 'package:jobsearchmobile/services/resume_upload_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'user_home_page_test.mocks.dart';

import 'package:http/http.dart' as http;
import 'user_home_page_test.mocks.dart';

void main() {
  group('Resume Upload Button Tests', () {
    late http.Client client;
    late APIService apiService;

    setUp(() {
      client = MockClient();
      apiService = APIService(client: client);
    });

    testWidgets('Renders upload button with correct initial state', (
        WidgetTester tester) async {
      await tester.pumpWidget(
          MaterialApp(home: Scaffold(body: ResumeUploadButton(userID: '1', apiService: apiService,))));

      expect(find.text('Upload File'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Successfully uploads resume and shows success dialog', (
        WidgetTester tester) async {
      final mockResumeUploader = ResumeUploader(); // Use the MockResumeUploader
      final mockAPIService = APIService(client: client);

      when(mockResumeUploader.uploadResume('userId')).thenAnswer((_) async =>
          ResumeUploadResult('resume.pdf', '123'));

      when(mockAPIService.updateResumeMD(UpdateResumeMDRequestModel as UpdateResumeMDRequestModel)).thenAnswer((_) async =>
          UpdateResumeMDResponseModel(message: 'success', data: Data(
              first: 'John',
              last: 'Doe',
              email: 'john.doe@example.com',
              date: '2023-01-01',
              id: '1',
          )));

      when(mockAPIService.updateResumeFB(UpdateResumeFBRequestModel as UpdateResumeFBRequestModel)).thenAnswer((_) async =>
          UpdateResumeFBResponseModel(put: 'success'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ResumeUploadButton(userID: '1',
                resumeUploader: mockResumeUploader, apiService: apiService,), // Pass the MockResumeUploader to the widget
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Selected resume: resume.pdf'), findsOneWidget);
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Registration Complete'), findsOneWidget);
      expect(find.text('Your resume has been uploaded successfully.'),
          findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    // Add more tests to cover various scenarios, such as error handling and different API responses.
  });
}
