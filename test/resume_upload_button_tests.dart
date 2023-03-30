import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jobsearchmobile/main.dart' as app;
import 'package:jobsearchmobile/screens/my_applications/widgets/resume_upload_button.dart';

void main() {
  group('ResumeUploadButton Unit Tests', () {
    testWidgets('displays initial state without a selected resume', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ResumeUploadButton()));
      expect(find.text('Upload Resume (PDF)'), findsOneWidget);
      expect(find.text('Selected resume: '), findsNothing);
    });
  });

  group('ResumeUploadButton GUI Tests', () {
    testWidgets('displays Upload Resume button', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ResumeUploadButton()));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}

