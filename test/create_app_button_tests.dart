import 'package:flutter/material.dart';
import 'package:jobsearchmobile/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jobsearchmobile/screens/my_applications/pages/job_app_create_form.dart';
import 'package:jobsearchmobile/screens/my_applications/widgets/create_app_button.dart';

void main() {
  group('Create App Button Widget Tests', () {
    testWidgets('Create App Button is displayed', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: CreateAppButton())));

      // Check if the Create Application button is present
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Create Application'), findsOneWidget);

      // Check the style of the Create Application button
      final elevatedButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final buttonStyle = elevatedButton.style;

      expect(buttonStyle?.backgroundColor?.resolve({}), Color(0xFF2c3a6d));
      expect(buttonStyle?.padding?.resolve({}), EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0));
    });

    testWidgets('Create App Button navigates to JobApplicationPage', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: CreateAppButton()),
        routes: {
          '/job-application': (context) => JobApplicationPage(),
        },
      ));

      // Tap the Create Application button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify that the JobApplicationPage is displayed
      expect(find.byType(JobApplicationPage), findsOneWidget);
    });
  });

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Create App Button Integration Tests', () {
    testWidgets('Navigate to Job Application Page when button is pressed', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Assuming the CreateAppButton is present in the Home Page
      // First, find the button by searching for the text 'Create Application'
      Finder createAppButton = find.text('Create Application');
      expect(createAppButton, findsOneWidget);

      // Tap the button to navigate to the JobApplicationPage
      await tester.tap(createAppButton);
      await tester.pumpAndSettle();

      // Check if the JobApplicationPage is now displayed
      expect(find.byType(JobApplicationPage), findsOneWidget);
    });
  });

  group('Create App Button Regression Tests', () {
    testWidgets('Verify Create App Button functionality after changes', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to the screen containing the CreateAppButton and perform the regression tests
      // Add regression tests to ensure that the button functionality works as expected after changes
      // ...
    });
  });
}
