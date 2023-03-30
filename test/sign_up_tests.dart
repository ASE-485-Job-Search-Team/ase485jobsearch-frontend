import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jobsearchmobile/screens/auth/sign_up.dart';
import 'package:jobsearchmobile/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  group('SignUpPage Unit Tests', () {
    testWidgets('displays form elements on the SignUpPage', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignUpPage()));
      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.text('I am a:'), findsOneWidget);
      expect(find.text('Company'), findsOneWidget);
      expect(find.text('Job searcher'), findsOneWidget);
      expect(find.text('Sign up'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    // Add additional unit tests for the widget's behavior
  });

  group('SignUpPage GUI Tests', () {
    testWidgets('displays form elements with correct styles', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignUpPage()));

      // Check if the CustomAppBar is present
      expect(find.byType(AppBar), findsOneWidget);

      // Check if the Email TextFormField is present
      expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);

      // Check if the Password TextFormField is present
      expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);

      // Check if the 'Company' Radio is present
      expect(find.widgetWithText(Radio<bool>, 'Company'), findsOneWidget);

      // Check if the 'Job searcher' Radio is present
      expect(find.widgetWithText(Radio<bool>, 'Job searcher'), findsOneWidget);

      // Check if the ElevatedButton is present
      expect(find.widgetWithText(ElevatedButton, 'Sign up'), findsOneWidget);

      // Add more GUI tests for the widget's appearance
    });
  });

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('SignUpPage Integration Tests', () {
    testWidgets('Verify form validation and submission', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to the SignUpPage
      final signUpButtonFinder = find.text('Sign Up');
      await tester.tap(signUpButtonFinder);
      await tester.pumpAndSettle();

      // Test form validation and submission
      // You can use the tester.enterText() and tester.tap() methods to interact with the form fields and buttons
      await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'test@example.com');
      await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'test123');

      final signUpSubmitButtonFinder = find.widgetWithText(ElevatedButton, 'Sign up');
      await tester.tap(signUpSubmitButtonFinder);
      await tester.pumpAndSettle();

      // Verify navigation to the user page upon successful submission
      expect(find.text('Welcome, User!'), findsOneWidget);
    });
  });
}

