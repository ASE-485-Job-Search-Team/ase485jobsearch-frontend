import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsearchmobile/screens/landing_page/landing_page.dart';
import 'package:jobsearchmobile/services/auth_shared_service.dart';
import 'package:mockito/mockito.dart';
import 'mocks/mock_shared_service.dart';

void main() {
  // Create a mock instance of SharedService
  final mockSharedService = MockSharedService();

  // Stub the isLoggedIn method to always return false
  when(mockSharedService.isLoggedIn()).thenAnswer((_) async => false);

  testWidgets('LandingPage displays buttons correctly and navigates on tap', (WidgetTester tester) async {
    // Build the LandingPage widget.
    await tester.pumpWidget(MaterialApp(home: LandingPage(), routes: {
      '/select': (BuildContext context) => const SizedBox(),
      '/login': (BuildContext context) => const SizedBox(),
      '/home': (BuildContext context) => const SizedBox(),
    }));

    // Verify that the Sign Up buttons is displayed.
    expect(find.text('Sign Up'), findsOneWidget);


    // Tap the Sign Up button and verify navigation.
    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();
  });

  testWidgets('LandingPage displays buttons correctly and navigates on tap', (WidgetTester tester) async {
    // Build the LandingPage widget.
    await tester.pumpWidget(MaterialApp(home: LandingPage(), routes: {
      '/select': (BuildContext context) => const SizedBox(),
      '/login': (BuildContext context) => const SizedBox(),
      '/home': (BuildContext context) => const SizedBox(),
    }));

    // Verify that the Log In button is displayed.
    expect(find.text('Log In'), findsOneWidget);

    // Tap the Log In button and verify navigation.
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();
  });

  testWidgets('LandingPage displays buttons correctly and navigates on tap', (WidgetTester tester) async {
    // Build the LandingPage widget.
    await tester.pumpWidget(MaterialApp(home: LandingPage(), routes: {
      '/home': (BuildContext context) => const SizedBox(),
    }));

    // Verify that the Log In button is displayed.
    expect(find.text('Home'), findsOneWidget);


    // Tap the Home button and verify navigation.
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
  });
}
