class UpdateResumeFBRequestModel {
  UpdateResumeFBRequestModel({
    required this.userId,
    required this.resumeId,
  });

  late final String userId;
  late final String resumeId;

  UpdateResumeFBRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    resumeId = json['resumeId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['resumeId'] = resumeId;
    return _data;
  }
}
