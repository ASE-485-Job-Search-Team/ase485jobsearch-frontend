import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:jobsearchmobile/models/auth/login_response.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    if (kIsWeb) {
      final userBox = await Hive.openBox('userBox');
      return userBox.containsKey('login_details');
    } else {
      var isCacheKeyExist =
      await APICacheManager().isAPICacheKeyExist("login_details");

      return isCacheKeyExist;
    }
  }

  static Future<LoginResponseModel?> loginDetails() async {
    if (kIsWeb) {
      final userBox = await Hive.openBox('userBox');
      if (userBox.containsKey('login_details')) {
        final cachedData = userBox.get('login_details');
        return LoginResponseModel.fromJson(jsonDecode(cachedData));
      }
      return null;
    } else {
      var isCacheKeyExist =
      await APICacheManager().isAPICacheKeyExist("login_details");

      if (isCacheKeyExist) {
        var cacheData = await APICacheManager().getCacheData("login_details");

        return loginResponseJSON(cacheData.syncData);
      }
    }
  }

  static Future<void> setLoginDetails(
      LoginResponseModel loginResponse,
      ) async {
    if (kIsWeb) {
      final userBox = await Hive.openBox('userBox');
      await userBox.put('login_details', jsonEncode(loginResponse.toJson()));
    } else {
      APICacheDBModel cacheModel = APICacheDBModel(
        key: "login_details",
        syncData: jsonEncode(loginResponse.toJson()),
      );

      await APICacheManager().addCacheData(cacheModel);
    }
  }

  static Future<void> logout(BuildContext context) async {
    if (kIsWeb) {
      final userBox = await Hive.openBox('userBox');
      await userBox.delete('login_details');
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
            (route) => false,
      );
    } else {
      await APICacheManager().deleteCache("login_details");
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/',
            (route) => false,
      );
    }
  }
}
