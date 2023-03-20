import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:jobsearchmobile/main.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;
import 'package:jobsearchmobile/screens/home/widgets/pie_chart.dart';
import 'package:jobsearchmobile/screens/my_applications/widgets/application_card.dart';
import 'package:mockito/annotations.dart';

Future<void> addDelay(int ms) async {
  await Future<void>.delayed(Duration(milliseconds: ms));
}

@GenerateMocks([http.Client])
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('UserMyApplicationsPage', () {
    testWidgets(
        'end-to-end testing on job application chart overview and a list of job applications user has applied',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      final homeButton = find.text('Home');
      expect(homeButton, findsOneWidget);
      await tester.tap(homeButton);
      await tester.pumpAndSettle();

      await addDelay(500);

      final myApplicationsButton = find.byIcon(Icons.cases_outlined);
      // should show my applications button in the bottom navigation bar
      expect(myApplicationsButton, findsOneWidget);
      await tester.tap(myApplicationsButton);
      await tester.pumpAndSettle();

      await addDelay(500);

      // should navigate to my applications page
      expect(find.text('Overview'), findsOneWidget);
      // should show job application chart
      expect(find.byType(JobApplicationChart), findsOneWidget);
      // should show a list of applications user has applied to
      expect(find.text('My Applications'), findsAtLeastNWidgets(1));
      expect(find.byType(MyApplicationCard), findsWidgets);

      await tester.fling(
          find.byType(SingleChildScrollView), const Offset(0, -100), 2000);
      await tester.pumpAndSettle();

      await addDelay(500);
    });
  });
}
