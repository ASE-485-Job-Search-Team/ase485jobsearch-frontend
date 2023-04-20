import 'dart:convert';

UpdateResumeFBResponseModel updateResumeFBResponseJSON(String str) =>
    UpdateResumeFBResponseModel.fromJson(json.decode(str));

class UpdateResumeFBResponseModel {
  UpdateResumeFBResponseModel({
    required this.post
  });
  late final String post;

  UpdateResumeFBResponseModel.fromJson(Map<String, dynamic> json){
    post = json['post'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['post'] = post;
    return _data;
  }
}
