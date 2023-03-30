import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jobsearchmobile/screens/landing_page/landing_page.dart';
import 'package:jobsearchmobile/main.dart' as app;

void main() {
  group('LandingPage Unit Tests', () {
    testWidgets('displays buttons on the LandingPage', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LandingPage()));
      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.text('Log In'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
    });
  });
  group('LandingPage GUI Tests', () {
    testWidgets('displays buttons with correct styles', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LandingPage()));
      final buttonFinder = find.byType(ElevatedButton);
      expect(buttonFinder, findsNWidgets(3));

      final signUpButton = tester.widget<ElevatedButton>(find.widgetWithText(ElevatedButton, 'Sign Up'));
      final logInButton = tester.widget<ElevatedButton>(find.widgetWithText(ElevatedButton, 'Log In'));
      final homeButton = tester.widget<ElevatedButton>(find.widgetWithText(ElevatedButton, 'Home'));

      expect(signUpButton.style!.backgroundColor!.resolve({}), Color(0xFF2c3a6d));
      expect(logInButton.style!.backgroundColor!.resolve({}), Color(0xFF2c3a6d));
      expect(homeButton.style!.backgroundColor!.resolve({}), Color(0xFF2c3a6d));
    });
  });

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('LandingPage Integration Tests', () {
    testWidgets('Verify navigation from LandingPage to other pages', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to the LandingPage
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Click the Sign Up button and verify navigation to the sign-up page
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();
      expect(find.text('Sign Up Page'), findsOneWidget); // Assuming the sign-up page contains the text "Sign Up Page"

      // Go back to the LandingPage
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Click the Log In button and verify navigation to the login page
      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();
      expect(find.text('Log In Page'), findsOneWidget); // Assuming the login page contains the text "Log In Page"

      // Go back to the LandingPage
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Click the Home button and verify navigation to the home page
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.text('Home Page'), findsOneWidget); // Assuming the home page contains the text "Home Page"
    });
  });

  group('LandingPage Acceptance Tests', () {
    testWidgets('Verify end-to-end flow from LandingPage to other pages', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to the LandingPage
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Click the Sign Up button and verify navigation to the sign-up page
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();
      expect(find.text('Sign Up Page'), findsOneWidget); // Assuming the sign-up page contains the text "Sign Up Page"

      // Go back to the LandingPage
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Click the Log In button and verify navigation to the login page
      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();
      expect(find.text('Log In Page'), findsOneWidget); // Assuming the login page contains the text "Log In Page"

      // Go back to the LandingPage
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Click the Home button and verify navigation to the home page
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.text('Home Page'), findsOneWidget); // Assuming the home page contains the text "Home Page"
    });
  });
}
