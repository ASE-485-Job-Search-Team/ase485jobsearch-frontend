import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:jobsearchmobile/main.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;
import 'package:jobsearchmobile/screens/home/widgets/job_detail.dart';
import 'package:jobsearchmobile/screens/home/widgets/job_info_item.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';
import 'package:mockito/annotations.dart';

Future<void> addDelay(int ms) async {
  await Future<void>.delayed(Duration(milliseconds: ms));
}

@GenerateMocks([http.Client])
void main() {
  late APIService apiService;

  setUp(() {
    apiService = APIService(client: http.Client);
  });

  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('UserHomePage', () {
    testWidgets('end-to-end testing', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(apiService: apiService,));
      final homeButton = find.text('Home');
      expect(homeButton, findsOneWidget);
      await tester.tap(homeButton);
      await tester.pumpAndSettle();

      expect(find.text('Recommended to you'), findsOneWidget);
      expect(find.text('New job postings'), findsOneWidget);
      expect(find.text('Popular job postings'), findsOneWidget);

      // should show job postings
      expect(find.byType(ListView), findsWidgets);

      // should show job posting cards
      expect(find.byType(JobInfoItem), findsAtLeastNWidgets(1));

      await addDelay(2000);

      // click on a job posting card to see detail
      final chip = find.byType(Chip).first;
      await tester.tap(chip);
      await tester.pumpAndSettle();

      // should show job detail page
      expect(find.byType(JobDetail), findsOneWidget);
      expect(find.text('Apply'), findsOneWidget);

      await addDelay(2000);

      // click on apply button
      final applyButton = find.text('Apply');
      await tester.tap(applyButton);
      await tester.pumpAndSettle();

      // should show job application page
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Application Submitted!'), findsOneWidget);

      await addDelay(2000);
    });

    testWidgets('should show job postings', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(apiService: apiService,));
      final homeButton = find.text('Home');
      expect(homeButton, findsOneWidget);
      await tester.tap(homeButton);
      await tester.pumpAndSettle();

      expect(find.text('Recommended to you'), findsOneWidget);
      expect(find.text('New job postings'), findsOneWidget);
      expect(find.text('Popular job postings'), findsOneWidget);

      // should show job postings
      expect(find.byType(ListView), findsWidgets);

      // should show job posting cards
      expect(find.byType(JobInfoItem), findsAtLeastNWidgets(1));
    });

    testWidgets('should show job details', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(apiService: apiService,));
      final homeButton = find.text('Home');
      expect(homeButton, findsOneWidget);
      await tester.tap(homeButton);
      await tester.pumpAndSettle();

      // click on a job posting card to see detail
      final chip = find.byType(Chip).first;
      await tester.tap(chip);
      await tester.pumpAndSettle();

      // should show job detail page
      expect(find.byType(JobDetail), findsOneWidget);
      expect(find.text('Apply'), findsOneWidget);
    });

    testWidgets('should show feedback after submitting application',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(apiService: apiService,));
      final homeButton = find.text('Home');
      expect(homeButton, findsOneWidget);
      await tester.tap(homeButton);
      await tester.pumpAndSettle();

      // click on a job posting card to see detail
      final chip = find.byType(Chip).first;
      await tester.tap(chip);
      await tester.pumpAndSettle();

      // click on apply button
      final applyButton = find.text('Apply');
      await tester.tap(applyButton);
      await tester.pumpAndSettle();

      // should show job application page
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Application Submitted!'), findsOneWidget);
    });
  });
}
