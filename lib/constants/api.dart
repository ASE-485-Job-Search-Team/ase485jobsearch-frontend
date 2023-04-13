class Api {
  static const String baseUrl = 'http://localhost:5050/api';
  static const String jobPostingsUrl = '$baseUrl/jobs/job-postings';

  static const String appName = "JobHive";
  static const String authUrl = 'localhost:3000';
  static const String loginAPI = "/api/auth/login";
  static const String registerAPI = "/api/auth/register/user";
  static const String registerCompnayAPI = "/api/auth/register/admin";
  static const String userProfileAPI = "/api/profile";
  static const String updateUserResumeAPI = "api/update/user/resume";
}
