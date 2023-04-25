import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsearchmobile/screens/auth/login.dart';
import 'package:jobsearchmobile/screens/main_layout.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';
import 'package:snippet_coder_utils/hex_color.dart';


void main() {
  group('LoginPage', () {
    testWidgets('renders', (WidgetTester tester) async {
      // Build LoginPage widget
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      // Expect to find Login text
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('form can be submitted with valid credentials',
            (WidgetTester tester) async {
          // Mock APIService.login method to return true
          APIService.login = (model) async => true;

          // Build LoginPage widget
          await tester.pumpWidget(MaterialApp(home: LoginPage()));

          // Fill in email and password fields
          await tester.enterText(
              find.widgetWithText(TextFormField, 'Email'), 'test@test.com');
          await tester.enterText(
              find.widgetWithText(TextFormField, 'Password'), 'password');

          // Tap submit button
          await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
          await tester.pump();

          // Expect to navigate to '/home' route
          expect(find.byType(LoginPage), findsNothing);
          expect(find.byType(MainAppLayout), findsOneWidget);
        });

    testWidgets('form cannot be submitted with invalid credentials',
            (WidgetTester tester) async {
          // Mock APIService.login method to return false
          APIService.login = (model) async => false;

          // Build LoginPage widget
          await tester.pumpWidget(MaterialApp(home: LoginPage()));

          // Fill in email and password fields with invalid values
          await tester.enterText(
              find.widgetWithText(TextFormField, 'Email'), 'invalid-email');
          await tester.enterText(
              find.widgetWithText(TextFormField, 'Password'), 'short');

          // Tap submit button
          await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
          await tester.pump();

          // Expect to show error alert dialog
          expect(find.text('Invalid Username/Password !!'), findsOneWidget);
        });
  });
}
