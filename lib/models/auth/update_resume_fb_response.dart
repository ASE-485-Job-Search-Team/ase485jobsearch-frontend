import 'dart:convert';

UpdateResumeFBResponseModel updateResumeFBResponseJSON(String str) =>
    UpdateResumeFBResponseModel.fromJson(json.decode(str));

class UpdateResumeFBResponseModel {
  UpdateResumeFBResponseModel({
    required this.put
  });
  late final String put;

  UpdateResumeFBResponseModel.fromJson(Map<String, dynamic> json){
    put = json['put'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['put'] = put;
    return _data;
  }
}
