import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsearchmobile/screens/auth/sign_up.dart';

void main() {
  group('SignUpPage', () {
    testWidgets('shows "Register" text', (WidgetTester tester) async {
      await tester.pumpWidget(SignUpPage());

      expect(find.text('Register'), findsOneWidget);
    });

    testWidgets('shows form fields', (WidgetTester tester) async {
      await tester.pumpWidget(SignUpPage());

      expect(find.text('First'), findsOneWidget);
      expect(find.text('Last'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('shows "Sign in" text', (WidgetTester tester) async {
      await tester.pumpWidget(SignUpPage());

      expect(find.text('Already have an account?'), findsOneWidget);
      expect(find.text('Sign in'), findsOneWidget);
    });

    testWidgets('validates form fields', (WidgetTester tester) async {
      await tester.pumpWidget(SignUpPage());

      // Submit form with empty fields
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.text('First Name can\'t be empty.'), findsOneWidget);
      expect(find.text('Last Name can\'t be empty.'), findsOneWidget);
      expect(find.text('Email can\'t be empty.'), findsOneWidget);
      expect(find.text('Password can\'t be empty.'), findsOneWidget);

      // Enter valid data into fields
      await tester.enterText(find.byType(TextFormField).at(0), 'John');
      await tester.enterText(find.byType(TextFormField).at(1), 'Doe');
      await tester.enterText(find.byType(TextFormField).at(2), 'john.doe@example.com');
      await tester.enterText(find.byType(TextFormField).at(3), 'password123');

      // Submit form with valid data
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.text('Register'), findsOneWidget);
      expect(find.text('First'), findsOneWidget);
      expect(find.text('Last'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });
  });
}
