class UpdateUserRequestModel {
  UpdateUserRequestModel({
    required this.id,
    required this.resumeId,
  });

  late final String id;
  late final String resumeId;

  UpdateUserRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resumeId = json['resumeId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['resumeId'] = resumeId;
    return _data;
  }
}
