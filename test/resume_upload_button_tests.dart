import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:jobsearchmobile/screens/auth/widgets/resume_upload_button.dart';

void main() {
  var test_userID = "user";
  group('ResumeUploadButton Unit Tests', () {
    testWidgets('displays initial state without a selected resume', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ResumeUploadButton(userID: test_userID,)));
      expect(find.text('Upload Resume (PDF)'), findsOneWidget);
      expect(find.text('Selected resume: '), findsNothing);
    });
  });

  group('ResumeUploadButton GUI Tests', () {
    testWidgets('displays Upload Resume button', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ResumeUploadButton(userID: test_userID,)));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}

