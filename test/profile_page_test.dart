import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsearchmobile/screens/profile/profile_page.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';
import 'package:jobsearchmobile/services/resume_service.dart';
import 'mock_api_service.dart';
import 'mock_resume_service.dart';

void main() {
  testWidgets('ProfilePage displays user data and resume correctly', (WidgetTester tester) async {
    // Create mock instances of APIService and ResumeService
    final mockAPIService = MockAPIService();
    final mockResumeService = MockResumeService();

    // Set the static instances of APIService and ResumeService to the mock instances
    APIService.instance = mockAPIService;
    ResumeService.instance = mockResumeService;

    // Build the ProfilePage widget
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));

    // Wait for the future builders to complete
    await tester.pumpAndSettle();

    // Verify that the user's name and email are displayed
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('john.doe@example.com'), findsOneWidget);

    // Verify that the resume information is displayed
    expect(find.text('resume.pdf'), findsOneWidget);
    expect(find.byType(Chip), findsOneWidget);
  });
}
