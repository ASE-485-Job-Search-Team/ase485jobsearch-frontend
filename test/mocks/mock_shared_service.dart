import 'package:mockito/mockito.dart';
import 'package:jobsearchmobile/services/auth_shared_service.dart';

class MockSharedService extends Mock implements SharedService {
  // Define the behavior of the isLoggedIn method
  Future<bool> isLoggedIn() async {
    return super.noSuchMethod(
      Invocation.method(#isLoggedIn, []),
      returnValue: Future.value(false),
    );
  }
}
