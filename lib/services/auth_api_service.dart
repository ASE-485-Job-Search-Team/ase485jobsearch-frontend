import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jobsearchmobile/models/auth/create_user_response.dart';
import 'package:jobsearchmobile/models/auth/login_request.dart';
import 'package:jobsearchmobile/models/auth/login_response.dart';
import 'package:jobsearchmobile/models/auth/register_company_request.dart';
import 'package:jobsearchmobile/models/auth/register_company_response.dart';
import 'package:jobsearchmobile/models/auth/register_request.dart';
import 'package:jobsearchmobile/models/auth/register_response.dart';
import 'package:jobsearchmobile/models/auth/update_resume_fb_request.dart';
import 'package:jobsearchmobile/models/auth/update_resume_fb_response.dart';
import 'package:jobsearchmobile/models/auth/update_resume_md_request.dart';
import 'package:jobsearchmobile/models/auth/update_resume_md_response.dart';
import 'package:jobsearchmobile/services/auth_shared_service.dart';

import '../constants/api.dart';
import '../models/auth/create_user_request.dart';
import '../models/user.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Api.authUrl,
      Api.loginAPI,
    );
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(loginResponseJSON(response.body));
      return true;
    } else {
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
    RegisterRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Api.authUrl,
      Api.registerAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return registerResponseJSON(response.body);
  }

  static Future<RegisterResponseCompanyModel> registerCompany(
    RegisterRequestCompanyModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Api.authUrl,
      Api.registerCompnayAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return registerCompanyResponseJSON(response.body);
  }

  static Future<String> getUserProfile() async {
    LoginResponseModel? loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data?.token}'
    };

    var url = Uri.http(Api.authUrl, Api.userProfileAPI);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  static Future<User> loadUserData() async {
    late User user;
    String response = await APIService.getUserProfile();

    final model = jsonDecode(response);
    final isAdmin = model['data']['isAdmin'];

    if (isAdmin) {
      user = User(
        id: model['data']['id'],
        name: model['data']['company'],
        email: model['data']['email'],
        isAdmin: true,
      );
    } else {
      user = User(
        id: model['data']['id'],
        name: model['data']['first'] + ' ' + model['data']['last'],
        email: model['data']['email'],
        resume: model['data']['resume'],
        isAdmin: false,
      );
    }

    return user;
  }

  static Future<CreateUserResponseModel> createUserForFb(CreateUserRequestModel model,) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    const String baseUrl = 'localhost:5050';
    const String createAPI = "/api/users/create";

    var url = Uri.http(
      baseUrl,
      createAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return createUserResponseJSON(response.body);
  }


  static Future<UpdateResumeFBResponseModel> updateResumeFB(UpdateResumeFBRequestModel model,) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    const String baseUrl = 'localhost:5050';
    const String createAPI = "/api/users/update/resume-id";

    var url = Uri.http(
      baseUrl,
      createAPI,
    );

    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return updateResumeFBResponseJSON(response.body);
  }

  static Future<UpdateResumeMDResponseModel> updateResumeMD(UpdateResumeMDRequestModel model,) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    const String baseUrl = 'localhost:3000';
    const String createAPI = "/api/update/user/resume";

    var url = Uri.http(
      baseUrl,
      createAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return updateResumeMDResponseJSON(response.body);
  }

}
