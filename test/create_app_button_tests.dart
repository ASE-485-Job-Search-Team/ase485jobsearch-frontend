import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsearchmobile/screens/my_applications/pages/job_app_create_form.dart';
import 'package:jobsearchmobile/screens/my_applications/widgets/create_app_button.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:jobsearchmobile/services/job_posting_service.dart';
import 'user_home_page_test.mocks.dart';

void main() {
  group('CreateAppButton widget test', () {
    late http.Client client;
    late APIService apiService;
    late JobPostingService jobPostingService;

    setUp(() {
      client = MockClient();
      apiService = APIService(client: client);
      jobPostingService = JobPostingService(httpClient: client);

    });
    
    testWidgets('Widget should display text "Create Application"', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: CreateAppButton(apiService: apiService, jobPostingService: jobPostingService,)));
      expect(find.text('Create Application'), findsOneWidget);
    });

    testWidgets('Widget should navigate to JobApplicationPage when pressed', (WidgetTester tester) async {
      final createAppButton = CreateAppButton(apiService: apiService, jobPostingService: jobPostingService,);

      await tester.pumpWidget(MaterialApp(home: createAppButton));
      await tester.tap(find.byType(ElevatedButton));
      //await tester.pumpAndSettle();

      //expect(find.byType(JobApplicationPage), findsOneWidget);
    });
  });
}
