import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsearchmobile/screens/auth/resume_upload.dart';
import 'package:jobsearchmobile/screens/auth/widgets/resume_upload_button.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';
import 'package:mockito/mockito.dart';


class MockAPIService extends Mock implements APIService {
  @override
  Future<String> getUserProfile() async {
    return jsonEncode({
      'data': {
        'id': 1,
        'first': 'John',
        'last': 'Doe',
        'email': 'johndoe@example.com',
        'resume': 'example.com',
        'isAdmin': false
      }
    });
  }

  @override
  Future<void> uploadResume(int userId) async {
    // do something when the uploadResume method is called
  }
}


void main() {
  group('ResumeUploadPage widget test', () {
    late MockAPIService mockApiService;
    late ResumeUploadPage resumeUploadPage;

    setUp(() {
      mockApiService = MockAPIService();
      resumeUploadPage = ResumeUploadPage();
    });

    testWidgets('Widget should render with CircularProgressIndicator while data is loading', (WidgetTester tester) async {
      when(mockApiService.getUserProfile()).thenAnswer((_) => Future.delayed(Duration(seconds: 1), () => jsonEncode({'data': {'isAdmin': false}})));

      await tester.pumpWidget(MaterialApp(home: resumeUploadPage));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Widget should render with ResumeUploadButton if data is loaded and user is not admin', (WidgetTester tester) async {
      when(mockApiService.getUserProfile()).thenAnswer((_) => Future.delayed(Duration(seconds: 1), () => jsonEncode({'data': {'isAdmin': false, 'id': 1, 'first': 'John', 'last': 'Doe', 'email': 'johndoe@example.com', 'resume': 'example.com'}})));

      await tester.pumpWidget(MaterialApp(home: resumeUploadPage));
      await tester.pumpAndSettle();

      expect(find.byType(ResumeUploadButton), findsOneWidget);
    });

    testWidgets('Widget should render with text if data is loaded and user is admin', (WidgetTester tester) async {
      when(mockApiService.getUserProfile()).thenAnswer((_) => Future.delayed(Duration(seconds: 1), () => jsonEncode({'data': {'isAdmin': true, 'id': 1, 'company': 'ABC Corp', 'email': 'admin@example.com'}})));

      await tester.pumpWidget(MaterialApp(home: resumeUploadPage));
      await tester.pumpAndSettle();

      expect(find.text('Please upload your resume'), findsOneWidget);
    });

    testWidgets('Widget should render with error message if error occurs while loading data', (WidgetTester tester) async {
      when(mockApiService.getUserProfile()).thenThrow(Exception('Error loading data'));

      await tester.pumpWidget(MaterialApp(home: resumeUploadPage));
      await tester.pumpAndSettle();

      expect(find.text('Error: Exception: Error loading data'), findsOneWidget);
    });
  });

  group('ResumeUploadButton widget test', () {
    testWidgets('Widget should call APIService.uploadResume method when pressed', (WidgetTester tester) async {
      final mockAPIService = MockAPIService();
      final resumeUploadButton = ResumeUploadButton(userID: "1");

      when(mockAPIService.uploadResume(1)).thenAnswer((_) => Future.value());

      await tester.pumpWidget(MaterialApp(home: resumeUploadButton));
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      verify(mockAPIService.uploadResume(1)).called(1);
    });
  });
}
