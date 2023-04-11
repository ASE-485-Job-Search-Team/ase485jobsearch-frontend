import 'dart:convert';

UpdateUserResponseModel updateUserResponseJSON(String str) =>
    UpdateUserResponseModel.fromJson(json.decode(str));

class UpdateUserResponseModel {
  UpdateUserResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data? data;

  UpdateUserResponseModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    data = json['data'] != null? Data.fromJson(json['data']) : null;
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
    required this.first,
    required this.last,
    required this.email,
    required this.date,
    required this.id,
  });
  late final String first;
  late final String last;
  late final String email;
  late final String date;
  late final String resumeId;
  late final String id;

  Data.fromJson(Map<String, dynamic> json){
    first = json['first'];
    last = json['last'];
    email = json['email'];
    date = json['date'];
    resumeId = json['resumeId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first'] = first;
    _data['last'] = last;
    _data['email'] = email;
    _data['date'] = date;
    _data['resumeId'] = resumeId;
    _data['id'] = id;
    return _data;
  }
}