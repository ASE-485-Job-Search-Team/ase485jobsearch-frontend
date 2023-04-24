import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsearchmobile/models/resume_upload_result.dart';
import 'package:jobsearchmobile/screens/auth/widgets/resume_upload_button.dart';

void main() {
  group('ResumeUploadButton widget', () {
    final String userID = '1234';
    final ResumeUploadResult mockResult = ResumeUploadResult(
      'test_resume.pdf',
      '5678',
    );

    testWidgets('displays selected resume name after upload', (WidgetTester tester) async {
      await tester.pumpWidget(ResumeUploadButton(userID: userID));

      final uploadButton = find.byType(ElevatedButton);
      expect(uploadButton, findsOneWidget);

      // Tap the upload button to simulate a successful upload
      await tester.tap(uploadButton);
      await tester.pumpAndSettle();

      final selectedResumeText = find.text('Selected resume: ${mockResult.fileName}');
      expect(selectedResumeText, findsOneWidget);
    });

    testWidgets('shows success dialog after successful upload', (WidgetTester tester) async {
      await tester.pumpWidget(ResumeUploadButton(userID: userID));

      final uploadButton = find.byType(ElevatedButton);
      expect(uploadButton, findsOneWidget);

      // Tap the upload button to simulate a successful upload
      await tester.tap(uploadButton);
      await tester.pumpAndSettle();

      final dialog = find.byType(AlertDialog);
      expect(dialog, findsOneWidget);

      final dialogTitle = find.text('Registration Complete');
      expect(dialogTitle, findsOneWidget);

      final dialogContent = find.text('Your resume has been uploaded successfully.');
      expect(dialogContent, findsOneWidget);

      final okButton = find.text('OK');
      expect(okButton, findsOneWidget);

      // Tap the OK button to close the dialog
      await tester.tap(okButton);
      await tester.pumpAndSettle();

      // Ensure that we have navigated back to the home page
      final homePage = find.byKey(ValueKey('HomePage'));
      expect(homePage, findsOneWidget);
    });
  });
}
