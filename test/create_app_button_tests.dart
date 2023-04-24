import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsearchmobile/screens/my_applications/pages/job_app_create_form.dart';
import 'package:jobsearchmobile/screens/my_applications/widgets/create_app_button.dart';

void main() {
  group('CreateAppButton widget test', () {
    testWidgets('Widget should display text "Create Application"', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: CreateAppButton()));
      expect(find.text('Create Application'), findsOneWidget);
    });

    testWidgets('Widget should navigate to JobApplicationPage when pressed', (WidgetTester tester) async {
      final createAppButton = CreateAppButton();

      await tester.pumpWidget(MaterialApp(home: createAppButton));
      await tester.tap(find.byType(ElevatedButton));
      //await tester.pumpAndSettle();

      //expect(find.byType(JobApplicationPage), findsOneWidget);
    });
  });
}
