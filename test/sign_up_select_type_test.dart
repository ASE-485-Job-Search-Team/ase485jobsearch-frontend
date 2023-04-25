import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsearchmobile/screens/auth/sign_up.dart';
import 'package:jobsearchmobile/screens/auth/sign_up_company.dart';
import 'package:jobsearchmobile/screens/auth/sign_up_select_type.dart';
import 'package:jobsearchmobile/screens/home/widgets/custom_app_bar.dart';

void main() {
  group('SelectTypePage widget test', () {
    testWidgets('Page should have a custom app bar with title', (WidgetTester tester) async {
      // Build the SelectTypePage widget
      await tester.pumpWidget(MaterialApp(home: SelectTypePage()));

      // Check if the page has a custom app bar widget
      final customAppBarFinder = find.byType(CustomAppBar);
      expect(customAppBarFinder, findsOneWidget);

      // Check if the custom app bar has a title "Select Type"
      final customAppBarTitleFinder = find.text('Select Type');
      expect(customAppBarTitleFinder, findsOneWidget);
    });

    testWidgets('Page should have two elevated buttons for selecting type', (WidgetTester tester) async {
      // Build the SelectTypePage widget
      await tester.pumpWidget(MaterialApp(home: SelectTypePage()));

      // Check if the page has two elevated button widgets
      final elevatedButtonFinder = find.byType(ElevatedButton);
      expect(elevatedButtonFinder, findsNWidgets(2));

      // Check if the first elevated button has the text "Individual"
      final individualButtonFinder = find.widgetWithText(ElevatedButton, 'Individual');
      expect(individualButtonFinder, findsOneWidget);

      // Check if the second elevated button has the text "Company"
      final companyButtonFinder = find.widgetWithText(ElevatedButton, 'Company');
      expect(companyButtonFinder, findsOneWidget);
    });

    testWidgets('Tapping on the "Individual" button should navigate to sign up page', (WidgetTester tester) async {
      // Build the SelectTypePage widget
      await tester.pumpWidget(MaterialApp(home: SelectTypePage()));

      // Tap on the "Individual" button
      final individualButtonFinder = find.widgetWithText(ElevatedButton, 'Individual');
      await tester.tap(individualButtonFinder);
      await tester.pumpAndSettle();

      // Check if the app navigated to sign up page
      expect(find.byType(SignUpPage), findsOneWidget);
    });

    testWidgets('Tapping on the "Company" button should navigate to sign up company page', (WidgetTester tester) async {
      // Build the SelectTypePage widget
      await tester.pumpWidget(MaterialApp(home: SelectTypePage()));

      // Tap on the "Company" button
      final companyButtonFinder = find.widgetWithText(ElevatedButton, 'Company');
      await tester.tap(companyButtonFinder);
      await tester.pumpAndSettle();

      // Check if the app navigated to sign up company page
      expect(find.byType(SignUpCompanyPage), findsOneWidget);
    });
  });
}
