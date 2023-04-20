import 'dart:convert';

CreateUserResponseModel createUserResponseJSON(String str) =>
    CreateUserResponseModel.fromJson(json.decode(str));

class CreateUserResponseModel {
  CreateUserResponseModel({
    required this.post
  });
  late final String post;

  CreateUserResponseModel.fromJson(Map<String, dynamic> json){
    post = json['post'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['post'] = post;
    return _data;
  }
}
