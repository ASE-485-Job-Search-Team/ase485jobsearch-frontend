class RegisterRequestModel {
  RegisterRequestModel({
    required this.email,
    required this.password,
    required this.isAdmin,
  });

  late final String email;
  late final String password;
  late final bool isAdmin;

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    _data['isAdmin'] = isAdmin;
    return _data;
  }
}
