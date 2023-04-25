import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsearchmobile/models/resume_upload_result.dart';
import 'package:jobsearchmobile/screens/auth/widgets/resume_upload_button.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'mocks/mock_api_service.dart';
import 'mocks/mock_resume_upload.dart';

@GenerateMocks([APIService])
void main() {
  group('Resume Upload Button Tests', () {
    testWidgets('Renders upload button with correct initial state', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: ResumeUploadButton(userID: '1'))));

      expect(find.text('Upload File'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Successfully uploads resume and shows success dialog', (WidgetTester tester) async {
      final mockResumeUploader = MockResumeUploader(); // Use the MockResumeUploader
      final mockAPIService = MockAPIService();

      when(mockResumeUploader.uploadResume(any)).thenAnswer((_) async => ResumeUploadResult('resume.pdf', '123'));

      when(mockAPIService.updateResumeMD(any)).thenAnswer((_) async => ResponseData(data: {'success': true}, put: 'success'));

      when(mockAPIService.updateResumeFB(any)).thenAnswer((_) async => ResponseData(data: null, put: 'success'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ResumeUploadButton(userID: '1', resumeUploader: mockResumeUploader), // Pass the MockResumeUploader to the widget
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Selected resume: resume.pdf'), findsOneWidget);
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Registration Complete'), findsOneWidget);
      expect(find.text('Your resume has been uploaded successfully.'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    // Add more tests to cover various scenarios, such as error handling and different API responses.
  });
}
