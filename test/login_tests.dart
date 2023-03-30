import 'package:flutter_test/flutter_test.dart';
import 'package:jobsearchmobile/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jobsearchmobile/screens/auth/login.dart';

void main() {
  group('LoginPage Unit Tests', () {
    testWidgets('displays form elements on the LoginPage', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    // Add additional unit tests for the widget's behavior
  });

  group('LoginPage GUI Tests', () {
    testWidgets('displays form elements with correct styles', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));
      // Add GUI tests for the widget's appearance
    });
  });

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('LoginPage Integration Tests', () {
    testWidgets('Verify form validation and submission', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to the LoginPage
      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();

      // Test form validation and submission
      // You can use the tester.enterText() and tester.tap() methods to interact with the form fields and buttons
      await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'test@example.com');
      await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'password');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      // Verify navigation to the company page upon successful submission
      expect(find.text('Company Page'), findsOneWidget); // Assuming the company page contains the text "Company Page"
    });
  });

  group('LoginPage Acceptance Tests', () {
    testWidgets('Verify end-to-end flow for logging in', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to the LoginPage
      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();

      // Perform the end-to-end flow of filling out the form and logging in
      // Verify the user experience and expected results
      await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'test@example.com');
      await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'password');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      // Verify navigation to the company page upon successful submission
      expect(find.text('Company Page'), findsOneWidget); // Assuming the company page contains the text "Company Page"
    });
  });
}
