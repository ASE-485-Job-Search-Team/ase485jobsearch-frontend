import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsearchmobile/screens/auth/resume_upload.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'mocks/mock_api_service.dart';

@GenerateMocks([APIService])
void main() {
  group('Resume Upload Page Tests', () {
    testWidgets('Renders loading indicator while user data is being fetched', (WidgetTester tester) async {
      final mockAPIService = MockAPIService();
      when(mockAPIService.getUserProfile())
          .thenAnswer((_) async => Future.delayed(Duration(seconds: 1), () => ''));

      await tester.pumpWidget(MaterialApp(home: ResumeUploadPage()));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Displays upload button when user is fetched', (WidgetTester tester) async {
      final mockAPIService = MockAPIService();
      when(mockAPIService.getUserProfile()).thenAnswer((_) async {
        return jsonEncode({
          'data': {
            'id': '1',
            'first': 'John',
            'last': 'Doe',
            'email': 'john.doe@example.com',
            'resume': 'resume.pdf',
            'isAdmin': false,
          },
        });
      });

      await tester.pumpWidget(MaterialApp(home: ResumeUploadPage()));
      await tester.pumpAndSettle();

      expect(find.text('Please upload your resume'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Displays error when an error occurs while fetching user data', (WidgetTester tester) async {
      final mockAPIService = MockAPIService();
      when(mockAPIService.getUserProfile()).thenThrow(Exception('Failed to load user data'));

      await tester.pumpWidget(MaterialApp(home: ResumeUploadPage()));
      await tester.pumpAndSettle();

      expect(find.text('Error: Failed to load user data'), findsOneWidget);
    });
  });
}
