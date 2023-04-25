import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsearchmobile/models/auth/create_company_request.dart';
import 'package:jobsearchmobile/models/auth/register_company_request.dart';
import 'package:jobsearchmobile/screens/auth/sign_up_company.dart';
import 'package:mockito/mockito.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import 'mocks/mock_api_service.dart';

void main() {
  group('SignUpCompanyPage', () {
      testWidgets('SignUpCompanyPage should render correctly', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: SignUpCompanyPage()));

        // Check if the logo is displayed
        expect(find.byType(Image), findsOneWidget);

        // Check if the Company input field is displayed
        expect(find.text('Company'), findsOneWidget);

        // Check if the Email input field is displayed
        expect(find.text('Email'), findsOneWidget);

        // Check if the Password input field is displayed
        expect(find.text('Password'), findsOneWidget);

        // Check if the Register button is displayed
        expect(find.text('Register'), findsOneWidget);

        // Check if the "OR" text is displayed
        expect(find.text('OR'), findsOneWidget);

        // Check if the Sign in link is displayed
        expect(find.text('Sign in'), findsOneWidget);
      });
      testWidgets('SignUpCompanyPage should validate user input correctly', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: SignUpCompanyPage()));

        // Try registering with empty fields
        await tester.tap(find.text('Register'));
        await tester.pump();

        expect(find.text('Company can\'t be empty.'), findsOneWidget);
        expect(find.text('Email can\'t be empty.'), findsOneWidget);
        expect(find.text('Password can\'t be empty.'), findsOneWidget);

        // Try registering with invalid email format
        await tester.enterText(find.byType(TextFormField).at(1), 'invalidemail');
        await tester.tap(find.text('Register'));
        await tester.pump();

        expect(find.text('Invalid email format.'), findsOneWidget);

        // Try registering with valid input
        await tester.enterText(find.byType(TextFormField).at(0), 'My Company');
        await tester.enterText(find.byType(TextFormField).at(1), 'test@example.com');
        await tester.enterText(find.byType(TextFormField).at(2), 'mypassword');
        await tester.tap(find.text('Register'));
        await tester.pump();

        // Check if the loading indicator is displayed
        expect(find.byType(ProgressHUD), findsOneWidget);
      });
      testWidgets('SignUpCompanyPage should call the correct API methods on register button click', (WidgetTester tester) async {
        final apiService = MockAPIService();
        when(apiService.registerCompany(any)).thenAnswer((_) async => ApiResponse(data: Company()));
        when(apiService.createCompanyForFb(any)).thenAnswer((_) async => ApiResponse(post: 'success'));

        await tester.pumpWidget(MaterialApp(home: SignUpCompanyPage()));

        await tester.enterText(find.byType(TextFormField).at(0), 'My Company');
        await tester.enterText(find.byType(TextFormField).at(1), 'test@example.com');
        await tester.enterText(find.byType(TextFormField).at(2), 'mypassword');

        await tester.tap(find.text('Register'));
        await tester.pump();

        // Check if the correct API methods are called with the correct parameters
        verify(apiService.registerCompany(argThat(isA<RegisterRequestCompanyModel>()))).called(1);
        verify(apiService.createCompanyForFb(argThat(isA<CreateCompanyRequestModel>()))).called(1);
      });
  });
}