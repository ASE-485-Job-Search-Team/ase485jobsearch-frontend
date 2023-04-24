import 'package:mockito/mockito.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';

import 'package:mockito/mockito.dart';
import 'package:jobsearchmobile/services/auth_api_service.dart';
import 'package:jobsearchmobile/services/job_posting_service.dart';
import 'package:http/http.dart' as http;

class MockAPIService extends Mock implements APIService {}

class MockJobPostingService extends Mock implements JobPostingService {
  // Define the behavior of the getUserProfile method
  Future<String> getUserProfile() async {
    return super.noSuchMethod(
      Invocation.method(#getUserProfile, []),
      returnValue: Future.value('{"data": {"id": "123", "first": "John", "last": "Doe", "email": "john.doe@example.com", "resume": "resume.pdf", "isAdmin": false}}'),
    );
  }
}
