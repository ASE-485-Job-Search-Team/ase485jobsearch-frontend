class CreateUserRequestModel {
  CreateUserRequestModel({
    required this.userId,
    required this.fullName,
  });

  late final String userId;
  late final String fullName;

  CreateUserRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['fullName'] = fullName;
    return _data;
  }
}
