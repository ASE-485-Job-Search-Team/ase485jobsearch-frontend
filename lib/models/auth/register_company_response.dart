import 'dart:convert';

RegisterResponseCompanyModel registerCompanyResponseJSON(String str) =>
    RegisterResponseCompanyModel.fromJson(json.decode(str));

class RegisterResponseCompanyModel {
  RegisterResponseCompanyModel({
    required this.message,
    required this.data,
  });

  late final String message;
  late final Data? data;

  RegisterResponseCompanyModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.company,
    required this.email,
    required this.date,
    required this.id,
  });

  late final String company;
  late final String email;
  late final String date;
  late final String id;

  Data.fromJson(Map<String, dynamic> json) {
    company = json['company'];
    email = json['email'];
    date = json['date'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['company'] = company;
    _data['email'] = email;
    _data['date'] = date;
    _data['id'] = id;
    return _data;
  }
}
