import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsearchmobile/screens/auth/login.dart';
import 'package:jobsearchmobile/screens/main_layout.dart';
import 'package:jobsearchmobile/models/auth/login_request.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:snippet_coder_utils/hex_color.dart';

class MockClient extends http.BaseClient {
  final http.Client _client = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request);
  }
}

class MockAPIService extends APIService {
  final bool successfulLogin;

  MockAPIService({required this.successfulLogin, required http.BaseClient client}) : super(client: client);

  @override
  Future<bool> login(LoginRequestModel model) async {
    return successfulLogin;
  }
}

void main() {
  group('LoginPage', () {
    testWidgets('renders', (WidgetTester tester) async {
      // Build LoginPage widget
      await tester.pumpWidget(MaterialApp(home: LoginPage(apiService: MockAPIService(successfulLogin: true, client: MockClient()))));

      // Expect to find Login text
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('form can be submitted with valid credentials',
            (WidgetTester tester) async {
          // Build LoginPage widget with a mock APIService that returns true for login
          await tester.pumpWidget(MaterialApp(home: LoginPage(apiService: MockAPIService(successfulLogin: true, client: MockClient()))));

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
          // Build LoginPage widget with a mock APIService that returns false for login
          await tester.pumpWidget(MaterialApp(home: LoginPage(apiService: MockAPIService(successfulLogin: false, client: MockClient()))));

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
