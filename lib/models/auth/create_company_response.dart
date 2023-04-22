import 'dart:convert';

CreateCompanyResponseModel createCompanyResponseJSON(String str) =>
    CreateCompanyResponseModel.fromJson(json.decode(str));

class CreateCompanyResponseModel {
  CreateCompanyResponseModel({
    required this.post
  });
  late final String post;

  CreateCompanyResponseModel.fromJson(Map<String, dynamic> json){
    post = json['post'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['post'] = post;
    return _data;
  }
}
