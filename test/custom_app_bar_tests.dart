import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jobsearchmobile/screens/home/user_home_page.dart';
import 'package:jobsearchmobile/screens/home/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

void main() {
  group('CustomAppBar Unit Tests', () {
    testWidgets('CustomAppBar displays title and logo correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(appBar: CustomAppBar(title: "Test Title"))));

      final titleFinder = find.text('Test Title');
      final appBarFinder = find.byType(AppBar);

      expect(appBarFinder, findsOneWidget);
      expect(titleFinder, findsOneWidget);

      final appBar = tester.widget<AppBar>(appBarFinder);
      expect(appBar.backgroundColor, Color(0xFF2c3a6d));

      final titleText = tester.widget<Text>(titleFinder);
      expect(titleText.style!.fontSize, 20);
      expect(find.byType(Image), findsOneWidget);
    });
  });

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('CustomAppBar Integration Tests', () {
    testWidgets('CustomAppBar is present on the home screen', (WidgetTester tester) async {
      await tester.pumpWidget(UserHomePage());
      await tester.pumpAndSettle();

      expect(find.byType(CustomAppBar), findsOneWidget);
    });
  });

  group('CustomAppBar Regression Tests', () {
    testWidgets('Verify CustomAppBar appearance and functionality after changes', (WidgetTester tester) async {
      await tester.pumpWidget(UserHomePage());
      await tester.pumpAndSettle();

      expect(find.byType(CustomAppBar), findsOneWidget);

      // Add any additional tests to ensure that the appearance and functionality of the CustomAppBar remain as expected after changes
      // ...
    });
  });
}
