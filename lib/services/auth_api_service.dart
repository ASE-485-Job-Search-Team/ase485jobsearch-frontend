import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jobsearchmobile/models/auth/login_request.dart';
import 'package:jobsearchmobile/models/auth/login_response.dart';
import 'package:jobsearchmobile/models/auth/register_company_request.dart';
import 'package:jobsearchmobile/models/auth/register_company_response.dart';
import 'package:jobsearchmobile/models/auth/register_request.dart';
import 'package:jobsearchmobile/models/auth/register_response.dart';
import 'package:jobsearchmobile/services/auth_shared_service.dart';

import '../constants/api.dart';

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

    var url = Uri.http(Api.baseUrl, Api.userProfileAPI);

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
}
